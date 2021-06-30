// @dart=2.9
import 'dart:io';

import 'package:bullet_journal/database/db_note.dart';
import 'package:bullet_journal/note/m_record.dart';
import 'package:bullet_journal/note/note_edit_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class NoteEditView extends StatefulWidget {
  int _state;
  NoteDB _noteDB;
  NoteEditView(int state, NoteDB noteDB, {Key key}) : super(key: key) {
    this._state = state;
    this._noteDB = noteDB;
  }

  @override
  _NoteEditViewState createState() => _NoteEditViewState();
}

Size _size;
List<Asset> _images = <Asset>[];
String _error = 'No Error Dectected';
bool _recordState = false;
MyRecord _myRecord;
List<String> _records = [];
String _record;
DateTime _dt;
NoteEditViewModel _noteEditViewModel;
Box<NoteDB> _noteBox;

class _NoteEditViewState extends State<NoteEditView> {
  @override
  void initState() {
    _myRecord = MyRecord();
    _noteBox = Hive.box<NoteDB>('notes');
    _noteEditViewModel = NoteEditViewModel();
    _noteEditViewModel
        .initNoteData(widget._noteDB, widget._state, _records, _images)
        .then((value) => setState(() {}));

    print('state>49' + widget._state.toString());
    super.initState();
  }

  @override
  void dispose() {
    _myRecord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
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
                _noteEditViewModel.saveNote(
                    _noteBox, widget._state, widget._noteDB, _records, _images);
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
              child: SingleChildScrollView(
                child: Container(
                    height: _size.height * 1.5,
                    width: _size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(_size.width * 0.02),
                      child: Column(children: [
                        TextFormField(
                          minLines: 1,
                          maxLines: 2,
                          initialValue: widget._noteDB.noteTitle,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Chủ đề',
                              hintStyle: GoogleFonts.nunitoSans(
                                  color: Colors.grey.withOpacity(0.3),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          style: GoogleFonts.nunitoSans(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          onChanged: (value) {
                            widget._noteDB.noteTitle = value;
                          },
                        ),
                        TextFormField(
                          minLines: 1,
                          maxLines: 20,
                          initialValue: widget._noteDB.noteContent,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nội dung',
                              hintStyle: GoogleFonts.nunitoSans(
                                  color: Colors.grey.withOpacity(0.3),
                                  fontSize: 18)),
                          style: GoogleFonts.nunitoSans(fontSize: 18),
                          onChanged: (value) {
                            widget._noteDB.noteContent = value;
                          },
                        ),
                        ..._records
                            .asMap()
                            .entries
                            .map((record) => _recorderWidget(record)),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Container(
                        //     width: _size.width * 0.3,
                        //     height: _size.height * 0.3,
                        //     child: ListView.separated(
                        //       scrollDirection: Axis.vertical,
                        //       itemCount: _records.length,
                        //       itemBuilder: (context, index) {
                        //         return _recorderWidget(_records[index], index);
                        //       },
                        //       separatorBuilder:
                        //           (BuildContext context, int index) {
                        //         return SizedBox(
                        //           height: _size.width * 0.03,
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),
                        Expanded(flex: 2, child: buildListViewImage()),
                      ]),
                    )),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            elevation: 0,
            child: Container(
                margin: EdgeInsets.all(_size.width * 0.05),
                height: _size.height * 0.07,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await loadAssets();
                      },
                      icon: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                            'assets/icons/insert-picture-icon.svg',
                            color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          _recordState = !_recordState;
                        });
                        if (_recordState) {
                          _dt = DateTime.now();
                          _record = _dt.day.toString() +
                              _dt.month.toString() +
                              _dt.year.toString() +
                              _dt.hour.toString() +
                              _dt.minute.toString() +
                              _dt.second.toString() +
                              _dt.millisecond.toString() +
                              '.aac';
                          // print(_record);
                          _myRecord.record(_record);
                          _records.add(_record);
                        } else {
                          _myRecord.stopRecorder();
                        }
                      },
                      child: Container(
                          height: 30,
                          width: 30,
                          child: _recordState
                              ? SvgPicture.asset(
                                  'assets/icons/note_edit/stop.svg',
                                  color: Colors.white,
                                )
                              : SvgPicture.asset(
                                  'assets/icons/note_edit/mic.svg',
                                  color: Colors.white)),
                    )
                    // IconButton(
                    //   icon: Container(
                    //     height: 30,
                    //     width: 30,
                    //     child: SvgPicture.asset(
                    //       'assets/icons/emotion/smile-face.svg',
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     _myRecord.play(_record);
                    //     // _myRecord.stopRecorder();
                    //   },
                    // ),
                    // IconButton(
                    //   onPressed: () {
                    //     // _myRecord.play();
                    //   },
                    //   icon: Container(
                    //     height: 30,
                    //     width: 30,
                    //     child: SvgPicture.asset(
                    //         'assets/icons/pointer-on-the-map.svg',
                    //         color: Colors.white),
                    //   ),
                    // ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Container(
                    //     height: 30,
                    //     width: 30,
                    //     child: SvgPicture.asset(
                    //       'assets/icons/black-shop-tag.svg',
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // )
                  ],
                ))));
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: false,
        selectedAssets: _images,
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
      _images = resultList;
      _error = error;
      print('200>image: ' + _images.toString());
      print('201>error: ' + _error.toString());
    });
  }

  Widget buildListViewImage() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      // crossAxisCount: 2,
      // crossAxisSpacing: _size.width * 0.02,
      // mainAxisSpacing: _size.width * 0.02,
      children: List.generate(_images.length, (index) {
        Asset asset = _images[index];
        return InkWell(
          onLongPress: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title:
                    const Text('Cảnh báo', style: TextStyle(color: Colors.red)),
                content:
                    const Text('Bạn có chắc chắn muốn xóa hình này không?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _images.removeAt(index);
                      });
                      // _noteEditViewModel.deleteNote(_noteBox, _noteBox.getAt(index));
                      Navigator.pop(context, 'Có');
                    },
                    child: const Text('Có'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Không'),
                    child: const Text('Không'),
                  ),
                ],
              ),
            );
          },
          // actionPane: SlidableScrollActionPane(),
          // actionExtentRatio: 1 / 2,
          // closeOnScroll: true,
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       // _images.removeAt(index);
          //       // setState(() {});
          //       _noteEditViewModel.deleteNote(_noteBox, _noteBox.getAt(index));
          //     },
          //     icon: Icon(
          //       Icons.delete,
          //       color: Colors.red,
          //     ),
          //   ),
          // ],
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_size.width * 0.02)),
            padding: EdgeInsets.all(_size.width * 0.02),
            child: AssetThumb(
              asset: asset,
              width: 500,
              height: 500,
            ),
          ),
        );
      }),
    );
  }

  Widget _recorderWidget(MapEntry<int, String> record) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          _myRecord.play(record.value);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_size.width * 0.02),
              color: Colors.yellow.withOpacity(0.2)),
          margin: EdgeInsets.all(_size.width * 0.02),
          padding: EdgeInsets.only(left: _size.width * 0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  height: 50,
                  width: 50,
                  child: SvgPicture.asset('assets/icons/note_edit/record.svg')),
              IconButton(
                  onPressed: () {
                    _myRecord.deleteRecord(record.value);
                    _records.removeAt(record.key);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  // Widget _recorderWidget(String record, int index) {
  //   return InkWell(
  //     onTap: () {
  //       _myRecord.play(record);
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(_size.width * 0.02),
  //           color: Colors.yellow.withOpacity(0.2)),
  //       padding: EdgeInsets.only(left: _size.width * 0.02),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Container(
  //               height: 50,
  //               width: 50,
  //               child: SvgPicture.asset('assets/icons/note_edit/record.svg')),
  //           IconButton(
  //               onPressed: () {
  //                 _myRecord.deleteRecord(record);
  //                 _records.removeAt(index);
  //                 setState(() {});
  //               },
  //               icon: Icon(
  //                 Icons.delete,
  //                 color: Colors.red,
  //               ))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
