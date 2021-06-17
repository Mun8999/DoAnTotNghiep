// @dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:numberpicker/numberpicker.dart';

class NoteEditView extends StatefulWidget {
  const NoteEditView({Key key}) : super(key: key);

  @override
  _NoteEditViewState createState() => _NoteEditViewState();
}

Size _size;
// List<File> _images = [];
List<Asset> _images = <Asset>[];
String _error = 'No Error Dectected';

class _NoteEditViewState extends State<NoteEditView> {
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              // setState(() {
              //   _isEditButtonTaped = false;
              //   print('back' + _isEditButtonTaped.toString());
              // });
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
                // await _diaryEditViewModel.saveDiary(widget._diaryDB, _images,
                //     _editTexts, _emotion, widget._state);
                // widget._state = 2;
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
                    height: _size.height * 2,
                    width: _size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(_size.width * 0.02),
                      child: Column(children: [
                        TextFormField(
                          minLines: 1,
                          maxLines: 2,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Chủ đề',
                              hintStyle: GoogleFonts.nunitoSans(
                                  color: Colors.grey.withOpacity(0.3),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          style: GoogleFonts.nunitoSans(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          minLines: 1,
                          maxLines: 20,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nội dung',
                              hintStyle: GoogleFonts.nunitoSans(
                                  color: Colors.grey.withOpacity(0.3),
                                  fontSize: 18)),
                          style: GoogleFonts.nunitoSans(fontSize: 18),
                        ),
                        Expanded(flex: 2, child: buildGridView()),
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
                        // _diaryEditViewModel.setBottomStateController(
                        //     0, true);
                        // final file = await Utils.pickMedia(
                        //     isGallery: true, cropImage: cropImage);
                        // if (file == null) {
                        //   // _diaryEditViewModel.setBottomStateController(0);
                        //   return;
                        // }
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
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.keyboard_voice_rounded,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                    IconButton(
                      icon: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/icons/emotion/smile-face.svg',
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                            'assets/icons/pointer-on-the-map.svg',
                            color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/icons/black-shop-tag.svg',
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ))));
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
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

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: _size.width * 0.02,
      mainAxisSpacing: _size.width * 0.02,
      children: List.generate(_images.length, (index) {
        Asset asset = _images[index];
        return
            // Container(
            //   height: _size.width * 0.5,
            //   width: _size.width * 0.5,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage(
            //               'multi_image_picker/image/' + asset.identifier))),
            // );
            Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_size.width * 0.02)),
          child: AssetThumb(
            asset: asset,
            width: 500,
            height: 500,
          ),
        );
      }),
    );
  }
}
