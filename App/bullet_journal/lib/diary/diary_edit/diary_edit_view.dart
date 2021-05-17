// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:bullet_journal/diary/diary_edit/diary_edit_viewmodel.dart';
import 'package:bullet_journal/edit_image/utils.dart';
import 'package:bullet_journal/model/diary.dart';
import 'package:bullet_journal/model/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focused_menu/modals.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
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
// List<File> _imageFiles = [];
// List<Offset> _imageOffsets = [];
List<MyImage> _images = [];
DiaryEditViewModel _diaryEditViewModel;
double _space;
double _imageWidth;
double _imageHeight;
Size _imageSize;
String address;
// var address;

class _DiaryEditViewState extends State<DiaryEditView> {
  @override
  void initState() {
    // List<Address> address;
    Future<Position> position = _determinePosition();
    _getLocation() async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // debugPrint('location: ${position.latitude}');
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.addressLine}");
      address = first.addressLine;
    }

    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _imageWidth = size.width * 0.6;
    _imageHeight = size.width * 0.6;
    _imageSize = Size(_imageWidth, _imageHeight);
    _space = MediaQuery.of(context).padding.top + kToolbarHeight;
    _diaryEditViewModel = DiaryEditViewModel();
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
                  child: Stack(
                      children: _images
                              .asMap()
                              .entries
                              .map((e) => addImageWidget(
                                  e.value.getImageFile, e.key, _space))
                              .toList() +
                          [
                            address != null
                                ? Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(10),
                                      child: Text(address.split(', ')[0] +
                                          ', ' +
                                          address.split(', ')[1] +
                                          ',\nQuận ' +
                                          address.split(', ')[2] +
                                          ', ' +
                                          address.split(', ')[3]),
                                    ))
                                : Container(),
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
                      )),
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
                      setState(() {
                        MyImage myImage =
                            new MyImage(file, Offset.zero, _imageSize);
                        _images.add(myImage);
                      });
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
                  FocusedMenuHolder(
                    menuWidth: MediaQuery.of(context).size.width * 0.3,
                    menuBoxDecoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    // animateMenuItems: true,
                    blurBackgroundColor: Colors.black54,
                    openWithTap: true,
                    menuOffset: 5,
                    bottomOffsetHeight: 80.0,
                    child: Container(
                      height: 30,
                      width: 30,
                      // decoration: BoxDecoration(
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(15.0))),
                      child: SvgPicture.asset(
                        'assets/icons/emotion/smile-face.svg',
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                    menuItems: <FocusedMenuItem>[
                      // Add Each FocusedMenuItem  for Menu Options
                      FocusedMenuItem(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                  'assets/icons/emotion/blind-face.svg'),
                              Text('Bất ngờ'),
                            ],
                          ),
                          // trailingIcon: Icon(Icons.open_in_new),
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenTwo()));
                          }),
                      FocusedMenuItem(
                          title: Text("Share"),
                          trailingIcon: Icon(Icons.share),
                          onPressed: () {}),
                      FocusedMenuItem(
                          title: Text("Favorite"),
                          trailingIcon: Icon(Icons.favorite_border),
                          onPressed: () {}),
                      FocusedMenuItem(
                          title: Text(
                            "Delete",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          trailingIcon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {}),
                    ],
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

  Widget addImageWidget(File imageFile, int index, double space) {
    print('1.chay do thang cha roi nè');
    _images[index].setImageId(index);
    if (imageFile == null) return null;

    return Positioned(
        left: _images[index].getOffset.dx,
        top: _images[index].getOffset.dy == 0
            ? -15
            : _images[index].getOffset.dy - space,
        child: Draggable(
          feedback: _WidgetFeedbackDrag(imageFile),
          childWhenDragging: Container(),
          child: _WidgetChildDrag(imageFile, index),
          onDraggableCanceled: (velocity, offset) {
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
                InkWell(
                    onTap: () {},
                    child: FocusedMenuHolder(
                      child: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/icons/smile.svg',
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                      menuItems: <FocusedMenuItem>[
                        // Add Each FocusedMenuItem  for Menu Options
                        FocusedMenuItem(
                            title: Text("Open"),
                            trailingIcon: Icon(Icons.open_in_new),
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenTwo()));
                            }),
                        FocusedMenuItem(
                            title: Text("Share"),
                            trailingIcon: Icon(Icons.share),
                            onPressed: () {}),
                        FocusedMenuItem(
                            title: Text("Favorite"),
                            trailingIcon: Icon(Icons.favorite_border),
                            onPressed: () {}),
                        FocusedMenuItem(
                            title: Text(
                              "Delete",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            trailingIcon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {}),
                      ],
                    )
                    // Container(
                    //   height: 30,
                    //   width: 30,
                    //   child: SvgPicture.asset(
                    //     'assets/icons/smile.svg',
                    //     color: Colors.white,
                    //   ),
                    // ),
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

  Widget _WidgetChildDrag(File imageFile, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _images[index].setEditState(!_images[index].getEditState);
        });
      },
      child: Container(
        height: _images[index].getSize.height,
        width: _images[index].getSize.height,
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
                              if (_images[index].getState == 3)
                                _images.removeAt(index);
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
                            onPressed: () {
                              // setState(() {
                              //   _images[index].setState(3);
                              //   if (_images[index].getState == 3)
                              //     _images.removeAt(index);
                              // });
                            },
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
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}
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
