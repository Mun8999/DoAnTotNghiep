// @dart=2.9
import 'dart:io';
import 'dart:ui';

// import 'package:bullet_journel/edit_image/edit_image_view.dart';
import 'package:bullet_journal/database/db_diary.dart';
import 'package:bullet_journal/diary/diary_edit/diary_edit_test.dart';
import 'package:bullet_journal/diary/diary_edit/diary_edit_view.dart';
import 'package:bullet_journal/diary/diary_newsfeed/diary_nf_viewmodel.dart';
import 'package:bullet_journal/model/calendar/time.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DiaryNewFeedsView extends StatefulWidget {
  @override
  _DiaryNewFeedsViewState createState() => _DiaryNewFeedsViewState();
}

// List<String> images = [
//   'assets/images/FB_IMG_1618988919479.jpg',
//   'assets/images/FB_IMG_1619003669083.jpg',
//   'assets/images/FB_IMG_1619004242859.jpg',
//   'assets/images/FB_IMG_1619006556060.jpg',
//   'assets/images/FB_IMG_1619006780237.jpg',
//   'assets/images/FB_IMG_1619007243993.jpg',
//   'assets/images/FB_IMG_1619007315847.jpg',
//   'assets/images/FB_IMG_1619032982645.jpg',
//   'assets/images/FB_IMG_1619035711744.jpg',
//   'assets/images/FB_IMG_1619035803604.jpg',
//   'assets/images/FB_IMG_1619036146750.jpg',
//   'assets/images/FB_IMG_1619036516420.jpg',
//   'assets/images/FB_IMG_1619037184892.jpg',
//   'assets/images/FB_IMG_1619088169362.jpg',
//   'assets/images/FB_IMG_1619096684228.jpg',
//   'assets/images/FB_IMG_1619157271674.jpg'
// ];
// bool isTaped = false, isTapedStatus = false;
Size _size;
double _spacing;
DiaryNewsFeedViewModel _diaryNewsFeedViewModel;
Box<DiaryDB> diaryBox;

class _DiaryNewFeedsViewState extends State<DiaryNewFeedsView> {
  @override
  void initState() {
    super.initState();
    _diaryNewsFeedViewModel = DiaryNewsFeedViewModel();
    diaryBox = Hive.box<DiaryDB>('diaries');
    // _diaryNewsFeedViewModel.prepareDB(diaryBox);
    _diaryNewsFeedViewModel.getDiaries(diaryBox);
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _spacing = _size.width * 0.02;
    return NestedScrollView(
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (context, value) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  backgroundColor: Colors.white,
                  leadingWidth: 150,
                  leading: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Style',
                          style: GoogleFonts.sacramento(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Text(
                        //   'Style',
                        //   style: GoogleFonts.righteous(
                        //     fontSize: 25,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.yellow[900],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                        ))
                  ],
                  floating: true,
                  pinned: true,
                  snap: false,
                  elevation: 1,
                  expandedHeight: MediaQuery.of(context).size.height * 0.27,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Container(
                            margin: EdgeInsets.all(_spacing),
                            height: MediaQuery.of(context).size.height * 0.125,
                            // padding: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[600]),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            // color: Colors.purple[50],
                            child: Stack(
                              children: [
                                // TextFormField(
                                //   // showCursor: isTapedStatus,
                                //   readOnly: true,
                                //   onTap: () {
                                //     Navigator.push(context, MaterialPageRoute(
                                //       builder: (context) {
                                //         return DiaryEditView(
                                //           DiaryDB(DateTime.now()),
                                //           state: 1,
                                //         );
                                //       },
                                //     ));
                                //   },
                                //   maxLines: 3,
                                //   style: TextStyle(fontSize: 16),
                                //   cursorColor: Colors.black,
                                //   decoration: InputDecoration(
                                //       border: InputBorder.none,
                                //       hintText: 'Hôm nay bạn thế nào?',
                                //       hintStyle:
                                //           TextStyle(color: Colors.grey[500])),
                                // ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return DiaryEditViewTest(
                                          DiaryDB(DateTime.now()),
                                          state: 1,
                                        );
                                      },
                                    ));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top: _spacing),
                                    child: Container(
                                      width: _size.width,
                                      child: Text('Hôm nay bạn thế nào?',
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 18)),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 10, bottom: 10),
                                        child: SvgPicture.asset(
                                          'assets/icons/emotion/smile-face.svg',
                                          height: 25,
                                          width: 25,
                                          color: Colors.red[400],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 10, bottom: 10),
                                        child: SvgPicture.asset(
                                          'assets/icons/insert-picture-icon.svg',
                                          height: 25,
                                          width: 25,
                                          color: Colors.red[400],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: SvgPicture.asset(
                                          'assets/icons/pointer-on-the-map.svg',
                                          height: 25,
                                          width: 25,
                                          color: Colors.red[400],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          )
        ];
      },
      body: Container(
          height: _size.height,
          color: Colors.white,
          child: ValueListenableBuilder(
            valueListenable: diaryBox.listenable(),
            builder: (context, Box<DiaryDB> diaryBox, child) {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  // diaryBox.values.elementAt(index).diaryId = index;
                  return _itemDiaryList(diaryBox.getAt(index), index);
                },
                itemCount: diaryBox.values.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: _size.height * 0.015,
                  );
                },

                // children: diaryBox.values
                //     .toList()
                //     .asMap()
                //     .entries
                //     .map((e) => _itemDiaryList(e))
              );
            },
          )),
    );
    // Scaffold(
    //   body:
    //   // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    //   // floatingActionButton: FloatingActionButton(
    //   //   backgroundColor: Colors.yellow[900],
    //   //   onPressed: () {},
    //   //   child: SvgPicture.asset(
    //   //     'assets/icons/menu/home-with-hearth.svg',
    //   //     height: 30,
    //   //     width: 30,
    //   //     color: Colors.white,
    //   //   ),
    //   //   elevation: 2.0,
    //   // ),
    //   // bottomNavigationBar: FABBottomAppBar(
    //   //   centerItemText: 'Trang chủ',
    //   //   color: Colors.black38,
    //   //   backgroundColor: Colors.white,
    //   //   selectedColor: Colors.black,
    //   //   notchedShape: CircularNotchedRectangle(),
    //   //   onTabSelected: (value) {
    //   //     switch (value) {
    //   //       case 0:
    //   //         {
    //   //           Navigator.push(
    //   //               context,
    //   //               MaterialPageRoute(
    //   //                 builder: (context) => DailyTaskNewsFeedView(),
    //   //               ));
    //   //           break;
    //   //         }
    //   //       case 1:
    //   //         {
    //   //           Navigator.push(
    //   //               context,
    //   //               MaterialPageRoute(
    //   //                 builder: (context) => JourneyNewsfeedView(),
    //   //               ));
    //   //           break;
    //   //         }
    //   //       case 2:
    //   //         {
    //   //           Navigator.push(context, MaterialPageRoute(
    //   //             builder: (context) {
    //   //               DiaryDB diary = DiaryDB(DateTime.now());
    //   //               return DiaryEditView(diary);
    //   //             },
    //   //           ));
    //   //           break;
    //   //         }
    //   //       case 3:
    //   //         {
    //   //           Navigator.push(
    //   //               context,
    //   //               MaterialPageRoute(
    //   //                 builder: (context) => LoginView(),
    //   //               ));
    //   //           break;
    //   //         }
    //   //       default:
    //   //         break;
    //   //     }
    //   //   },
    //   //   items: [
    //   //     FABBottomAppBarItem(
    //   //         iconData:
    //   //             'assets/icons/menu/black-paper-calendar-with-spring.svg',
    //   //         text: 'Hoạt động'),
    //   //     FABBottomAppBarItem(
    //   //         iconData: 'assets/icons/menu/airplane-facing-left.svg',
    //   //         text: 'Chuyến đi'),
    //   //     FABBottomAppBarItem(
    //   //         iconData: 'assets/icons/menu/blank-page-folded-corner.svg',
    //   //         text: 'Ghi chú'),
    //   //     FABBottomAppBarItem(
    //   //         iconData: 'assets/icons/menu/black-user-shape.svg',
    //   //         text: 'Tài khoản'),
    //   //   ],
    //   // ),
    // );
  }

  Widget _itemDiaryList(DiaryDB item, int index) {
    // print('237> diary box: ' + diaryBox.name);
    // print('\ncontent: ' +
    //     diaryBox.getAt(index).diaryContent +
    //     '\nImage: ' +
    //     diaryBox.getAt(index).diaryImage);
///////////////123
    // print('325>item diary box image: ' + item.diaryBox.toString());
    return InkWell(
      onLongPress: () {
        print('328>item' +
            item.diaryId.toString() +
            'diary box image: ' +
            item.diaryBox.toString());
        _delete(index);
      },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            print('334>item' +
                item.diaryId.toString() +
                'diary box image: ' +
                item.diaryBox.toString());
            return DiaryEditView(
              item,
              state: 2,
            );
          },
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(_spacing),
        child: Container(
          height: _size.height * 0.27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.brown[900],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(children: [
            Positioned(
              top: _size.width * 0.02,
              left: index % 2 == 0 ? null : _size.width * 0.02,
              right: index % 2 != 0 ? null : _size.width * 0.02,
              child: Container(
                height: _size.width * 0.46,
                width: _size.width * 0.46,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft:
                            index % 2 != 0 ? Radius.circular(10) : Radius.zero,
                        bottomLeft:
                            index % 2 != 0 ? Radius.circular(10) : Radius.zero,
                        topRight:
                            index % 2 == 0 ? Radius.circular(10) : Radius.zero,
                        bottomRight:
                            index % 2 == 0 ? Radius.circular(10) : Radius.zero),
                    color: 100 * (index % 9) == 0
                        ? Colors.yellow[50]
                        : Colors.yellow[100 * (index % 9)]),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Flexible(
                      flex: 8,
                      fit: FlexFit.loose,
                      child: Padding(
                        padding: EdgeInsets.all(_spacing),
                        child: Text(
                          item.diaryContent,
                          // '" Người giờ còn đây không? Thuyền này liệu còn sang sông? Buổi chiều dài mênh mông. Lòng người giờ hòa hay đông? Hồng mắt em cả bầu trời đỏ hoen..."',
                          style: TextStyle(
                            fontFamily: 'DancingScript',
                            fontSize: 15,
                            color: Colors.brown[900],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: _size.width * 0.02,
              left: index % 2 == 0 ? _size.width * 0.02 : null,
              right: index % 2 != 0 ? _size.width * 0.02 : null,
              child: Container(
                height: _size.width * 0.46,
                width: _size.width * 0.46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft:
                          index % 2 == 0 ? Radius.circular(10) : Radius.zero,
                      bottomLeft:
                          index % 2 == 0 ? Radius.circular(10) : Radius.zero,
                      topRight:
                          index % 2 != 0 ? Radius.circular(10) : Radius.zero,
                      bottomRight:
                          index % 2 != 0 ? Radius.circular(10) : Radius.zero),
                  image: DecorationImage(
                      image: item.diaryImage.isNotEmpty
                          ? FileImage(File(item.diaryImage))
                          : AssetImage(
                              'assets/images/FB_IMG_1619006556060.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              bottom: _spacing,
              left: index % 2 != 0 ? _size.width * 0.02 : null,
              right: index % 2 == 0 ? _size.width * 0.02 : null,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    item.diaryTime.day.toString() +
                        ' tháng ' +
                        item.diaryTime.month.toString() +
                        ', ' +
                        item.diaryTime.year.toString(),
                    style: GoogleFonts.oswald(
                        fontSize: 16, color: Colors.white.withOpacity(0.7))
                    // TextStyle(

                    //     color: Colors.white.withOpacity(0.7),
                    //     fontSize: 16),
                    ),
              ),
            ),
            Positioned(
              bottom: _size.width * 0.02,
              left: index % 2 == 0 ? _size.width * 0.02 : null,
              right: index % 2 != 0 ? _size.width * 0.02 : null,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(MyDateTime(item.diaryTime).getTime.toString(),
                    style: GoogleFonts.oswald(
                        fontSize: 16, color: Colors.white.withOpacity(0.7))
                    // TextStyle(

                    //     color: Colors.white.withOpacity(0.7),
                    //     fontSize: 16),
                    ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future<void> _delete(int index) async {
    int boxIndex = diaryBox.getAt(index).diaryBox;
    diaryBox.deleteAt(index);
    diaryBox.getAt(index).diaryId--;
    var imageBox = await Hive.openBox('images' + boxIndex.toString());
    imageBox.deleteFromDisk();
    var textBox = await Hive.openBox('texts' + boxIndex.toString());
    textBox.deleteFromDisk();
    var emotionBox = await Hive.openBox('emotion' + boxIndex.toString());
    emotionBox.deleteFromDisk();
  }
}
// ListView.separated(
//   /// de o day de khong scroll theo cai nay
//   physics: NeverScrollableScrollPhysics(),
//   scrollDirection: Axis.vertical,
//   itemCount: images.length,
//   itemBuilder: (context, index) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             Diary diary = Diary(
//                 '1',
//                 'Đom Đóm - Jack',
//                 '" Người giờ còn đây không?\nThuyền này liệu còn sang sông?\nBuổi chiều dài mênh mông\nLòng người giờ hòa hay đông?\nHồng mắt em cả bầu trời đỏ hoen\nTa như đứa trẻ ngây thơ\nQuên đi tháng ngày ngu ngơ... "',
//                 DateTime.now());
//             return DiaryEditView(diary);
//           },
//         ));
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(left: 5, right: 5),
//         child: Container(
//           height: 250,
//           child: Stack(children: [
//             Container(
//               height: 250,
//               decoration: BoxDecoration(
//                   color: Colors.black,
//                   // color: 100 * (index % 9) == 0
//                   //     ? Colors.pink[50]
//                   //     : Colors.pink[100 * (index % 9)],
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 5,
//                         blurRadius: 7,
//                         offset: Offset(0, 3))
//                   ]),
//               // child:
//             ),
//             Positioned(
//               top: 5,
//               left: index % 2 == 0 ? null : 5,
//               right: index % 2 != 0 ? null : 5,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 200,
//                     width: 170,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topLeft: index % 2 != 0
//                                 ? Radius.circular(10)
//                                 : Radius.zero,
//                             bottomLeft: index % 2 != 0
//                                 ? Radius.circular(10)
//                                 : Radius.zero,
//                             topRight: index % 2 == 0
//                                 ? Radius.circular(10)
//                                 : Radius.zero,
//                             bottomRight: index % 2 == 0
//                                 ? Radius.circular(10)
//                                 : Radius.zero),
//                         color: 100 * (index % 9) == 0
//                             ? Colors.yellow[50]
//                             : Colors.yellow[100 * (index % 9)]),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Center(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text('Đom Đóm - Jack',
//                               style: GoogleFonts.dancingScript(
//                                   fontSize: 16,
//                                   color: Colors.brown[800],
//                                   fontWeight: FontWeight.bold)),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                               '" Người giờ còn đây không?\nThuyền này liệu còn sang sông?\nBuổi chiều dài mênh mông\nLòng người giờ hòa hay đông?\nHồng mắt em cả bầu trời đỏ hoen\nTa như đứa trẻ ngây thơ\nQuên đi tháng ngày ngu ngơ... "',
//                               style: GoogleFonts.dancingScript(
//                                   fontSize: 13,
//                                   color: Colors.brown[500]))
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 5,
//               left: index % 2 == 0 ? 5 : null,
//               right: index % 2 != 0 ? 5 : null,
//               child: Container(
//                 height: 200,
//                 width: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topLeft: index % 2 == 0
//                           ? Radius.circular(10)
//                           : Radius.zero,
//                       bottomLeft: index % 2 == 0
//                           ? Radius.circular(10)
//                           : Radius.zero,
//                       topRight: index % 2 != 0
//                           ? Radius.circular(10)
//                           : Radius.zero,
//                       bottomRight: index % 2 != 0
//                           ? Radius.circular(10)
//                           : Radius.zero),
//                   image: DecorationImage(
//                       image: AssetImage(images[index]),
//                       fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 5,
//               left: index % 2 == 0 ? 10 : null,
//               right: index % 2 != 0 ? 10 : null,
//               child: Container(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Text('9 tháng 9, 2021',
//                       style: GoogleFonts.oswald(
//                           fontSize: 16,
//                           color: Colors.white.withOpacity(0.7))
//                       // TextStyle(

//                       //     color: Colors.white.withOpacity(0.7),
//                       //     fontSize: 16),
//                       ),
//                 ),
//               ),
//             )
//           ]),
//         ),
//       ),
//     );
//   },
//   separatorBuilder: (BuildContext context, int index) {
//     return SizedBox(
//       height: 30,
//     );
//   },
// )
