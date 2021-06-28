// @dart=2.9
import 'dart:io';

import 'package:bullet_journal/database/db_journey.dart';
import 'package:bullet_journal/edit_image/utils.dart';
import 'package:bullet_journal/journey/journey_edit/journey_edit_viewmodel.dart';
import 'package:bullet_journal/journey/journey_edit/journey_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';

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
List<String> _items = [];

class _JourneyEditViewState extends State<JourneyEditView> {
  @override
  void initState() {
    _journeyBox = Hive.box<JourneyDB>('journeys');
    _journeyEditViewModel = JourneyEditViewModel();
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
                _journeyEditViewModel.saveJouney(
                    _journeyBox, widget._state, widget._journeyDB, _images);
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
                  height: _size.height * 1.5,
                  width: _size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(_size.width * 0.02),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        TextFormField(
                          minLines: 1,
                          maxLines: 2,
                          initialValue: widget._journeyDB.journeyTitle,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Địa điểm',
                              hintStyle: GoogleFonts.nunitoSans(
                                color: Colors.red.withOpacity(0.3),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          style: GoogleFonts.nunitoSans(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          onChanged: (value) {
                            widget._journeyDB.journeyTitle = value;
                          },
                        ),
                        TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          initialValue: widget._journeyDB.journeyContent,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nội dung',
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: 16, color: Colors.grey)),
                          style: GoogleFonts.nunitoSans(fontSize: 16),
                          onChanged: (value) {
                            widget._journeyDB.journeyContent = value;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                              onTap: () {
                                _items.add('abc');
                                setState(() {});
                              },
                              child: Container(
                                // decoration: BoxDecoration(color: Colors.red[300]),
                                child: Text(
                                  '>> Thêm hành trình',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )),
                        ),

                        ..._images
                            .asMap()
                            .entries
                            .map((image) => _addImageWidget(image))
                            .toList(),
                        ..._items.asMap().entries.map((e) => _JouneyItem()),
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
                        final file = await Utils.pickMedia(
                            isGallery: true, cropImage: cropImage);
                        if (file == null) {
                          return;
                        }
                        _images.add(file.path);
                        setState(() {});
                      },
                      icon: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                            'assets/icons/insert-picture-icon.svg',
                            color: Colors.white),
                      ),
                    ),
                  ],
                ))));
  }

  DateTime _selectedDate;
  Widget _JouneyItem() {
    _selectedDate = DateTime.now();
    return Container(
      width: _size.width,
      height: _size.height * 0.12,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: _size.width,
              height: _size.height * 0.1,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () async {
                      final DateTime datePicked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2050),
                      );
                      if (datePicked != null && datePicked != _selectedDate) {
                        setState(() {
                          _selectedDate = datePicked;
                        });
                      }
                    },
                    child: Container(
                      width: _size.width * 0.2,
                      height: _size.width * 0.2,
                      margin: EdgeInsets.all(_size.width * 0.01),
                      decoration: BoxDecoration(
                          color: Colors.amber[600], shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                        DateFormat('dd/MM').format(_selectedDate),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Positioned(
                    top: -_size.width * 0.02,
                    left: _size.width * 0.22,
                    child: Container(
                      width: _size.width * 0.8,
                      height: _size.height * 0.2,
                      child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                              Text('Xuất phát')
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   width: _size.width,
            //   height: _size.height * 0.2,
            //   color: Colors.red,
            // )
            Divider(
              color: Colors.grey,
              thickness: 3,
            )
          ],
        ),
      ),
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

  Widget _addImageWidget(MapEntry<int, String> image) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 1 / 2,
      closeOnScroll: true,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _images.removeAt(image.key);
            });
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
      child: Container(
        height: _size.width,
        width: _size.width,
        margin: EdgeInsets.all(_size.width * 0.02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_size.width * 0.04),
            image: DecorationImage(
                image: FileImage(File(image.value)), fit: BoxFit.cover)),
      ),
    );
  }
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
