// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoteEditView extends StatefulWidget {
  const NoteEditView({Key key}) : super(key: key);

  @override
  _NoteEditViewState createState() => _NoteEditViewState();
}

Size _size;

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
                // controller: _scrollController,

                // physics: NeverScrollableScrollPhysics(),
                child: Container(
                    height: _size.height * 2,
                    width: _size.width,
                    color: Colors.white,
                    child: Column(children: [])),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            elevation: 0,
            child: Container(
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
                        // _diaryEditViewModel.setBottomStateController(
                        //     0, true);
                        // final file = await Utils.pickMedia(
                        //     isGallery: true, cropImage: cropImage);
                        // if (file == null) {
                        //   // _diaryEditViewModel.setBottomStateController(0);
                        //   return;
                        // }
                      },
                      icon: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                            'assets/icons/insert-picture-icon.svg',
                            color: Colors.yellow[600]),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/icons/edit/pen-feather-black-diagonal-shape-of-a-bird-wing.svg',
                          color: Colors.yellow[600],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/icons/emotion/smile-face.svg',
                          color: Colors.yellow[600],
                        ),
                      ),
                      onPressed: () {
                        // _diaryEditViewModel.setBottomStateController(
                        //     2, !bottomButton.data[2]);
                      },
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                            'assets/icons/pointer-on-the-map.svg',
                            color: Colors.yellow[600]),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/icons/black-shop-tag.svg',
                          color: Colors.yellow[600],
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
