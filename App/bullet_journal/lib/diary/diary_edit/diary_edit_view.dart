// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:bullet_journal/database/db_diary.dart';
import 'package:bullet_journal/database/db_emotion.dart';
import 'package:bullet_journal/database/db_image.dart';
import 'package:bullet_journal/database/db_text.dart';
import 'package:bullet_journal/diary/diary_edit/diary_edit_viewmodel.dart';
import 'package:bullet_journal/edit_image/utils.dart';
import 'package:bullet_journal/model/component.dart';
import 'package:bullet_journal/model/emotion.dart';
import 'package:bullet_journal/model/filter.dart';
import 'package:bullet_journal/model/font.dart';
import 'package:bullet_journal/model/frame.dart';
import 'package:bullet_journal/model/image.dart';
import 'package:bullet_journal/model/text.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:vector_math/vector_math_64.dart' as vector3;
import 'package:image_size_getter/image_size_getter.dart' as image_getter;

// ignore: must_be_immutable
class DiaryEditView extends StatefulWidget {
  DiaryDB _diaryDB;
  int _state;
  DiaryEditView(this._diaryDB, {int state = 2}) {
    this._state = state;
  }
  @override
  _DiaryEditViewState createState() => _DiaryEditViewState();
}

Size _size;
bool _isEditButtonTaped = false;
FocusNode _focusTyping = FocusNode();
ScrollController _scrollController;

DiaryEditViewModel _diaryEditViewModel = DiaryEditViewModel();

List<MyImage> _images = [];
double _space;
double _imageWidth;
double _imageHeight;
Size _imageSize;
Filters _filters;
List<Frame> _frames;

Emotion _emotion;
bool _emotionEditState = false;

List<MyText> _editTexts = [];
List<String> _fonts = [];

class _DiaryEditViewState extends State<DiaryEditView> {
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _diaryEditViewModel.setBottomStateController(0, false);
    _diaryEditViewModel.setBottomStateController(1, false);
    _diaryEditViewModel.setBottomStateController(2, false);
    _diaryEditViewModel.setBottomStateController(3, false);
    _diaryEditViewModel.setBottomStateController(4, false);
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _imageWidth = _size.width * 0.6;
    _imageHeight = _size.width * 0.6;
    _imageSize = Size(_imageWidth, _imageHeight);
    _space = MediaQuery.of(context).padding.top + kToolbarHeight;
    _frames = Frames().getFrames;
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
              onPressed: () async {
                await _diaryEditViewModel.saveDiary(widget._diaryDB, _images,
                    _editTexts, _emotion, widget._state);
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
                controller: _scrollController,
                child: Container(
                    height: _size.height * 2,
                    width: _size.width,
                    color: Colors.white,
                    child: StreamBuilder<List<bool>>(
                        initialData: [false, false, false, false, false],
                        stream: _diaryEditViewModel.getBottomStateStream,
                        builder: (context, bottomButton) {
                          // print('143: ' + bottomButton.data[3].toString());
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
                                        if (emotion.hasData &&
                                            emotion.data.getEmotionComponent
                                                    .getState !=
                                                3) {
                                          // print('174>> emotion state: ' +
                                          //     emotion.data.getEmotionComponent
                                          //         .getState
                                          //         .toString());
                                          _emotion = Emotion(
                                              emotion.data.getEmotionId,
                                              emotion.data.getEmotionName,
                                              emotion.data.getEmotionImage,
                                              component: Component(
                                                  emotion
                                                      .data
                                                      .getEmotionComponent
                                                      .getOffset,
                                                  Size.zero));
                                          // print('175> emotion offset: ' +
                                          //     _emotion
                                          //         .getEmotionComponent.getOffset
                                          //         .toString());
                                        }
                                        return emotion.hasData &&
                                                emotion.data.getEmotionComponent
                                                        .getState !=
                                                    3
                                            ? Positioned(
                                                left: emotion
                                                    .data
                                                    .getEmotionComponent
                                                    .getOffset
                                                    .dx,
                                                top: emotion
                                                        .data
                                                        .getEmotionComponent
                                                        .getOffset
                                                        .dy -
                                                    _space,
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
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: 50,
                                                                width: 50,
                                                                child:
                                                                    SvgPicture
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
                                                                style:
                                                                    GoogleFonts
                                                                        .koHo(),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  _diaryEditViewModel
                                                                      .setBottomStateController(
                                                                          2,
                                                                          false);
                                                                  _emotion
                                                                      .getEmotionComponent
                                                                      .setState(
                                                                          3);
                                                                  _diaryEditViewModel
                                                                      .setEmotionStatus(
                                                                          _emotion);
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
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              15,
                                                                        ))
                                                                    : Container(),
                                                              )
                                                            ],
                                                          ))),
                                                  childWhenDragging:
                                                      Container(),
                                                  onDraggableCanceled:
                                                      (velocity, offset) {
                                                    // kiem tra vi tri co ngoai man hinh ko?
                                                    if (!_checkEmotionOfffset(
                                                        offset)) return;
                                                    print('327>>>>>>>offset ' +
                                                        offset.toString());
                                                    // cong toa do neu nguoi dung cuon xuong
                                                    if (_scrollController
                                                            .offset >
                                                        0) {
                                                      offset = offset +
                                                          Offset(
                                                              0,
                                                              _scrollController
                                                                  .offset);
                                                    }
                                                    // gan lai vi tri cho stream sau khi di chuyen
                                                    _emotion
                                                        .setEmotionComponent(
                                                            Component(
                                                                offset, _size));
                                                    _diaryEditViewModel
                                                        .setEmotionStatus(
                                                            _emotion);
                                                  },
                                                ),
                                              )
                                            : Container();
                                      },
                                    ),
                                    StreamBuilder<String>(
                                        stream: _diaryEditViewModel
                                            .getAddressStream,
                                        initialData: '',
                                        builder: (context, address) {
                                          // if (address.data.isNotEmpty &&
                                          //     bottomButton.data[3]) {
                                          //   print(
                                          //       '322 address: ' + address.data);
                                          // }
                                          return address.data.isNotEmpty &&
                                                  bottomButton.data[3]
                                              ? Positioned(
                                                  right: 0,
                                                  bottom: _size.height +
                                                      _size.height * 0.22,
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
                                                              EdgeInsets.all(
                                                                  10),
                                                          child:
                                                              SvgPicture.asset(
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
                                                            style: GoogleFonts.koHo(
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
                                    // fgfdfdfdfdfdfdf
                                    ..._editTexts.asMap().entries.map(
                                        (e) => _addEditTextWidget(e, _space))
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
              ),
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
                // print('438: ' + bottomButton.data[3].toString());
                return Container(
                    margin: EdgeInsets.all(20),
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
                            _diaryEditViewModel.setBottomStateController(
                                0, true);
                            final file = await Utils.pickMedia(
                                isGallery: true, cropImage: cropImage);
                            if (file == null) {
                              if (_images.length == 0)
                                _diaryEditViewModel.setBottomStateController(
                                    0, false);
                              return;
                            }
                            setState(() {
                              Offset _initOffsetImage = Offset(0, _space);
                              if (_scrollController.offset > 0)
                                _initOffsetImage +=
                                    Offset(0, _scrollController.offset);

                              /// set offset when scroll
                              // if (_scrollController.offset > 0)
                              //   _initOffsetImage = _initOffsetImage +
                              //       Offset(0, _scrollController.offset);
                              final file_size =
                                  image_getter.ImageSizeGetter.getSize(
                                      FileInput(file));
                              double tile = file_size.height / file_size.width;
                              print('505?tỉ lệ: ' + tile.toString());
                              _imageSize =
                                  Size(_size.width, (_size.width) * tile);
                              print(
                                  '507? image size: ' + _imageSize.toString());
                              GlobalKey _key1 = GlobalKey();
                              Frame _frame = _frames[0];
                              MyImage myImage = new MyImage(
                                  file, _initOffsetImage, _imageSize,
                                  globalKey: _key1,
                                  scale: 1.0,
                                  rotetate: 0.0,
                                  imageFrame: _frame,
                                  imageFilter: _filters.getFilters[0]);
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
                            Offset _innitTextOffset = Offset(10, 100);
                            if (_scrollController.offset > 0) {
                              _innitTextOffset = _innitTextOffset +
                                  Offset(0, _scrollController.offset);
                            }
                            MyText _text = MyText(
                                'title',
                                TextStyle(
                                  fontFamily: 'DancingScript',
                                  fontSize: 18,
                                  color: Colors.yellow[900],
                                ),
                                '',
                                _innitTextOffset,
                                Size.zero,
                                textBackgroundColor: Colors.yellow[300]);
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
                        // IconButton(
                        //   onPressed: () {
                        //     _diaryEditViewModel.setBottomStateController(
                        //         4, true);
                        //   },
                        //   icon: Container(
                        //     height: 30,
                        //     width: 30,
                        //     child: SvgPicture.asset(
                        //       'assets/icons/black-shop-tag.svg',
                        //       color: bottomButton.data[4]
                        //           ? Colors.yellow[600]
                        //           : Colors.white,
                        //     ),
                        //   ),
                        // )
                      ],
                    ));
              }),
        ));
  }

  Widget _addImageWidget(File imageFile, int index, double space) {
    // print('1.chay do thang cha roi nè');

    if (imageFile == null && _images.length == 0) return null;
    _images[index].setImageId(index);
    return Positioned(
        key: _images[index].getGlobalKey,
        left: _images[index].getOffset.dx,
        top: _images[index].getOffset.dy - space,
        child: _WidgetDrag(imageFile, index));
  }

  /// hàm thêm hình ảnh lúc đầu
  // Widget _addImageWidget(File imageFile, int index, double space) {
  //   // print('1.chay do thang cha roi nè');
  //   if (imageFile == null && _images.length == 0) return null;
  //   _images[index].setImageId(index);

  //   return Positioned(
  //       left: _images[index].getOffset.dx,
  //       top: _images[index].getOffset.dy - space,
  //       child: Draggable(
  //         feedback: _WidgetFeedbackDrag(imageFile),
  //         childWhenDragging: Container(),
  //         child: _WidgetChildDrag(imageFile, index),
  //         onDraggableCanceled: (velocity, offset) {
  //           if (!_checkImageOffset(offset, _images[index].getSize)) return;
  //           setState(() {
  //             _imageSize = Size(_imageWidth, _imageHeight);
  //             if (_scrollController.offset > 0) {
  //               offset = offset + Offset(0, _scrollController.offset);
  //             }
  //             _images[index].setOffset(offset);
  //           });
  //         },
  //       ));
  // }

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

  Widget _WidgetChildDrag(File imageFile, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _images[index].setEditState(!_images[index].getEditState);
        });
        showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(_size.width * 0.07))),
          context: context,
          builder: (context) {
            return Container(
                height: _size.height * 0.4,
                width: _size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_size.width * 0.02)));
          },
        );
      },
      child: Container(
        height: _images[index].getSize.height,
        width: _images[index].getSize.width,
        child: Stack(
          children: [
            Positioned(
              top: 15,
              child: Container(
                height: _size.width * 0.5,
                width: _size.width * 0.5,
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
                          onPressed: () async {
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
                        // _images[index].setResizeState(true);
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
        height: _size.width * 0.6,
        width: _size.width * 0.6,
        child: Stack(
          children: [
            Positioned(
              top: 15,
              child: Container(
                height: _size.width * 0.5,
                width: _size.width * 0.5,
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
        offset.dx > _size.width - 50 ||
        offset.dy > _size.height - _size.height * 0.07 - 85 ||
        offset.dy < _space)
      return false;
    else
      return true;
  }

  bool _checkImageOffset(Offset offset, Size sizeImage) {
    if (offset.dx < -sizeImage.width * 0.5 ||
        offset.dx > _size.width - sizeImage.width * 0.5 ||
        offset.dy >
            _size.height - _size.height * 0.07 - sizeImage.height * 0.5 ||
        offset.dy < _space - 15)
      return false;
    else
      return true;
  }

  Widget _addEditTextWidget(MapEntry<int, MyText> e, double space) {
    e.value.setTextId(e.key);
    return Positioned(
        left: e.value.getOffset.dx,
        top: e.value.getOffset.dy - space,
        child: Container(
          width: _size.width * 0.75,
          // color: Colors.transparent,

          child: Draggable(
            child: _editTexts[e.key].getTextFrame == null
                ? Stack(
                    children: [
                      Container(
                        width: _size.width * 0.67,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(_size.width * 0.02),
                          color: _editTexts[e.key].getTextBackgroundColor,
                        ),
                        child: TextFormField(
                            onTap: () {
                              setState(() {
                                e.value.setEditState(!e.value.getEditState);
                                print('904>Edit state: ' +
                                    e.value.getEditState.toString());
                              });
                            },
                            initialValue: e.value.getTextContent,
                            onChanged: (value) {
                              e.value.setTextContent(value);
                            },
                            cursorColor: _editTexts[e.key].getTextStyle.color,
                            minLines: 2,
                            maxLines: 50,
                            style: _editTexts[e.key].getTextStyle,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10))),
                      ),
                      e.value.getEditState
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: IconButton(
                                    alignment: Alignment.center,
                                    iconSize: 15,
                                    onPressed: () async {
                                      setState(() {
                                        e.value.setState(3);
                                        if (e.value.getState == 3) {
                                          _editTexts.removeAt(e.key);
                                          if (_editTexts.length == 0)
                                            _diaryEditViewModel
                                                .setBottomStateController(
                                                    1, false);
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: Colors.white,
                                    )),
                              ))
                          : Container(),
                      e.value.getEditState
                          ? Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: IconButton(
                                    alignment: Alignment.center,
                                    iconSize: 15,
                                    onPressed: () {
                                      _showEditTextPopUp(e.key);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )),
                              ))
                          : Container(),
                    ],
                  )
                : Stack(
                    children: [
                      Transform.scale(
                        scale: _editTexts[e.key].getTextFrame.getTiLe,
                        child: Container(
                          width: _size.width * 0.67,
                          height: _size.width * 0.67,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(_size.width * 0.02),
                              image: DecorationImage(
                                  image: AssetImage(_editTexts[e.key]
                                      .getTextFrame
                                      .getFramePath),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: _size.width * 0.67 / 4,
                        child: Container(
                          width: _size.width * 0.67,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: TextFormField(
                              onTap: () {
                                setState(() {
                                  e.value.setEditState(!e.value.getEditState);
                                  print('904>Edit state: ' +
                                      e.value.getEditState.toString());
                                });
                              },
                              initialValue: e.value.getTextContent,
                              onChanged: (value) {
                                e.value.setTextContent(value);
                              },
                              cursorColor: _editTexts[e.key].getTextStyle.color,
                              minLines: 2,
                              maxLines: 50,
                              style: _editTexts[e.key].getTextStyle,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.all(_size.width * 0.02))),
                        ),
                      ),
                      e.value.getEditState
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: IconButton(
                                    alignment: Alignment.center,
                                    iconSize: 15,
                                    onPressed: () async {
                                      setState(() {
                                        e.value.setState(3);
                                        if (e.value.getState == 3) {
                                          _editTexts.removeAt(e.key);
                                          if (_editTexts.length == 0)
                                            _diaryEditViewModel
                                                .setBottomStateController(
                                                    1, false);
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: Colors.white,
                                    )),
                              ))
                          : Container(),
                      e.value.getEditState
                          ? Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: IconButton(
                                    alignment: Alignment.center,
                                    iconSize: 15,
                                    onPressed: () {
                                      _showEditTextPopUp(e.key);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )),
                              ))
                          : Container(),
                    ],
                  ),
            feedback: Opacity(
              opacity: 0.5,
              child: _editTexts[e.key].getTextFrame == null
                  ? Material(
                      child: Container(
                        width: _size.width * 0.67,
                        // color: Colors.transparent,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(_size.width * 0.02),
                          color: _editTexts[e.key].getTextBackgroundColor,
                        ),
                        child: TextFormField(
                            // controller: _contentController,
                            initialValue: e.value.getTextContent,
                            readOnly: true,
                            focusNode: _focusTyping,
                            cursorColor: _editTexts[e.key].getTextStyle.color,
                            minLines: 2,
                            maxLines: 50,
                            style: _editTexts[e.key].getTextStyle,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.all(_size.width * 0.02))

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
                    )
                  : Material(
                      child: Container(
                        width: _size.width * 0.67,
                        child: Stack(
                          children: [
                            Transform.scale(
                              scale: _editTexts[e.key].getTextFrame.getTiLe,
                              child: Container(
                                width: _size.width * 0.67,
                                height: _size.width * 0.67,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        _size.width * 0.02),
                                    image: DecorationImage(
                                        image: AssetImage(_editTexts[e.key]
                                            .getTextFrame
                                            .getFramePath),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: _size.width * 0.67 / 4,
                              child: Container(
                                width: _size.width * 0.67,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: TextFormField(
                                    initialValue: e.value.getTextContent,
                                    onChanged: (value) {
                                      e.value.setTextContent(value);
                                    },
                                    cursorColor:
                                        _editTexts[e.key].getTextStyle.color,
                                    minLines: 2,
                                    maxLines: 50,
                                    style: _editTexts[e.key].getTextStyle,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(
                                            _size.width * 0.02))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            childWhenDragging: Container(),
            onDraggableCanceled: (velocity, offset) {
              setState(() {
                if (_scrollController.offset > 0)
                  offset = offset + Offset(0, _scrollController.offset);
                e.value.setOffset(offset);
              });
            },
          ),
        ));
  }

  Offset _preOffset;
  double _preScale = 1.0;
  double _preRotetate = 0.0;

  double _scale = 1.0;
  double _rotetate = 0.0;
  Widget _WidgetDrag(File imageFile, int index) {
    // _preOffset = _images[index].getOffset;
    // _scale = _images[index].getScale;
    // _rotetate = _images[index].getRotetate;
    return GestureDetector(
        onTap: () {
          setState(() {
            _images[index].setEditState(!_images[index].getEditState);
          });
        },
        onLongPress: () {
          _showEditImagePopUp(imageFile, index);
        },
        onScaleStart: (details) {
          RenderBox box =
              _images[index].getGlobalKey.currentContext.findRenderObject();
          Offset position = box.localToGlobal(Offset.zero);

          /// lấy vị trí tại điểm chạm vào màn hình trừ cho vị trí tại điểm trên cùng của widget

          _preOffset = details.focalPoint - position;
          // if (_scrollController.offset > 0)
          //   _preOffset += Offset(0, _scrollController.offset);
          // print('853> scale: ' + _images[index].getScale.toString());
          _preScale = _images[index].getScale;
          _images[index].setRotetate(_preRotetate);

          setState(() {});
        },
        onScaleUpdate: (details) {
          /// cập nhật scale
          // print('49> offset: ' + _images[index].getOffset.toString());
          _images[index].setScale(_preScale * details.scale);

          /// cập nhật vị trí
          Offset _offset = details.focalPoint - _preOffset;
          if (_scrollController.offset > 0)
            _offset += Offset(0, _scrollController.offset);
          _images[index].setOffset(_offset);
          _images[index].setRotetate(details.rotation);
          if (_images[index].getRotetate == 0.0)
            _images[index].setRotetate(_preRotetate);

          setState(() {});
        },
        onScaleEnd: (details) {
          _preScale = 1.0;
          _preRotetate = _images[index].getRotetate;

          setState(() {});
        },
        child: Stack(
          children: [
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.diagonal3(vector3.Vector3(
                  _images[index].getScale,
                  _images[index].getScale,
                  _images[index].getScale))
                ..rotateZ(_images[index].getRotetate),
              child: Opacity(
                  opacity: _images[index].getOpacity != null
                      ? _images[index].getOpacity
                      : 1.0,
                  child: _images[index].getImageFrame.getTypeOfFrame != 0
                      ? Container(
                          height: _images[index].getSize.width,
                          width: _images[index].getSize.width,
                          ////test frame
                          decoration: BoxDecoration(
                            shape:
                                _images[index].getImageFrame.getTypeOfFrame == 1
                                    ? BoxShape.circle
                                    : BoxShape.rectangle,
                          ),
                          ////test frame
                          child: (_images[index].getImageFilter != null &&
                                  _images[index].getImageFilter.getId != 0)
                              ? Stack(
                                  children: [
                                    ////test frame
                                    Container(
                                      height: _images[index].getSize.width,
                                      width: _images[index].getSize.width,
                                      decoration: BoxDecoration(
                                          shape: _images[index]
                                                      .getImageFrame
                                                      .getTypeOfFrame ==
                                                  1
                                              ? BoxShape.circle
                                              : BoxShape.rectangle),
                                      child: _images[index]
                                                  .getImageFrame
                                                  .getTypeOfFrame ==
                                              1
                                          ? ClipOval(
                                              child: Image.file(
                                                imageFile,
                                                colorBlendMode: _images[index]
                                                    .getImageFilter
                                                    .getBlendMode,
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Image.file(
                                              imageFile,
                                              colorBlendMode: _images[index]
                                                  .getImageFilter
                                                  .getBlendMode,
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    Container(
                                      height: _images[index].getSize.width,
                                      width: _images[index].getSize.width,
                                      decoration: BoxDecoration(
                                        shape: _images[index]
                                                    .getImageFrame
                                                    .getTypeOfFrame ==
                                                1
                                            ? BoxShape.circle
                                            : BoxShape.rectangle,
                                        color: _images[index]
                                            .getImageFilter
                                            .getColor1
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                    Container(
                                      height: _images[index].getSize.width,
                                      width: _images[index].getSize.width,
                                      decoration: BoxDecoration(
                                        shape: _images[index]
                                                    .getImageFrame
                                                    .getTypeOfFrame ==
                                                1
                                            ? BoxShape.circle
                                            : BoxShape.rectangle,
                                        color: _images[index]
                                            .getImageFilter
                                            .getColor2
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                    Transform.scale(
                                      scale:
                                          _images[index].getImageFrame.getTiLe,
                                      child: Container(
                                        height: _images[index].getSize.width,
                                        width: _images[index].getSize.width,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(_images[index]
                                                    .getImageFrame
                                                    .getFramePath))),
                                      ),
                                    ),
                                    _images[index].getEditState
                                        ? Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: IconButton(
                                                  alignment: Alignment.center,
                                                  iconSize: 13,
                                                  onPressed: () async {
                                                    setState(() {
                                                      print('1170?xóaaaaaa');
                                                      _images[index]
                                                          .setState(3);
                                                      if (_images[index]
                                                              .getState ==
                                                          3) {
                                                        _images.removeAt(index);
                                                        if (_images.length == 0)
                                                          _diaryEditViewModel
                                                              .setBottomStateController(
                                                                  0, false);
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.close_rounded,
                                                    color: Colors.black,
                                                  )),
                                            ))
                                        : Container(),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    Container(
                                      height: _images[index].getSize.width,
                                      width: _images[index].getSize.width,
                                      decoration: BoxDecoration(
                                        shape: _images[index]
                                                    .getImageFrame
                                                    .getTypeOfFrame ==
                                                1
                                            ? BoxShape.circle
                                            : BoxShape.rectangle,
                                      ),
                                      child: _images[index]
                                                  .getImageFrame
                                                  .getTypeOfFrame ==
                                              1
                                          ? ClipOval(
                                              child: Image.file(
                                                imageFile,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Image.file(
                                              imageFile,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    Transform.scale(
                                      scale:
                                          _images[index].getImageFrame.getTiLe,
                                      child: Container(
                                        height: _images[index].getSize.width,
                                        width: _images[index].getSize.width,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(_images[index]
                                                    .getImageFrame
                                                    .getFramePath))),
                                      ),
                                    ),
                                    _images[index].getEditState
                                        ? Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: IconButton(
                                                  alignment: Alignment.center,
                                                  iconSize: 13,
                                                  onPressed: () async {
                                                    setState(() {
                                                      print('1170?xóaaaaaa');
                                                      _images[index]
                                                          .setState(3);
                                                      if (_images[index]
                                                              .getState ==
                                                          3) {
                                                        _images.removeAt(index);
                                                        if (_images.length == 0)
                                                          _diaryEditViewModel
                                                              .setBottomStateController(
                                                                  0, false);
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.close_rounded,
                                                    color: Colors.black,
                                                  )),
                                            ))
                                        : Container(),
                                  ],
                                ),
                        )
                      : Container(
                          height: _images[index].getSize.height,
                          width: _images[index].getSize.width,
                          ////test frame
                          // decoration: BoxDecoration(
                          //   shape: BoxShape.circle,
                          // ),
                          ////test frame
                          child: (_images[index].getImageFilter != null &&
                                  _images[index].getImageFilter.getId != 0)
                              ? Stack(
                                  children: [
                                    Container(
                                      height: _images[index].getSize.height,
                                      width: _images[index].getSize.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          _images[index].getImageRadius *
                                              0.01 *
                                              _size.width,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            _images[index].getImageRadius *
                                                0.01 *
                                                _size.width),
                                        child: Image.file(
                                          imageFile,
                                          colorBlendMode: _images[index]
                                              .getImageFilter
                                              .getBlendMode,
                                          color: Colors.white.withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: _images[index].getSize.height,
                                      width: _images[index].getSize.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            _images[index].getImageRadius *
                                                0.01 *
                                                _size.width),
                                        color: _images[index]
                                            .getImageFilter
                                            .getColor1
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                    Container(
                                      height: _images[index].getSize.height,
                                      width: _images[index].getSize.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            _images[index].getImageRadius *
                                                0.01 *
                                                _size.width),
                                        color: _images[index]
                                            .getImageFilter
                                            .getColor2
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                    _images[index].getEditState
                                        ? Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: IconButton(
                                                  alignment: Alignment.center,
                                                  iconSize: 13,
                                                  onPressed: () async {
                                                    setState(() {
                                                      print('1170?xóaaaaaa');
                                                      _images[index]
                                                          .setState(3);
                                                      if (_images[index]
                                                              .getState ==
                                                          3) {
                                                        _images.removeAt(index);
                                                        if (_images.length == 0)
                                                          _diaryEditViewModel
                                                              .setBottomStateController(
                                                                  0, false);
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.close_rounded,
                                                    color: Colors.black,
                                                  )),
                                            ))
                                        : Container(),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          _images[index].getImageRadius *
                                              0.01 *
                                              _size.width),
                                      child: Image.file(imageFile),
                                    ),
                                    _images[index].getEditState
                                        ? Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: IconButton(
                                                  alignment: Alignment.center,
                                                  iconSize: 13,
                                                  onPressed: () async {
                                                    setState(() {
                                                      print('1170?xóaaaaaa');
                                                      _images[index]
                                                          .setState(3);
                                                      if (_images[index]
                                                              .getState ==
                                                          3) {
                                                        _images.removeAt(index);
                                                        if (_images.length == 0)
                                                          _diaryEditViewModel
                                                              .setBottomStateController(
                                                                  0, false);
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.close_rounded,
                                                    color: Colors.black,
                                                  )),
                                            ))
                                        : Container(),
                                  ],
                                ),
                        )),
            ),
          ],
        ));
  }

  void showPopUp(GlobalKey key, List<Emotion> emotions) {
    PopupMenu menu = PopupMenu(
      backgroundColor: Colors.black,
      lineColor: Colors.yellow[900],
      maxColumn: 5,
      items: emotions.asMap().entries.map((e) => MenuEmtionItem(e)).toList(),
      onClickMenu: (item) {
        _emotion = emotions
            .firstWhere((element) => element.getEmotionName == item.menuTitle);

        // Component _component = Component(Offset(10, 150), Size(0, 0));

        // _emotion.setEmotionComponent(_component);
        // print('\nshowPopUp' +
        //     _emotion.getEmotionComponent.getOffset.dx.toString() +
        //     _emotion.getEmotionComponent.getOffset.dy.toString());
        print(_emotion.getEmotionName);
        _emotion.setEmotionComponent(Component(Offset(10, 150), Size.zero));
        _diaryEditViewModel.setEmotionStatus(_emotion);
        _diaryEditViewModel.setBottomStateController(2, true);
        // _emotionOffset
      },
      onDismiss: () {},
    );
    menu.show(widgetKey: key);
  }

  // ignore: non_constant_identifier_names
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

  Future _initData() async {
    _fonts = Font().getFonts;
    _filters = Filters();
    _images.clear();
    _editTexts.clear();
    await _initText();
    await _initImage();
    await _initEmotion();
    _initBottomState();
  }

  Future _initImage() async {
    var imageBox = await Hive.openBox<ImageDB>(
        'images' + widget._diaryDB.diaryBox.toString());
    // print('1105> boxId: ' + widget._diaryDB.diaryBox.toString());
    if (imageBox.length == 0) return;
    MyImage myImage;
    Filter imageFilter;
    Frame imageFrame;
    imageBox.toMap().values.forEach((image) {
      myImage = MyImage(
          File(image.imagePath),
          Offset(image.offset_dx, image.offset_dy),
          Size(image.size_width, image.size_height),
          scale: image.imageScale,
          rotetate: image.imageRotetate,
          opacity: image.opacity,
          radius: image.frameRadius,
          globalKey: new GlobalKey());
      if (image.colorFrame != null)
        myImage.setImageFrameColor(new Color(image.colorFrame));
      imageFilter = _filters.getFilters
          .firstWhere((element) => element.getId == image.filterId);
      if (imageFilter != null) myImage.setImageFilter(imageFilter);
      imageFrame =
          _frames.firstWhere((element) => element.getFrameId == image.frameId);
      if (imageFrame != null) myImage.setImageFrame(imageFrame);
      _images.add(myImage);
    });
    await imageBox.close();
  }

  Future _initText() async {
    var textBox = await Hive.openBox<TextDB>(
        'texts' + widget._diaryDB.diaryBox.toString());
    if (textBox.length == 0) return;
    MyText text;
    Frame textFrame;
    textBox.values.toList().forEach((textDB) {
      text = MyText(
          '',
          TextStyle(
              fontFamily: textDB.textFont,
              color: new Color(textDB.textColor),
              fontSize: textDB.textSize),
          textDB.textContent,
          Offset(textDB.offset_dx, textDB.offset_dy),
          _size);
      if (textDB.backgroundColor != null)
        text.setTextBackgroundColor(new Color(textDB.backgroundColor));
      if (textDB.textFrameId != null) {
        textFrame = _frames
            .firstWhere((element) => element.getFrameId == textDB.textFrameId);
        if (textFrame != null) text.setTextFram(textFrame);
      }
      _editTexts.add(text);
    });
    await textBox.close();
  }

  Future _initEmotion() async {
    // _emotion=Emotion(emotionId, emotionName, emotionImage)
    var emotionBox = await Hive.openBox<EmotionDB>(
        'emotion' + widget._diaryDB.diaryBox.toString());
    if (emotionBox.length == 0) return;
    EmotionDB emotionDB = emotionBox.getAt(0);
    if (emotionDB.state == 3) return;
    _diaryEditViewModel.setEmotionStatus(Emotion(
        emotionDB.emotionId, emotionDB.emotionName, emotionDB.emotionImage,
        component: Component(
            Offset(emotionDB.offset_dx, emotionDB.offset_dy), Size.zero)));
    await emotionBox.close();
    _diaryEditViewModel.setBottomStateController(2, true);
  }

  void _initBottomState() {
    print("1101>images length " + _images.length.toString());
    print("1102>texts length " + _editTexts.length.toString());
    if (_images.length > 0) {
      _diaryEditViewModel.setBottomStateController(0, true);
    }
    if (_editTexts.length > 0) {
      _diaryEditViewModel.setBottomStateController(1, true);
    }
    // if (_emotion.getEmotionComponent.getState == 1) {
    //   _diaryEditViewModel.setBottomStateController(2, true);
    // }
    // if()
  }

  int _filterSelected;
  int _imageMenuSelected;
  List<String> _editImageMenu = ['Bộ lọc', 'Khung', 'Độ trong suốt'];
  void _showEditImagePopUp(File imageFile, int imageIndex) {
    // int selected = 0;
    _imageMenuSelected = 0;
    if (_images[imageIndex].getImageFilter != null)
      _filterSelected = _images[imageIndex].getImageFilter.getId;
    else
      _filterSelected = 0;

    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(_size.width * 0.07))),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setEditImagePopUpState) {
            return Container(
              height: _size.height * 0.4,
              width: _size.width,
              padding: EdgeInsets.all(_size.width * 0.05),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_size.width * 0.02)),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: _size.height * 0.03,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _editImageMenu.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setEditImagePopUpState(() {
                                _imageMenuSelected = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(_size.width * 0.02),
                                  color: _imageMenuSelected != index
                                      ? Colors.black
                                      : Colors.blueGrey),
                              padding: EdgeInsets.all(_size.width * 0.01),
                              child: Center(
                                child: Text(
                                  _editImageMenu[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: _size.width * 0.02,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 9,
                      child: _EditPopUpItem(_imageMenuSelected, imageFile,
                          imageIndex, setEditImagePopUpState)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  double _radiusSelected;
  double _opacitySelected;
  Color _pickerImageFrameColor;
  Widget _EditPopUpItem(int selected, File imageFile, int imageIndex,
      StateSetter setEditImagePopUpState) {
    _radiusSelected = _images[imageIndex].getImageRadius;

    if (_images[imageIndex].getOpacity != null)
      _opacitySelected = _images[imageIndex].getOpacity * 10;
    else
      _opacitySelected = 10;
    if (_images[imageIndex].getImageFrameColor != null)
      _pickerImageFrameColor = _images[imageIndex].getImageFrameColor;
    else
      _pickerImageFrameColor = Colors.transparent;
    switch (selected) {
      case 0:
        {
          return Padding(
            padding: EdgeInsets.all(_size.width * 0.02),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _images[imageIndex]
                          .setImageFilter(_filters.getFilters[index]);
                      _filterSelected = index;
                      setEditImagePopUpState(() {});
                      setState(() {});
                    },
                    child: Container(
                      height: _size.width * 0.02,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(_size.width * 0.02)),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 9,
                            child: Stack(
                              children: [
                                Container(
                                    height: _size.height * 0.25,
                                    width: _size.height * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              _size.width * 0.02),
                                          topRight: Radius.circular(
                                              _size.width * 0.02)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              _size.width * 0.02),
                                          topRight: Radius.circular(
                                              _size.width * 0.02)),
                                      child: index != 0
                                          ? Image.file(
                                              imageFile,
                                              colorBlendMode: _filters
                                                  .getFilters[index]
                                                  .getBlendMode,
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              imageFile,
                                              fit: BoxFit.cover,
                                            ),
                                    )),
                                // Text(index.toString()),
                                index != 0
                                    ? Container(
                                        height: _size.height * 0.25,
                                        width: _size.height * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  _size.width * 0.02),
                                              topRight: Radius.circular(
                                                  _size.width * 0.02)),
                                          color: _filters
                                              .getFilters[index].getColor1
                                              .withOpacity(0.1),
                                        ),
                                      )
                                    : Container(),
                                index != 0
                                    ? Container(
                                        height: _size.height * 0.25,
                                        width: _size.height * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  _size.width * 0.02),
                                              topRight: Radius.circular(
                                                  _size.width * 0.02)),
                                          color: _filters
                                              .getFilters[index].getColor2
                                              .withOpacity(0.1),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: _size.height * 0.2,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: _filterSelected == index
                                      ? Colors.black26
                                      : Colors.black,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft:
                                          Radius.circular(_size.width * 0.02),
                                      bottomRight:
                                          Radius.circular(_size.width * 0.02))),
                              child: Text(_filters.getFilters[index].getName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: _size.width * 0.01,
                  );
                },
                itemCount: _filters.getFilters.length),
          );
        }
      case 1:
        {
          return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return index != 0
                    ? InkWell(
                        onTap: () {
                          _images[imageIndex].setImageFrame(_frames[index]);
                          setState(() {});
                        },
                        child: Container(
                          width: _size.height * 0.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(_frames[index].getFramePath),
                                fit: BoxFit.contain),
                          ),
                        ),
                      )
                    : Container();
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: _size.width * 0.02,
                  ),
              itemCount: _frames.length);
        }
      // case 2:
      //   {
      //     return Container(
      //       child: Column(
      //         children: [
      //           Expanded(
      //             flex: 1,
      //             child: Slider(
      //               min: 0,
      //               max: 10,
      //               divisions: 10,
      //               value: radiusSelected,
      //               label: radiusSelected.round().toString(),
      //               onChanged: (value) {
      //                 radiusSelected = value;
      //                 _images[imageIndex].setImageFrameRadius(radiusSelected);
      //                 // print('1621> radius: ' +
      //                 //     _images[imageIndex].getImageRadius.toString());
      //                 setState(() {});
      //                 setEditImagePopUpState(() {});
      //               },
      //             ),
      //           ),
      //           Expanded(
      //               flex: 9,
      //               child: SizedBox(
      //                 width: _size.width,
      //                 child: Padding(
      //                   padding: EdgeInsets.all(_size.width * 0.02),
      //                   child: Card(
      //                     elevation: 2,
      //                     child: SingleChildScrollView(
      //                       child: ColorPicker(
      //                         // Use the screenPickerColor as start color.
      //                         color: _pickerImageFrameColor,
      //                         // Update the screenPickerColor using the callback.
      //                         onColorChanged: (Color color) {
      //                           setEditImagePopUpState(
      //                               () => _pickerImageFrameColor = color);
      //                           setState(() => _images[imageIndex]
      //                               .setImageFrameColor(color));
      //                         },
      //                         width: 44,
      //                         height: 44,
      //                         borderRadius: 22,
      //                         heading: Text(
      //                           'Chọn màu khung',
      //                           style: Theme.of(context).textTheme.headline5,
      //                         ),
      //                         subheading: Text(
      //                           'Độ đậm nhạt',
      //                           style: Theme.of(context).textTheme.subtitle1,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ))
      //         ],
      //       ),
      //     );
      //   }
      case 2:
        {
          return Container(
            child: Slider(
              min: 1,
              max: 10,
              divisions: 9,
              value: _opacitySelected,
              label: _opacitySelected.round().toString(),
              onChanged: (value) {
                double opacity = value / 10;
                _images[imageIndex].setOpacity(opacity);
                _opacitySelected = value;
                setEditImagePopUpState(() {});
                setState(() {});
              },
            ),
          );
        }
      default:
        {
          return Container();
        }
    }
  }

  // double opacitySelected, radiusSelected;
  // int frameselected = 0;
  // Widget _FrameImageMenu(int imageIndex, StateSetter setEditImagePopUpState) {
  //   return Expanded(
  //     flex: 9,
  //     child: ListView.separated(
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (context, index) {
  //           return index != 0
  //               ? InkWell(
  //                   onTap: () {
  //                     _images[imageIndex].setImageFrame(_frames[index]);
  //                     setState(() {});
  //                   },
  //                   child: Container(
  //                     width: _size.height * 0.2,
  //                     decoration: BoxDecoration(
  //                       image: DecorationImage(
  //                           image: AssetImage(_frames[index].getFramePath),
  //                           fit: BoxFit.contain),
  //                     ),
  //                   ),
  //                 )
  //               : Container();
  //         },
  //         separatorBuilder: (context, index) => SizedBox(
  //               width: _size.width * 0.02,
  //             ),
  //         itemCount: _frames.length),
  //   );
  // }
//  if (_images[imageIndex].getOpacity != null)
//       opacitySelected = _images[imageIndex].getOpacity * 10;
//     else
//       opacitySelected = 10;
//     // _images[imageIndex].setImageRadius(radius)
//     radiusSelected = _images[imageIndex].getImageRadius;
  // print('1592> radius: ' + _images[imageIndex].getImageRadius.toString());
// Slider(
//             min: 1,
//             max: 10,
//             divisions: 9,
//             value: opacitySelected,
//             label: opacitySelected.round().toString(),
//             onChanged: (value) {
//               double opacity = value / 10;
//               _images[imageIndex].setOpacity(opacity);
//               opacitySelected = value;
//               setEditImagePopUpState(() {});
//               setState(() {});
//             },
//           ),
//           Slider(
//             min: 0,
//             max: 10,
//             divisions: 10,
//             value: radiusSelected,
//             label: radiusSelected.round().toString(),
//             onChanged: (value) {
//               radiusSelected = value;
//               _images[imageIndex].setImageRadius(radiusSelected);
//               // print('1621> radius: ' +
//               //     _images[imageIndex].getImageRadius.toString());
//               setState(() {});
//               setEditImagePopUpState(() {});
//             },
//           ),

  int _selectedFont;
  List<String> _editTextMenu = ['Kiểu chữ', 'Màu sắc', 'Khung', 'Nền'];
  int _editTextMenuSelected;
  void _showEditTextPopUp(int key) {
    _editTextMenuSelected = 0;
    _selectedFont = _fonts.indexWhere(
        (element) => element == _editTexts[key].getTextStyle.fontFamily);
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(_size.width * 0.07))),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setEditTextPopUpMenu) {
            return Container(
              height: _size.height * 0.4,
              width: _size.width,
              padding: EdgeInsets.all(_size.width * 0.05),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(_size.width * 0.02)),
              child: _buildTextMenu(key, setEditTextPopUpMenu),
            );
          },
        );
      },
    );
  }

  Widget _buildTextMenu(int key, StateSetter setEditTextPopUpMenu) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: _size.height * 0.03,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setEditTextPopUpMenu(() {
                        _editTextMenuSelected = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(_size.width * 0.02),
                          color: _editTextMenuSelected != index
                              ? Colors.black
                              : Colors.blueGrey),
                      padding: EdgeInsets.all(_size.width * 0.01),
                      child: Center(
                        child: Text(
                          _editTextMenu[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      width: _size.width * 0.03,
                    ),
                itemCount: _editTextMenu.length),
          ),
        ),
        _builtTextMenuItem(key, setEditTextPopUpMenu),
      ],
    );
  }

  Color _pickerTextColor;
  Color _pickerBackgroundColor;
  Widget _builtTextMenuItem(int key, StateSetter setEditTextPopUpMenu) {
    _pickerTextColor = _editTexts[key].getTextStyle.color;
    _pickerBackgroundColor = _editTexts[key].getTextBackgroundColor;
    switch (_editTextMenuSelected) {
      case 0:
        {
          return Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.all(_size.width * 0.02),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setEditTextPopUpMenu(() {
                          _selectedFont = index;
                        });
                        setState(() {
                          _editTexts[key].setTextStyle(TextStyle(
                              fontFamily: _fonts[index],
                              fontSize: _editTexts[key].getTextStyle.fontSize,
                              color: _editTexts[key].getTextStyle.color));
                        });
                      },
                      child: Text(
                        _fonts[index],
                        style: TextStyle(
                            fontFamily: _fonts[index],
                            fontSize: 20,
                            color: _selectedFont == index
                                ? Colors.red
                                : Colors.black),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: _size.width * 0.02,
                      ),
                  itemCount: _fonts.length),
            ),
          );
        }
      case 1:
        {
          return Expanded(
              flex: 9,
              child: SizedBox(
                width: _size.width,
                child: Padding(
                  padding: EdgeInsets.all(_size.width * 0.02),
                  child: Card(
                    elevation: 2,
                    child: SingleChildScrollView(
                      child: ColorPicker(
                        // Use the screenPickerColor as start color.
                        color: _pickerTextColor,
                        enableOpacity: true,
                        // Update the screenPickerColor using the callback.
                        onColorChanged: (Color color) {
                          setEditTextPopUpMenu(() => _pickerTextColor = color);
                          setState(() => _editTexts[key].setTextStyle(TextStyle(
                              fontFamily:
                                  _editTexts[key].getTextStyle.fontFamily,
                              fontSize: _editTexts[key].getTextStyle.fontSize,
                              color: _pickerTextColor)));
                        },
                        width: 44,
                        height: 44,
                        borderRadius: 22,
                        heading: Text(
                          'Chọn màu chữ',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        subheading: Text(
                          'Độ đậm nhạt',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        }
      case 2:
        {
          return Expanded(
            flex: 9,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return index != 0
                      ? InkWell(
                          onTap: () {
                            _editTexts[key].setTextFram(_frames[index]);
                            setState(() {});
                          },
                          child: Container(
                            height: _size.height * 0.3,
                            width: _size.height * 0.3,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage(_frames[index].getFramePath),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        )
                      : Container();
                },
                separatorBuilder: (context, index) => SizedBox(
                      width: _size.width * 0.02,
                    ),
                itemCount: _frames.length),
          );
        }
      case 3:
        {
          return Expanded(
              flex: 9,
              child: Container(
                child: SizedBox(
                  width: _size.width,
                  child: Padding(
                    padding: EdgeInsets.all(_size.width * 0.02),
                    child: Card(
                      elevation: 2,
                      child: SingleChildScrollView(
                        child: ColorPicker(
                          // Use the screenPickerColor as start color.
                          color: _pickerBackgroundColor,
                          enableOpacity: true,
                          // Update the screenPickerColor using the callback.
                          onColorChanged: (Color color) {
                            setEditTextPopUpMenu(
                                () => _pickerBackgroundColor = color);
                            setState(() {
                              _editTexts[key].setTextBackgroundColor(color);
                              _editTexts[key].setTextFram(null);
                            });
                          },
                          width: 44,
                          height: 44,
                          borderRadius: 22,
                          heading: Text(
                            'Chọn màu nền',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          subheading: Text(
                            'Độ đậm nhạt',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        }
      default:
        {
          return Expanded(flex: 9, child: Container());
        }
    }
  }
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
