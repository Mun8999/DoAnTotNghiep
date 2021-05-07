// @dart=2.9
import 'dart:io';

import 'package:bullet_journal/edit_image/utils.dart';
// import 'package:bullet_journal/image_cropper/image_cropper.dart';
import 'package:bullet_journal/model/diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';

// ignore: must_be_immutable
class DiaryEditView extends StatefulWidget {
  Diary diary;
  DiaryEditView(this.diary);
  @override
  _DiaryEditViewState createState() => _DiaryEditViewState();
}

Size size, sizeImage = Size(0, 0);
bool _isEditButtonTaped = false;
FocusNode _focusTyping = FocusNode();
Offset _offsetImage = Offset(0, 0);
bool _isDragged = false;
File _imageDragged;
// bool _isTitleTaped = false, _isContentTaped = false;
// TextEditingController _titleController = TextEditingController(),
//     _contentController = TextEditingController();
List<File> imageFiles = [];

class _DiaryEditViewState extends State<DiaryEditView> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).padding.top + kToolbarHeight;
    final SnackBar snackBar = SnackBar(
        content: Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        height: size.height * 0.02,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Chọn vào '),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(' để chỉnh sửa.')
          ],
        ),
      ),
    ));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              setState(() {
                _isEditButtonTaped = false;
                print('back' + _isEditButtonTaped.toString());
              });
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // showMyBottomSheet();
                setState(() {
                  _focusTyping.requestFocus();
                  _isEditButtonTaped = true;
                  print('edit' + _isEditButtonTaped.toString());
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
          elevation: 1,
        ),
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                height: size.height,
                width: size.width,
                color: Colors.white,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        height: size.height,
                        width: size.width,
                        color: Colors.transparent,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            TextFormField(
                              // controller: _titleController,
                              initialValue: widget.diary.getDiaryTitle,
                              readOnly: !_isEditButtonTaped,
                              onTap: () {
                                if (_isEditButtonTaped == false)
                                  Scaffold.of(context).showSnackBar(snackBar);
                              },
                              minLines: 1,
                              maxLines: 3,
                              cursorColor: Colors.brown[800],
                              style: GoogleFonts.dancingScript(
                                  fontSize: 25, color: Colors.brown[800]),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Chủ đề',
                                  hintStyle: TextStyle(
                                      color:
                                          Colors.brown[700].withOpacity(0.6))),
                            ),
                            TextFormField(
                              // controller: _contentController,
                              initialValue: widget.diary.getDiaryContent,
                              readOnly: !_isEditButtonTaped,
                              focusNode: _focusTyping,
                              onTap: () {
                                if (_isEditButtonTaped == false)
                                  Scaffold.of(context).showSnackBar(snackBar);
                              },
                              cursorColor: Colors.brown[500],
                              minLines: 1,
                              maxLines: 50,
                              style: GoogleFonts.dancingScript(
                                  fontSize: 20, color: Colors.brown[500]),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                            ImageListWidget(imageFiles),
                          ],
                        ),
                      ),
                    ),
                    new Positioned(
                        left: _offsetImage.dx,
                        top: _offsetImage.dy - height,
                        child: _imageDragged != null
                            ? Draggable(
                                feedback: Container(
                                  height: size.width * 0.5,
                                  width: size.width * 0.5,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: ClipRRect(
                                      child: Image.file(_imageDragged),
                                    ),
                                  ),
                                ),
                                childWhenDragging: Container(),
                                onDraggableCanceled: (velocity, offset) {
                                  setState(() {
                                    _offsetImage = offset;
                                    // _imageDragged = null;
                                  });
                                },
                                child: Container(
                                  height: size.width * 0.5,
                                  width: size.width * 0.5,
                                  child: ClipRRect(
                                    child: Image.file(_imageDragged),
                                  ),
                                ))
                            : Container())
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 0,
          child: Container(
              margin: EdgeInsets.all(20),
              height: size.height * 0.07,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      final file = await Utils.pickMedia(
                          isGallery: true, cropImage: cropImage);
                      if (file == null) return;
                      setState(() => imageFiles.add(file));
                      print('file' + file.path);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/icons/insert-picture-icon.svg',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/icons/cotton-t-shirt.svg',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      'assets/icons/emotion/smile-face.svg',
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      'assets/icons/pointer-on-the-map.svg',
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      'assets/icons/black-shop-tag.svg',
                      color: Colors.white,
                    ),
                  ),
                ],
              )
              // Text(
              //   widget.diary.diaryTitle.toString(),
              //   style: TextStyle(color: Colors.white),
              // )
              ),
        ));
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

  void showMyBottomSheet() {
    showModalBottomSheet<dynamic>(
      // enableDrag: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            margin: EdgeInsets.all(20),
            // width: size.width - size.width * 0.2,
            height: size.height * 0.07,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    'assets/icons/black-shop-tag.svg',
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    'assets/icons/insert-picture-icon.svg',
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    'assets/icons/cotton-t-shirt.svg',
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    'assets/icons/pointer-on-the-map.svg',
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    'assets/icons/smile.svg',
                    color: Colors.white,
                  ),
                ),
              ],
            )
            // Text(
            //   widget.diary.diaryTitle.toString(),
            //   style: TextStyle(color: Colors.white),
            // )
            );
      },
    );
  }

  Widget ImageListWidget(List<File> imageFiles) {
    return Container(
      height: size.height * 0.5,
      width: size.width,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: imageFiles
            .asMap()
            .entries
            .map((imageFile) => Draggable(
                  feedback: Container(
                    height: size.width * 0.5,
                    width: size.width * 0.5,
                    child: Opacity(
                      opacity: 0.5,
                      child: ClipRRect(
                        child: Image.file(imageFile.value),
                      ),
                    ),
                  ),
                  childWhenDragging: Container(),
                  child: ClipRRect(
                    child: Image.file(imageFile.value),
                  ),
                  onDraggableCanceled: (velocity, offset) {
                    imageFiles.forEach((element) {
                      print(element);
                    });
                    setState(() {
                      imageFiles.removeAt(imageFile.key);
                      _imageDragged = imageFile.value;
                      _offsetImage = offset;
                      sizeImage = Size(size.width * 0.5, size.width * 0.5);
                    });
                  },
                ))
            .toList(),
      ),
    );
  }
}
///// detect keyyyyyyy
// RawKeyboardListener(
//   focusNode: _focusNode,
//   onKey: (value) {
//     if (value.isKeyPressed(LogicalKeyboardKey.end)) {
//       setState(() {
//         _titleLine++;
//       });
//     }
//   },
//   child: TextFormField(
//     // controller: _titleController,
//     keyboardType: TextInputType.multiline,
//     initialValue: widget.diary.getDiaryTitle,
//     readOnly: !_isEditButtonTaped,
//     minLines: 1,
//     maxLines: 3,
//     cursorColor: Colors.yellow[900],
//     style: GoogleFonts.dancingScript(
//         fontSize: 25, color: Colors.yellow[900]),
//     decoration: InputDecoration(
//         border: InputBorder.none,
//         hintText: 'Chủ đề',
//         hintStyle: TextStyle(
//             color:
//                 Colors.yellow[900].withOpacity(0.6))),
//   ),
// ),