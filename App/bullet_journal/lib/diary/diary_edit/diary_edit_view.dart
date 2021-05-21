// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:bullet_journal/diary/diary_edit/diary_edit_viewmodel.dart';
import 'package:bullet_journal/edit_image/utils.dart';
// import 'package:bullet_journal/model/component.dart';
import 'package:bullet_journal/model/diary.dart';
import 'package:bullet_journal/model/emotion.dart';
import 'package:bullet_journal/model/image.dart';
import 'package:bullet_journal/model/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:focused_menu/focused_menu.dart';

// ignore: must_be_immutable
class DiaryEditView extends StatefulWidget {
  Diary diary;
  DiaryEditView(this.diary);
  @override
  _DiaryEditViewState createState() => _DiaryEditViewState();
}

Size size;
bool _isEditButtonTaped = false;
FocusNode _focusTyping = FocusNode();

DiaryEditViewModel _diaryEditViewModel = DiaryEditViewModel();

List<MyImage> _images = [];
double _space;
double _imageWidth;
double _imageHeight;
Size _imageSize;

Offset _emotionOffset;
bool _emotionEditState = false;

List<MyText> _editTexts = [];

class _DiaryEditViewState extends State<DiaryEditView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _imageWidth = size.width * 0.6;
    _imageHeight = size.width * 0.6;
    _imageSize = Size(_imageWidth, _imageHeight);
    _space = MediaQuery.of(context).padding.top + kToolbarHeight;
    GlobalKey _key = GlobalKey();
    PopupMenu.context = context;

    // final SnackBar snackBar = SnackBar(
    //     content: Padding(
    //   padding: EdgeInsets.all(5),
    //   child: Container(
    //     height: size.height * 0.02,
    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Text('Chọn vào '),
    //         Icon(
    //           Icons.edit,
    //           color: Colors.white,
    //         ),
    //         Text(' để chỉnh sửa.')
    //       ],
    //     ),
    //   ),
    // ));

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
            return SafeArea(
              child: Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.white,
                  child: StreamBuilder<List<bool>>(
                      stream: _diaryEditViewModel.getBottomStateStream,
                      builder: (context, bottomButton) {
                        return Stack(
                            children: _images
                                    .asMap()
                                    .entries
                                    .map((e) => _addImageWidget(
                                        e.value.getImageFile, e.key, _space))
                                    .toList() +
                                [
                                  StreamBuilder<Emotion>(
                                    stream: _diaryEditViewModel
                                        .getEmotionStatusStream,
                                    builder: (context, emotion) {
                                      if (_emotionOffset == null) {
                                        _emotionOffset = Offset(10, 150);

                                        // emotion.data
                                        //     .setEmotionComponent(_component);
                                        // print('\nshowPopUp' +
                                        //     _emotion.getEmotionComponent.getOffset.dx.toString() +
                                        //     _emotion.getEmotionComponent.getOffset.dy.toString());
                                      }
                                      return emotion.hasData &&
                                              bottomButton.data[2]
                                          ? Positioned(
                                              left: _emotionOffset.dx,
                                              top: _emotionOffset.dy - _space,
                                              child: Draggable(
                                                feedback: Opacity(
                                                  opacity: 0.5,
                                                  child: Container(
                                                      height: 50,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 50,
                                                            child: SvgPicture
                                                                .asset(
                                                              emotion.data
                                                                  .getEmotionImage,
                                                            ),
                                                          ),
                                                          Text(
                                                            ' - Đang cảm thấy ',
                                                            style: GoogleFonts.koHo(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                          Text(
                                                            emotion.data
                                                                .getEmotionName
                                                                .toLowerCase(),
                                                            style: GoogleFonts.koHo(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _emotionEditState =
                                                            !_emotionEditState;
                                                      });
                                                    },
                                                    child: Container(
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: 50,
                                                              child: SvgPicture
                                                                  .asset(
                                                                emotion.data
                                                                    .getEmotionImage,
                                                              ),
                                                            ),
                                                            Text(
                                                              ' - Đang cảm thấy ',
                                                              style: GoogleFonts.koHo(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              emotion.data
                                                                  .getEmotionName
                                                                  .toLowerCase(),
                                                              style: GoogleFonts
                                                                  .koHo(),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                _diaryEditViewModel
                                                                    .setBottomStateController(
                                                                        2,
                                                                        false);
                                                              },
                                                              child: _emotionEditState
                                                                  ? Container(
                                                                      margin: EdgeInsets.only(left: 10),
                                                                      height: 20,
                                                                      width: 20,
                                                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                                                                      child: Icon(
                                                                        Icons
                                                                            .close_rounded,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            15,
                                                                      ))
                                                                  : Container(),
                                                            )
                                                          ],
                                                        ))),
                                                childWhenDragging: Container(),
                                                onDraggableCanceled:
                                                    (velocity, offset) {
                                                  if (!_checkEmotionOfffset(
                                                      offset)) return;
                                                  setState(() {
                                                    _emotionOffset = offset;
                                                  });
                                                },
                                              ),
                                            )
                                          : Container();
                                    },
                                  ),
                                  StreamBuilder<String>(
                                      stream:
                                          _diaryEditViewModel.getAddressStream,
                                      initialData: '',
                                      builder: (context, address) {
                                        return address.data.isNotEmpty &&
                                                bottomButton.data[3]
                                            ? Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: SvgPicture.asset(
                                                          'assets/icons/pointer-on-the-map.svg',
                                                          color: Colors.black,
                                                          height: 20,
                                                          width: 20,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10,
                                                                right: 10,
                                                                bottom: 10),
                                                        child: Text(
                                                          address.data,
                                                          style:
                                                              GoogleFonts.koHo(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            : Container();
                                      }),
                                  ..._editTexts
                                      .asMap()
                                      .entries
                                      .map((e) => _addEditTextWidget(e, _space))
                                ]
                            //   [
                            //   Padding(
                            //     padding: const EdgeInsets.all(10),
                            //     child: Column(children: [
                            //       TextFormField(
                            //         // controller: _titleController,
                            //         initialValue: widget.diary.getDiaryTitle,
                            //         readOnly: !_isEditButtonTaped,
                            //         onTap: () {
                            //           if (_isEditButtonTaped == false)
                            //             Scaffold.of(context).showSnackBar(snackBar);
                            //         },
                            //         minLines: 1,
                            //         maxLines: 3,
                            //         cursorColor: Colors.brown[800],
                            //         style: GoogleFonts.dancingScript(
                            //             fontSize: 25, color: Colors.brown[800]),
                            //         decoration: InputDecoration(
                            //             border: InputBorder.none,
                            //             hintText: 'Chủ đề',
                            //             hintStyle: TextStyle(
                            //                 color: Colors.brown[700].withOpacity(0.6))),
                            //       ),
                            //       TextFormField(
                            //         // controller: _contentController,
                            //         initialValue: widget.diary.getDiaryContent,
                            //         readOnly: !_isEditButtonTaped,
                            //         focusNode: _focusTyping,
                            //         onTap: () {
                            //           if (_isEditButtonTaped == false)
                            //             Scaffold.of(context).showSnackBar(snackBar);
                            //         },
                            //         cursorColor: Colors.brown[500],
                            //         minLines: 1,
                            //         maxLines: 50,
                            //         style: GoogleFonts.dancingScript(
                            //             fontSize: 20, color: Colors.brown[500]),
                            //         decoration: InputDecoration(
                            //           border: InputBorder.none,
                            //         ),
                            //       ),
                            //       // ImageListWidget(imageFiles)
                            //     ]),
                            //   ),
                            //   ..._images
                            //       .asMap()
                            //       .entries
                            //       .map((e) =>
                            //           addImageWidget(e.value.getImageFile, e.key, _space))
                            //       .toList()
                            // ]
                            );
                      })),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 0,
          child: StreamBuilder<List<bool>>(
              initialData: [false, false, false, false, false],
              stream: _diaryEditViewModel.getBottomStateStream,
              builder: (context, bottomButton) {
                return Container(
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
                        IconButton(
                          onPressed: () async {
                            _diaryEditViewModel.setBottomStateController(
                                0, true);
                            final file = await Utils.pickMedia(
                                isGallery: true, cropImage: cropImage);
                            if (file == null) {
                              // _diaryEditViewModel.setBottomStateController(0);
                              return;
                            }
                            setState(() {
                              MyImage myImage =
                                  new MyImage(file, Offset.zero, _imageSize);
                              _images.add(myImage);
                            });
                          },
                          icon: Container(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                                'assets/icons/insert-picture-icon.svg',
                                color: bottomButton.data[0]
                                    ? Colors.yellow[600]
                                    : Colors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _diaryEditViewModel.setBottomStateController(
                                1, true);
                            MyText _text = MyText('title', TextStyle(), '',
                                Offset(10, 100), Size.zero);
                            _editTexts.add(_text);
                          },
                          icon: Container(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                              'assets/icons/edit/pen-feather-black-diagonal-shape-of-a-bird-wing.svg',
                              color: bottomButton.data[1]
                                  ? Colors.yellow[600]
                                  : Colors.white,
                            ),
                          ),
                        ),
                        StreamBuilder<List<Emotion>>(
                            initialData: [],
                            stream: _diaryEditViewModel.getEmotionStream,
                            builder: (context, emotions) {
                              return IconButton(
                                key: _key,
                                icon: Container(
                                  height: 30,
                                  width: 30,
                                  child: SvgPicture.asset(
                                    'assets/icons/emotion/smile-face.svg',
                                    color: bottomButton.data[2]
                                        ? Colors.yellow[600]
                                        : Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  // _diaryEditViewModel.setBottomStateController(
                                  //     2, !bottomButton.data[2]);
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    showPopUp(_key, emotions.data);
                                  });
                                },
                              );
                            }),
                        IconButton(
                          onPressed: () {
                            _diaryEditViewModel.setBottomStateController(
                                3, !bottomButton.data[3]);
                            // setState(() {
                            //   // bottomButton.data[3] = !bottomButton.data[3];
                            //   // if (bottomButton.data[3])
                            //   //   _diaryEditViewModel.setBottomStateController(0);
                            // });
                          },
                          icon: Container(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                              'assets/icons/pointer-on-the-map.svg',
                              color: bottomButton.data[3]
                                  ? Colors.yellow[600]
                                  : Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _diaryEditViewModel.setBottomStateController(
                                4, true);
                          },
                          icon: Container(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                              'assets/icons/black-shop-tag.svg',
                              color: bottomButton.data[4]
                                  ? Colors.yellow[600]
                                  : Colors.white,
                            ),
                          ),
                        )
                      ],
                    ));
              }),
        ));
  }

  Widget _addImageWidget(File imageFile, int index, double space) {
    print('1.chay do thang cha roi nè');
    _images[index].setImageId(index);
    if (imageFile == null) return null;

    return Positioned(
        left: _images[index].getOffset.dy == 0
            ? size.width / 4
            : _images[index].getOffset.dx,
        top: _images[index].getOffset.dy == 0
            ? size.height / 4
            : _images[index].getOffset.dy - space,
        child: Draggable(
          feedback: _WidgetFeedbackDrag(imageFile),
          childWhenDragging: Container(),
          child: _WidgetChildDrag(imageFile, index),
          onDraggableCanceled: (velocity, offset) {
            if (!_checkImageOffset(offset, _images[index].getSize)) return;
            setState(() {
              if (_images[index].getResizeState) {
                double d = offset.dx - _images[index].getOffset.dx;
                _imageWidth = _imageWidth + d;
                _imageHeight = _imageHeight + d;
                _imageSize = Size(_imageWidth, _imageHeight);
                _images[index].setSize(_imageSize);
              }
              _images[index].setOffset(offset);

              // _imageFiles.removeAt(index);
              // print('\n2.' + _isMoved.toString());
            });
          },
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

  // void showMyBottomSheet() {
  //   showModalBottomSheet<dynamic>(
  //     // enableDrag: true,
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //           margin: EdgeInsets.all(20),
  //           // width: size.width - size.width * 0.2,
  //           height: size.height * 0.07,
  //           decoration: BoxDecoration(
  //             color: Colors.black,
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               Container(
  //                 height: 30,
  //                 width: 30,
  //                 child: SvgPicture.asset(
  //                   'assets/icons/black-shop-tag.svg',
  //                   color: Colors.white,
  //                 ),
  //               ),
  //               Container(
  //                 height: 30,
  //                 width: 30,
  //                 child: SvgPicture.asset(
  //                   'assets/icons/insert-picture-icon.svg',
  //                   color: Colors.white,
  //                 ),
  //               ),
  //               Container(
  //                 height: 30,
  //                 width: 30,
  //                 child: SvgPicture.asset(
  //                   'assets/icons/cotton-t-shirt.svg',
  //                   color: Colors.white,
  //                 ),
  //               ),
  //               Container(
  //                 height: 30,
  //                 width: 30,
  //                 child: SvgPicture.asset(
  //                   'assets/icons/pointer-on-the-map.svg',
  //                   color: Colors.white,
  //                 ),
  //               ),
  //               InkWell(
  //                   onTap: () {},
  //                   child: FocusedMenuHolder(
  //                     child: Container(
  //                       height: 30,
  //                       width: 30,
  //                       child: SvgPicture.asset(
  //                         'assets/icons/smile.svg',
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     onPressed: () {},
  //                     menuItems: <FocusedMenuItem>[
  //                       // Add Each FocusedMenuItem  for Menu Options
  //                       FocusedMenuItem(
  //                           title: Text("Open"),
  //                           trailingIcon: Icon(Icons.open_in_new),
  //                           onPressed: () {
  //                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenTwo()));
  //                           }),
  //                       FocusedMenuItem(
  //                           title: Text("Share"),
  //                           trailingIcon: Icon(Icons.share),
  //                           onPressed: () {}),
  //                       FocusedMenuItem(
  //                           title: Text("Favorite"),
  //                           trailingIcon: Icon(Icons.favorite_border),
  //                           onPressed: () {}),
  //                       FocusedMenuItem(
  //                           title: Text(
  //                             "Delete",
  //                             style: TextStyle(color: Colors.redAccent),
  //                           ),
  //                           trailingIcon: Icon(
  //                             Icons.delete,
  //                             color: Colors.redAccent,
  //                           ),
  //                           onPressed: () {}),
  //                     ],
  //                   )),
  //             ],
  //           ));
  //     },
  //   );
  // }

  Widget _WidgetChildDrag(File imageFile, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _images[index].setEditState(!_images[index].getEditState);
        });
      },
      child: Container(
        height: _images[index].getSize.height,
        width: _images[index].getSize.width,
        child: Stack(
          children: [
            Positioned(
              top: 15,
              child: Container(
                height: size.width * 0.5,
                width: size.width * 0.5,
                child: ClipRRect(
                  child: Image.file(imageFile),
                ),
              ),
            ),
            _images[index].getEditState
                ? Positioned(
                    top: 0,
                    right: 25,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: IconButton(
                          alignment: Alignment.center,
                          iconSize: 15,
                          onPressed: () {
                            setState(() {
                              _images[index].setState(3);
                              if (_images[index].getState == 3) {
                                _images.removeAt(index);
                                if (_images.length == 0)
                                  _diaryEditViewModel.setBottomStateController(
                                      0, false);
                              }
                            });
                          },
                          icon: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          )),
                    ))
                : Container(),
            _images[index].getEditState
                ? Positioned(
                    bottom: 10,
                    right: 25,
                    child: InkWell(
                      onTapCancel: () {
                        print('ontapcancle');
                        _images[index].setResizeState(true);
                        setState(() {});
                      },
                      onHover: (value) {
                        print('onhover');
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: IconButton(
                            alignment: Alignment.center,
                            iconSize: 15,
                            onPressed: () {},
                            icon: RotatedBox(
                              quarterTurns: 1,
                              child: Icon(
                                Icons.open_in_full_rounded,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _WidgetFeedbackDrag(File imageFile) {
    return Opacity(
      opacity: 0.5,
      child: Container(
        height: size.width * 0.6,
        width: size.width * 0.6,
        child: Stack(
          children: [
            Positioned(
              top: 15,
              child: Container(
                height: size.width * 0.5,
                width: size.width * 0.5,
                child: ClipRRect(
                  child: Image.file(imageFile),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _checkEmotionOfffset(Offset offset) {
    if (offset.dx < 0 ||
        offset.dx > size.width - 50 ||
        offset.dy > size.height - size.height * 0.07 - 85 ||
        offset.dy < _space)
      return false;
    else
      return true;
  }

  bool _checkImageOffset(Offset offset, Size sizeImage) {
    if (offset.dx < -sizeImage.width * 0.5 ||
        offset.dx > size.width - sizeImage.width * 0.5 ||
        offset.dy > size.height - size.height * 0.07 - sizeImage.height * 0.5 ||
        offset.dy < _space - 15)
      return false;
    else
      return true;
  }

  Widget _addEditTextWidget(MapEntry<int, MyText> e, double space) {
    return Positioned(
        left: e.value.getOffset.dx,
        top: e.value.getOffset.dy - space,
        child: Material(
          child: Draggable(
            child: Material(
              child: Container(
                width: size.width * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellow.withOpacity(0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    initialValue: e.value.getTextContent,
                    onChanged: (value) {
                      e.value.setTextContent(value);
                    },
                    cursorColor: Colors.yellow[900],
                    minLines: 1,
                    maxLines: 50,
                    style: GoogleFonts.dancingScript(
                      fontSize: 20,
                      color: Colors.yellow[900],
                    ),
                    decoration: InputDecoration(
                        hintText: 'Bạn đang nghĩ gì?',
                        hintStyle: GoogleFonts.dancingScript(
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            feedback: Material(
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: size.width * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellow.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      // controller: _contentController,
                      initialValue: e.value.getTextContent,
                      readOnly: true,
                      focusNode: _focusTyping,
                      // onTap: () {
                      //   // if (_isEditButtonTaped == false)
                      //   //   Scaffold.of(context).showSnackBar(snackBar);
                      // },
                      onChanged: (value) {
                        e.value.setTextContent(value);
                      },
                      cursorColor: Colors.yellow[900],
                      minLines: 1,
                      maxLines: 50,
                      style: GoogleFonts.dancingScript(
                          fontSize: 20, color: Colors.brown[500]),
                      decoration: InputDecoration(border: InputBorder.none),
                      // decoration: InputDecoration(
                      //     enabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(5),
                      //         borderSide: BorderSide(color: Colors.black)),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(5),
                      //         borderSide: BorderSide(color: Colors.black)),
                      //     focusedBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(5),
                      //         borderSide: BorderSide(color: Colors.black))),
                    ),
                  ),
                ),
              ),
            ),
            childWhenDragging: Container(),
            onDraggableCanceled: (velocity, offset) {
              setState(() {
                e.value.setOffset(offset);
              });
            },
          ),
        ));
  }
}

void showPopUp(GlobalKey key, List<Emotion> emotions) {
  PopupMenu menu = PopupMenu(
    backgroundColor: Colors.black,
    lineColor: Colors.yellow[900],
    maxColumn: 5,
    items: emotions.asMap().entries.map((e) => MenuEmtionItem(e)).toList(),
    onClickMenu: (item) {
      Emotion _emotion = emotions
          .firstWhere((element) => element.getEmotionName == item.menuTitle);

      // Component _component = Component(Offset(10, 150), Size(0, 0));

      // _emotion.setEmotionComponent(_component);
      // print('\nshowPopUp' +
      //     _emotion.getEmotionComponent.getOffset.dx.toString() +
      //     _emotion.getEmotionComponent.getOffset.dy.toString());
      print(_emotion.getEmotionName);
      _diaryEditViewModel.setEmotionStatus(_emotion);
      _diaryEditViewModel.setBottomStateController(2, true);
      // _emotionOffset
    },
    onDismiss: () {},
  );
  menu.show(widgetKey: key);
}

MenuItem MenuEmtionItem(MapEntry<int, Emotion> e) {
  return MenuItem(
      textStyle: TextStyle(
          color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      title: e.value.getEmotionName,
      image: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: SvgPicture.asset(
          e.value.getEmotionImage,
        ),
      ));
}

/// grid view
// Widget ImageListWidget(List<File> imageFiles) {
//   if (imageFiles.isEmpty) return Container();

//   return Container(
//     height: size.height * 0.5,
//     width: size.width,
//     child: GridView.count(
//       physics: NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       crossAxisSpacing: 12,
//       mainAxisSpacing: 12,
//       children: imageFiles
//           .asMap()
//           .entries
//           .map((imageFile) => Draggable(
//                 feedback: Container(
//                   height: size.width * 0.5,
//                   width: size.width * 0.5,
//                   child: Opacity(
//                     opacity: 0.5,
//                     child: ClipRRect(
//                       child: Image.file(imageFile.value),
//                     ),
//                   ),
//                 ),
//                 childWhenDragging: Container(
//                   height: size.width * 0.5,
//                   width: size.width * 0.5,
//                   child: Opacity(
//                     opacity: 0.5,
//                     child: ClipRRect(
//                       child: Image.file(imageFile.value),
//                     ),
//                   ),
//                 ),
//                 child: Container(
//                   height: size.width * 0.5,
//                   width: size.width * 0.5,
//                   child: ClipRRect(
//                     child: Image.file(imageFile.value),
//                   ),
//                 ),
//                 onDraggableCanceled: (velocity, offset) {
//                   imageFiles.forEach((element) {
//                     print(element);
//                   });

//                   setState(() {
//                     addImageWidget(imageFile.value, offset);
//                     imageFiles.removeAt(imageFile.key);

//                     // _imageDragged = imageFile.value;
//                     // _offsetImage = offset;
//                     // sizeImage = Size(size.width * 0.5, size.width * 0.5);
//                   });
//                 },
//               ))
//           .toList(),
//     ),
//   );
// }
////ha dang tessst
// // ignore: must_be_immutable
// class DragItem extends StatefulWidget {
//   File imageFile;
//   int index;
//   double space;
//   DragItem(File imageFile, int index, double space) {
//     this.imageFile = imageFile;
//     this.index = index;
//     this.space = space;
//   }
//   @override
//   _DragItemState createState() => _DragItemState();
// }

// class _DragItemState extends State<DragItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//         left: _imageOffsets[widget.index].dx,
//         top: _imageOffsets[widget.index].dy == 0
//             ? 0
//             : _imageOffsets[widget.index].dy - widget.space,
//         child: Draggable(
//           feedback: WidgetFeedbackDrag(widget.imageFile),
//           childWhenDragging: Container(),
//           child: WidgetChildDrag(widget.imageFile, widget.index),
//           onDraggableCanceled: (velocity, offset) {
//             setState(() {
//               _imageOffsets[widget.index] = offset;
//               // _imageFiles.removeAt(index);
//               print('\n2.' + _isMoved.toString());
//               if (_isMoved == true) {
//                 _imageFiles.removeAt(widget.index);
//               }
//               // print('\n' + imageFile.toString());
//               // print('\n' + _imageOffsets[index].toString());
//             });
//           },
//         ));
//   }

//   Widget WidgetChildDrag(File imageFile, int index) {
//     return Container(
//       key: ObjectKey(index),
//       height: size.width * 0.6,
//       width: size.width * 0.6,
//       child: Stack(
//         children: [
//           Positioned(
//             top: 15,
//             child: Container(
//               height: size.width * 0.5,
//               width: size.width * 0.5,
//               child: ClipRRect(
//                 child: Image.file(imageFile),
//               ),
//             ),
//           ),
//           Positioned(
//               top: 0,
//               right: 25,
//               child: Container(
//                 height: 30,
//                 width: 30,
//                 decoration:
//                     BoxDecoration(shape: BoxShape.circle, color: Colors.black),
//                 child: IconButton(
//                     alignment: Alignment.center,
//                     iconSize: 15,
//                     onPressed: () {
//                       setState(() {
//                         _isMoved = true;
//                       });
//                     },
//                     icon: Icon(
//                       Icons.close_rounded,
//                       color: Colors.white,
//                     )),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget WidgetFeedbackDrag(File imageFile) {
//     return Opacity(
//       opacity: 0.5,
//       child: Container(
//         height: size.width * 0.6,
//         width: size.width * 0.6,
//         child: Stack(
//           children: [
//             Positioned(
//               top: 15,
//               child: Container(
//                 height: size.width * 0.5,
//                 width: size.width * 0.5,
//                 child: ClipRRect(
//                   child: Image.file(imageFile),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
