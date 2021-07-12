// @dart=2.9
import 'dart:io';
import 'package:bullet_journal/database/db_journey.dart';
import 'package:bullet_journal/edit_image/utils.dart';
import 'package:bullet_journal/journey/journey_edit/journey_edit_viewmodel.dart';
import 'package:bullet_journal/model/journal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class JourneyEditView extends StatefulWidget {
  int _state;
  JourneyDB _journeyDB;
  JourneyEditView(int state, JourneyDB journeyDB, {Key key}) : super(key: key) {
    this._state = state;
    this._journeyDB = journeyDB;
  }

  @override
  _JourneyEditViewState createState() => _JourneyEditViewState();
}

Size _size;
List<String> _images = [];
JourneyEditViewModel _journeyEditViewModel;
Box<JourneyDB> _journeyBox;

File file;
// //  List<String> _texts = [];
//                               String _text;
List<Asset> _assets = [];
List<JournalItem> _journalItems = [];
List<String> _texts = [];
String _text;
TextEditingController _textEditingController;
FocusNode _focusNode;

bool _isEdit = false;

class _JourneyEditViewState extends State<JourneyEditView> {
  @override
  void initState() {
    _journeyBox = Hive.box<JourneyDB>('journeys');
    _journeyEditViewModel = JourneyEditViewModel();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    if (widget._state == 2) file = File(widget._journeyDB.jouneyImage);
    // _journalItem.add(item);
    _journeyEditViewModel
        .initNoteData(widget._journeyDB, widget._state, _images)
        .then((value) => setState(() {
              print('44> image lenght: ' + _images.length.toString());
            }));
    print('state>49' + widget._state.toString());
    super.initState();
  }

  @override
  void dispose() {
    file = null;
    _isEdit = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    print('reload');
    _journalItems.forEach((element) {
      print(element.toString());
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              _journeyEditViewModel.saveJouney(_journeyBox, file.path,
                  widget._state, widget._journeyDB, _images);
              widget._state = 2;
            },
            icon: Icon(
              Icons.save_sharp,
              color: Colors.black,
            ),
          ),
        ],
        elevation: 1,
      ),
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: Container(
                height: _size.height * 2,
                width: _size.width,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(_size.width * 0.02),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      TextFormField(
                        minLines: 1,
                        maxLines: 1,
                        initialValue: widget._journeyDB.journeyTitle,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Địa điểm',
                            hintStyle: GoogleFonts.nunitoSans(
                              color: Colors.red.withOpacity(0.3),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        style: GoogleFonts.nunitoSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[400]),
                        onChanged: (value) {
                          widget._journeyDB.journeyTitle = value;
                        },
                      ),
                      InkWell(
                        onTap: () async {
                          PickedFile pickedfile = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          if (pickedfile == null) {
                            return;
                          }
                          file = File(pickedfile.path);
                          setState(() {});
                        },
                        child: Container(
                          height: _size.height * 0.3,
                          width: _size.width,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(_size.height * 0.03),
                            border: Border.all(
                                color: file != null
                                    ? Colors.transparent
                                    : Colors.red[400]),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(_size.width * 0.02),
                                child: Text(
                                  '+ Nhấn để thêm hình ảnh',
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.red.withOpacity(0.3),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: _size.height * 0.3,
                                    width: _size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          _size.height * 0.03),
                                      child: file != null
                                          ? Image.file(
                                              file,
                                              fit: BoxFit.cover,
                                            )
                                          : SvgPicture.asset(
                                              'assets/icons/insert-picture-icon.svg',
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              height: _size.height * 0.3,
                                              width: _size.width,
                                            ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      TextFormField(
                        minLines: 1,
                        maxLines: 10,
                        initialValue: widget._journeyDB.journeyContent,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Mô tả',
                            hintStyle: GoogleFonts.nunitoSans(
                                fontSize: 16, color: Colors.grey)),
                        style: GoogleFonts.nunitoSans(fontSize: 16),
                        onChanged: (value) {
                          widget._journeyDB.journeyContent = value;
                        },
                      ),
                      Divider(
                        // indent: 20,
                        // endIndent: 20,
                        color: Colors.black38,
                        thickness: 1,
                      ),
                      ..._journalItems
                          .asMap()
                          .entries
                          .map((e) => _JournalItem(e.value, e.key)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            onTap: () {
                              _isEdit = false;
                              _texts.clear();
                              _assets.clear();
                              showModalBottomSheet(
                                isDismissible: false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(
                                            _size.width * 0.06))),
                                context: context,
                                builder: (context) {
                                  return _AddJouneyItem();
                                },
                              ).then((value) => setState(() {}));
                            },
                            child: Container(
                              // decoration: BoxDecoration(color: Colors.red[300]),
                              child: Text(
                                '>> Thêm hành trình',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )),
                      ),

                      // Container(
                      //   height: _size.height,
                      //   width: _size.width,
                      //   child: ListView.builder(
                      //     itemCount: _journalItems.length,
                      //     itemBuilder: (context, index) {
                      //       return _JournalItem(_journalItems[index], index);
                      //     },
                      //   ),
                      // ),

                      // ..._images
                      //     .asMap()
                      //     .entries
                      //     .map((image) => _addImageWidget(image))
                      //     .toList(),

                      // ..._items.asMap().entries.map((e) => _JouneyItem()),
                      // TextFormField(
                      //   minLines: 1,
                      //   maxLines: 20,
                      //   initialValue: widget._journeyDB.noteContent,
                      //   decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       hintText: 'Nội dung',
                      //       hintStyle: GoogleFonts.nunitoSans(
                      //           color: Colors.grey.withOpacity(0.3),
                      //           fontSize: 18)),
                      //   style: GoogleFonts.nunitoSans(fontSize: 18),
                      //   onChanged: (value) {
                      //     widget._noteDB.noteContent = value;
                      //   },
                      // ),
                      // Expanded(flex: 2, child: buildListViewImage()),
                    ]),
                  ),
                )),
          );
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //     color: Colors.white,
      //     elevation: 0,
      //     child: Container(
      //         margin: EdgeInsets.all(_size.width * 0.05),
      //         height: _size.height * 0.07,
      //         decoration: BoxDecoration(
      //           color: Colors.black,
      //           borderRadius: BorderRadius.circular(20),
      //         ),
      //         child: Row(
      //           mainAxisSize: MainAxisSize.min,
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             IconButton(
      //               onPressed: () async {
      //                 final file = await Utils.pickMedia(
      //                     isGallery: true, cropImage: cropImage);
      //                 if (file == null) {
      //                   return;
      //                 }
      //                 _images.add(file.path);
      //                 setState(() {});
      //               },
      //               icon: Container(
      //                 height: 30,
      //                 width: 30,
      //                 child: SvgPicture.asset(
      //                     'assets/icons/insert-picture-icon.svg',
      //                     color: Colors.white),
      //               ),
      //             ),
      //           ],
      //         )))
    );
  }

  DateTime _selectedDate = DateTime.now();
  Widget _AddJouneyItem() {
    // _initCalender = true;
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        width: _size.width,
        height: _size.height * 0.8,
        margin: EdgeInsets.all(_size.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: _size.width,
                height: _size.height * 0.05,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: _size.width * 0.12,
                        width: _size.width * 0.12,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red[400])),
                        child: IconButton(
                          onPressed: () async {
                            final DateTime datePicked = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2050),
                            );
                            // if (datePicked != null) {
                            //   _initCalender = false;
                            // }

                            if (datePicked != null &&
                                datePicked != _selectedDate) {
                              setState(() {
                                _selectedDate = datePicked;
                              });
                            }
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/menu/black-paper-calendar-with-spring.svg',
                            width: _size.width * 0.05,
                            color: Colors.red[400],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.all(_size.width * 0.02),
                        child: Text(
                          _selectedDate != null
                              ? DateFormat('dd/MM/yyyy').format(_selectedDate)
                              : '',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            loadAssets(setState);
                          },
                          icon: Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.blue,
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            if (_isEdit == false) {
                              print('311>>>>> is add');
                              JournalItem journalItem = JournalItem(
                                  'journalitem' +
                                      _journalItems.length.toString(),
                                  _texts,
                                  _assets,
                                  date: DateFormat('dd/MM/yyyy')
                                      .format(_selectedDate));
                              _journalItems.add(journalItem);
                              _isEdit = true;
                            } else {
                              print('311>>>>> is edit');
                              int index = _journalItems.length - 1;
                              if (_selectedDate != null)
                                _journalItems[index].setDate(
                                    DateFormat('dd/MM/yyyy')
                                        .format(_selectedDate));
                              _journalItems[index].setTexts(_texts);
                              _journalItems[index].setAssets(_assets);
                            }

                            // _journalItems.forEach((element) {
                            //   print(element.toString());
                            // });
                          },
                          icon: Icon(
                            Icons.save,
                            color: Colors.blue,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _size.width * 0.02,
              ),
              Container(
                  width: _size.width,
                  height: _size.height * 0.1,
                  child: TextFormField(
                    style: TextStyle(fontSize: 15),
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (_text.isNotEmpty) {
                              _texts.add(_text);
                              _textEditingController.text = '';
                              _focusNode.unfocus();
                            }
                          });
                        },
                        icon: Icon(Icons.send),
                        color: Colors.blue,
                      ),
                      fillColor: Colors.blue.withOpacity(0.1),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(_size.width * 0.02),
                          borderSide: BorderSide.none),
                      hintText: 'Thêm lịch trình/ Kế hoạch chuyến đi',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.3),
                        // fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                    controller: _textEditingController,
                    onChanged: (value) {
                      setState(() {
                        _text = value;
                      });
                    },
                  )),
              Container(
                width: _size.width,
                height: _size.height * 0.2,
                child: ListView.separated(
                  itemCount: _texts.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 1 / 6,
                      closeOnScroll: true,
                      actions: [
                        IconButton(
                            onPressed: () {
                              _texts.removeAt(index);
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  String editText = '';
                                  return AlertDialog(
                                    title: Text('Chỉnh sửa'),
                                    content: TextFormField(
                                      initialValue: _texts[index],
                                      onChanged: (value) {
                                        editText = value;
                                      },
                                    ),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Hủy')),
                                      FlatButton(
                                          onPressed: () {
                                            _texts[index] = editText;
                                            Navigator.pop(context);
                                          },
                                          child: Text('Lưu')),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                            ))
                      ],
                      child: Container(
                        height: _size.width * 0.1,
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: _size.width * 0.05,
                                    width: _size.width * 0.05,
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.blueAccent.withOpacity(0.2),
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: _size.width * 0.025,
                                    width: _size.width * 0.025,
                                    margin: EdgeInsets.only(
                                        left: _size.width * 0.025 / 2),
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(_size.width * 0.02),
                              child: Text(_texts[index],
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: _size.width * 0.07,
                    );
                  },
                ),
              ),
              SizedBox(
                height: _size.width * 0.02,
              ),
              _AddListAsset(_assets),
              // Container(
              //   width: _size.width,
              //   height: _size.height * 0.2,
              //   color: Colors.red,
              // )
              // Divider(
              //   color: Colors.grey,
              //   thickness: 3,
              // )
            ],
          ),
        ),
      );
    });
  }

  // ignore: non_constant_identifier_names
  // Widget _AddJouneyItem(List<String> _texts, List<Asset> _assets) {
  //   // _initCalender = true;
  //   return StatefulBuilder(builder: (context, setState) {
  //     return Container(
  //       width: _size.width,
  //       height: _size.height * 0.8,
  //       margin: EdgeInsets.all(_size.width * 0.05),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             Container(
  //               width: _size.width,
  //               height: _size.height * 0.05,
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     flex: 1,
  //                     child: Container(
  //                       height: _size.width * 0.12,
  //                       width: _size.width * 0.12,
  //                       decoration: BoxDecoration(
  //                           shape: BoxShape.circle,
  //                           border: Border.all(color: Colors.red[400])),
  //                       child: IconButton(
  //                         onPressed: () async {
  //                           final DateTime datePicked = await showDatePicker(
  //                             context: context,
  //                             initialDate: _selectedDate,
  //                             firstDate: DateTime(2010),
  //                             lastDate: DateTime(2050),
  //                           );
  //                           // if (datePicked != null) {
  //                           //   _initCalender = false;
  //                           // }

  //                           if (datePicked != null &&
  //                               datePicked != _selectedDate) {
  //                             setState(() {
  //                               _selectedDate = datePicked;
  //                             });
  //                           }
  //                         },
  //                         icon: SvgPicture.asset(
  //                           'assets/icons/menu/black-paper-calendar-with-spring.svg',
  //                           width: _size.width * 0.05,
  //                           color: Colors.red[400],
  //                           fit: BoxFit.contain,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex: 7,
  //                     child: Padding(
  //                       padding: EdgeInsets.all(_size.width * 0.02),
  //                       child: Text(
  //                         _selectedDate != null
  //                             ? DateFormat('dd/MM/yyyy').format(_selectedDate)
  //                             : '',
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: IconButton(
  //                         onPressed: () {
  //                           loadAssets(setState, _assets);
  //                         },
  //                         icon: Icon(
  //                           Icons.add_a_photo_rounded,
  //                           color: Colors.blue,
  //                         )),
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: IconButton(
  //                         onPressed: () {
  //                           // print('311>>>>> is add');
  //                           JournalItem journalItem = new JournalItem(
  //                               'journalitem' + _journalItems.length.toString(),
  //                               _texts,
  //                               _assets,
  //                               date: DateFormat('dd/MM/yyyy')
  //                                   .format(_selectedDate));
  //                           _journalItems.add(journalItem);
  //                           // if (_isEdit == false) {
  //                           //   print('311>>>>> is add');
  //                           //   JournalItem journalItem = JournalItem(
  //                           //       'journalitem' +
  //                           //           _journalItems.length.toString(),
  //                           //       _texts,
  //                           //       _assets,
  //                           //       date: DateFormat('dd/MM/yyyy')
  //                           //           .format(_selectedDate));
  //                           //   _journalItems.add(journalItem);
  //                           //   _isEdit = true;
  //                           // } else {
  //                           //   print('311>>>>> is edit');
  //                           //   int index = _journalItems.length - 1;
  //                           //   if (_selectedDate != null)
  //                           //     _journalItems[index].setDate(
  //                           //         DateFormat('dd/MM/yyyy')
  //                           //             .format(_selectedDate));
  //                           //   _journalItems[index].setTexts(_texts);
  //                           //   _journalItems[index].setAssets(_assets);
  //                           // }

  //                           // _journalItems.forEach((element) {
  //                           //   print(element.toString());
  //                           // });
  //                         },
  //                         icon: Icon(
  //                           Icons.save,
  //                           color: Colors.blue,
  //                         )),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               height: _size.width * 0.02,
  //             ),
  //             Container(
  //                 width: _size.width,
  //                 height: _size.height * 0.1,
  //                 child: TextFormField(
  //                   style: TextStyle(fontSize: 15),
  //                   focusNode: _focusNode,
  //                   decoration: InputDecoration(
  //                     suffixIcon: IconButton(
  //                       onPressed: () {
  //                         setState(() {
  //                           if (_text.isNotEmpty) {
  //                             _texts.add(_text);
  //                             _textEditingController.text = '';
  //                             _focusNode.unfocus();
  //                           }
  //                         });
  //                       },
  //                       icon: Icon(Icons.send),
  //                       color: Colors.blue,
  //                     ),
  //                     fillColor: Colors.blue.withOpacity(0.1),
  //                     filled: true,
  //                     border: OutlineInputBorder(
  //                         borderRadius:
  //                             BorderRadius.circular(_size.width * 0.02),
  //                         borderSide: BorderSide.none),
  //                     hintText: 'Thêm lịch trình/ Kế hoạch chuyến đi',
  //                     hintStyle: TextStyle(
  //                       color: Colors.black.withOpacity(0.3),
  //                       // fontStyle: FontStyle.italic,
  //                       fontSize: 15,
  //                     ),
  //                   ),
  //                   controller: _textEditingController,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _text = value;
  //                     });
  //                   },
  //                 )),
  //             Container(
  //               width: _size.width,
  //               height: _size.height * 0.2,
  //               child: ListView.separated(
  //                 itemCount: _texts.length,
  //                 itemBuilder: (context, index) {
  //                   return Slidable(
  //                     actionPane: SlidableDrawerActionPane(),
  //                     actionExtentRatio: 1 / 6,
  //                     closeOnScroll: true,
  //                     actions: [
  //                       IconButton(
  //                           onPressed: () {
  //                             _texts.removeAt(index);
  //                             setState(() {});
  //                           },
  //                           icon: Icon(
  //                             Icons.delete,
  //                             color: Colors.red,
  //                           )),
  //                       IconButton(
  //                           onPressed: () {
  //                             showDialog(
  //                               context: context,
  //                               barrierDismissible: false,
  //                               builder: (context) {
  //                                 String editText = '';
  //                                 return AlertDialog(
  //                                   title: Text('Chỉnh sửa'),
  //                                   content: TextFormField(
  //                                     initialValue: _texts[index],
  //                                     onChanged: (value) {
  //                                       editText = value;
  //                                     },
  //                                   ),
  //                                   actions: [
  //                                     FlatButton(
  //                                         onPressed: () {
  //                                           Navigator.pop(context);
  //                                         },
  //                                         child: Text('Hủy')),
  //                                     FlatButton(
  //                                         onPressed: () {
  //                                           _texts[index] = editText;
  //                                           Navigator.pop(context);
  //                                         },
  //                                         child: Text('Lưu')),
  //                                   ],
  //                                 );
  //                               },
  //                             );
  //                           },
  //                           icon: Icon(
  //                             Icons.edit,
  //                           ))
  //                     ],
  //                     child: Container(
  //                       height: _size.width * 0.1,
  //                       child: Row(
  //                         children: [
  //                           Stack(
  //                             children: [
  //                               Align(
  //                                 alignment: Alignment.center,
  //                                 child: Container(
  //                                   height: _size.width * 0.05,
  //                                   width: _size.width * 0.05,
  //                                   decoration: BoxDecoration(
  //                                       color:
  //                                           Colors.blueAccent.withOpacity(0.2),
  //                                       shape: BoxShape.circle),
  //                                 ),
  //                               ),
  //                               Align(
  //                                 alignment: Alignment.center,
  //                                 child: Container(
  //                                   height: _size.width * 0.025,
  //                                   width: _size.width * 0.025,
  //                                   margin: EdgeInsets.only(
  //                                       left: _size.width * 0.025 / 2),
  //                                   decoration: BoxDecoration(
  //                                       color: Colors.blueAccent,
  //                                       shape: BoxShape.circle),
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.all(_size.width * 0.02),
  //                             child: Text(_texts[index],
  //                                 style: TextStyle(fontSize: 16)),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //                 separatorBuilder: (context, index) {
  //                   return SizedBox(
  //                     height: _size.width * 0.07,
  //                   );
  //                 },
  //               ),
  //             ),
  //             SizedBox(
  //               height: _size.width * 0.02,
  //             ),
  //             _AddListAsset(_assets),
  //             // Container(
  //             //   width: _size.width,
  //             //   height: _size.height * 0.2,
  //             //   color: Colors.red,
  //             // )
  //             // Divider(
  //             //   color: Colors.grey,
  //             //   thickness: 3,
  //             // )
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  // }

  Widget _JournalItem(JournalItem item, int index) {
    // print('605>iii' + e.value.getJournalItemId);
    return Container(
      height: _size.height * 0.4,
      width: _size.width,
      // color: Colors.red,
      child: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                // color: Colors.amber,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(_size.width * 0.02),
                                color: Colors.red[400],
                                shape: BoxShape.circle),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                item.getDate
                                    .substring(0, item.getDate.length - 5),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(_size.width * 0.02),
                          // color: Colors.orange[400]
                        ),
                        margin: EdgeInsets.all(_size.width * 0.02),
                        child: ListView.separated(
                          itemCount: item.getTexts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: _size.width * 0.1,
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: _size.width * 0.05,
                                          width: _size.width * 0.05,
                                          decoration: BoxDecoration(
                                              color: Colors.blueAccent
                                                  .withOpacity(0.2),
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: _size.width * 0.025,
                                          width: _size.width * 0.025,
                                          margin: EdgeInsets.only(
                                              left: _size.width * 0.025 / 2),
                                          decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              shape: BoxShape.circle),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(_size.width * 0.02),
                                    child: Text(item.getTexts[index],
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: _size.width * 0.07,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: VerticalDivider(
                                  color: Colors.blueAccent,
                                  thickness: 1,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )),
          item.getAssets.length > 0
              ? Expanded(
                  flex: 4,
                  child: Container(
                    child: _ListItemAsset(item.getAssets),
                  ))
              : Container(),
          Expanded(
              child: Divider(
            color: Colors.grey.withOpacity(0.5),
          ))
        ],
      ),
    );
  }

  Widget _ListItemAsset(List<Asset> assets) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(assets.length, (index) {
        Asset asset = assets[index];
        return InkWell(
          onLongPress: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_size.width * 0.02)),
            padding: EdgeInsets.all(_size.width * 0.02),
            child: ClipRRect(
              child: AssetThumb(
                asset: asset,
                width: 500,
                height: 500,
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<File> cropImage(File file) async {
    return await ImageCropper.cropImage(
        sourcePath: file.path,
        // aspectRatio: CropAspectRatio(ratioX: 2, ratioY: 3),
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.yellow[800],
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(minimumAspectRatio: 1.0),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ]);
  }

  Future<void> loadAssets(StateSetter setState) async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: false,
        selectedAssets: _assets,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          textOnNothingSelected: 'Bạn chưa chọn ảnh',
          actionBarColor: "#FFB4C6",
          actionBarTitle: "Chọn ảnh",
          allViewTitle: "Tất cả",
          useDetailsView: true,
          selectCircleStrokeColor: "#FF003D",
          statusBarColor: "#FFB4C6",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _assets = resultList;
      print('200>image: ' + _assets.toString());
    });
  }

  Widget _AddListAsset(List<Asset> _assets) {
    return Container(
      height: _size.height * 0.15,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(_assets.length, (index) {
          Asset asset = _assets[index];
          return InkWell(
            onLongPress: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_size.width * 0.02)),
              padding: EdgeInsets.all(_size.width * 0.02),
              child: ClipRRect(
                child: AssetThumb(
                  asset: asset,
                  width: 500,
                  height: 500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Widget _addImageWidget(MapEntry<int, String> image) {
  //   return Slidable(
  //     actionPane: SlidableScrollActionPane(),
  //     actionExtentRatio: 1 / 2,
  //     closeOnScroll: true,
  //     actions: [
  //       IconButton(
  //         onPressed: () {
  //           setState(() {
  //             _images.removeAt(image.key);
  //           });
  //         },
  //         icon: Icon(
  //           Icons.delete,
  //           color: Colors.red,
  //         ),
  //       ),
  //     ],
  //     child: Container(
  //       height: _size.width,
  //       width: _size.width,
  //       margin: EdgeInsets.all(_size.width * 0.02),
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(_size.width * 0.04),
  //           image: DecorationImage(
  //               image: FileImage(File(image.value)), fit: BoxFit.cover)),
  //     ),
  //   );
  // }

  // Future<void> loadAssets() async {
  //   List<Asset> resultList = <Asset>[];
  //   String error = 'No Error Detected';
  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 300,
  //       enableCamera: false,
  //       selectedAssets: _images,
  //       cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
  //       materialOptions: MaterialOptions(
  //         textOnNothingSelected: 'Bạn chưa chọn ảnh',
  //         actionBarColor: "#FFB4C6",
  //         actionBarTitle: "Chọn ảnh",
  //         allViewTitle: "Tất cả",
  //         useDetailsView: true,
  //         selectCircleStrokeColor: "#FF003D",
  //         statusBarColor: "#FFB4C6",
  //       ),
  //     );
  //   } on Exception catch (e) {
  //     error = e.toString();
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _images = resultList;
  //     _error = error;
  //     // print('200>image: ' + _images.toString());
  //     // print('201>error: ' + _error.toString());
  //   });
  // }

  // Widget buildListViewImage() {
  //   return ListView(
  //     physics: NeverScrollableScrollPhysics(),
  //     children: List.generate(_images.length, (index) {
  //       String image = _images[index];
  //       return Slidable(
  //         actionPane: SlidableScrollActionPane(),
  //         actionExtentRatio: 1 / 2,
  //         closeOnScroll: true,
  //         actions: [
  //           IconButton(
  //             onPressed: () {
  //               // _images.removeAt(index);
  //               // setState(() {});
  //               _journeyEditViewModel.deleteNote(
  //                   _journeyBox, _journeyBox.getAt(index));
  //             },
  //             icon: Icon(
  //               Icons.delete,
  //               color: Colors.red,
  //             ),
  //           ),
  //         ],
  //         child: Container(
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(_size.width * 0.02)),
  //           padding: EdgeInsets.all(_size.width * 0.02),
  //           child: AssetThumb(
  //             asset: asset,
  //             width: 500,
  //             height: 500,
  //           ),
  //         ),
  //       );
  //     }),
  //   );
  // }
}
