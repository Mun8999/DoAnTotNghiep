// @dart=2.9
import 'dart:io';
import 'dart:ui';

// import 'package:bullet_journel/edit_image/edit_image_view.dart';
import 'package:bullet_journal/database/db_diary.dart';
import 'package:bullet_journal/database/db_image.dart';
import 'package:bullet_journal/diary/diary_edit/diary_edit_view.dart';
import 'package:bullet_journal/diary/diary_newsfeed/diary_nf_viewmodel.dart';
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
Size size;
double spacing;
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
    size = MediaQuery.of(context).size;
    spacing = size.width * 0.02;
    return Scaffold(
        body: NestedScrollView(
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
                          'Your Style',
                          style: GoogleFonts.sacramento(
                            fontSize: 25,
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
                            margin: EdgeInsets.all(spacing),
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
                                TextFormField(
                                  // showCursor: isTapedStatus,
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return DiaryEditView(
                                          DiaryDB(DateTime.now()),
                                          state: 1,
                                        );
                                      },
                                    ));
                                  },
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 16),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Hôm nay bạn thế nào?',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[500])),
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
                                          color: Colors.yellow[900],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 10, bottom: 10),
                                        child: SvgPicture.asset(
                                          'assets/icons/insert-picture-icon.svg',
                                          height: 25,
                                          width: 25,
                                          color: Colors.yellow[900],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: SvgPicture.asset(
                                          'assets/icons/pointer-on-the-map.svg',
                                          height: 25,
                                          width: 25,
                                          color: Colors.yellow[900],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: Container(
                          //     height: size.height * 0.04,
                          //     width: size.width * 0.35,
                          //     margin: EdgeInsets.all(spacing),
                          //     decoration: BoxDecoration(
                          //         color: Colors.yellow[900],
                          //         borderRadius: BorderRadius.circular(10)),
                          //     child: Row(
                          //       mainAxisSize: MainAxisSize.min,
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         IconButton(
                          //             onPressed: () {},
                          //             icon: Icon(
                          //               Icons.send,
                          //               color: Colors.white,
                          //               size: 13,
                          //             )),
                          //         Text(
                          //           'Lưu bài viết',
                          //           style: TextStyle(color: Colors.white),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                )),
          )
        ];
      },
      body: Container(
          height: size.height,
          color: Colors.white,
          child: ValueListenableBuilder(
            valueListenable: diaryBox.listenable(),
            builder: (context, Box<DiaryDB> diaryBox, child) {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  // diaryBox.values.elementAt(index).diaryId = index;
                  return _itemDiaryList(
                      diaryBox.values.elementAt(index), index);
                },
                itemCount: diaryBox.values.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: size.height * 0.03,
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
    ));
  }

  Widget _itemDiaryList(DiaryDB item, int index) {
    // print('237> diary box: ' + diaryBox.name);
    // print('\ncontent: ' +
    //     diaryBox.getAt(index).diaryContent +
    //     '\nImage: ' +
    //     diaryBox.getAt(index).diaryImage);

    String h, m;
    if (item.diaryTime.hour < 10)
      h = '0' + item.diaryTime.hour.toString();
    else
      h = item.diaryTime.hour.toString();
    if (item.diaryTime.minute < 10)
      m = '0' + item.diaryTime.minute.toString();
    else
      m = item.diaryTime.minute.toString();
///////////////123
    return InkWell(
      // onLongPress: () {
      //   _delete(index);
      // },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            // Diary diary = Diary(
            //     '1',
            //     'Đom Đóm - Jack',
            //     '" Người giờ còn đây không?\nThuyền này liệu còn sang sông?\nBuổi chiều dài mênh mông\nLòng người giờ hòa hay đông?\nHồng mắt em cả bầu trời đỏ hoen\nTa như đứa trẻ ngây thơ\nQuên đi tháng ngày ngu ngơ... "',
            //     DateTime.now());

            return DiaryEditView(
              item,
              state: 2,
            );
          },
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(spacing),
        child: Container(
          height: size.height * 0.27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
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
              top: size.width * 0.02,
              left: index % 2 == 0 ? null : size.width * 0.02,
              right: index % 2 != 0 ? null : size.width * 0.02,
              child: Container(
                height: size.width * 0.46,
                width: size.width * 0.46,
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
                    // Flexible(
                    //   flex: 2,
                    //   fit: FlexFit.loose,
                    //   child: Padding(
                    //     padding: EdgeInsets.all(spacing),
                    //     child: Text('Đom Đóm - Jack',
                    //         style: TextStyle(
                    //             fontFamily: 'DancingScript',
                    //             fontSize: 15,
                    //             color: Colors.brown[800],
                    //             fontWeight: FontWeight.bold)),
                    //   ),
                    // ),
                    Flexible(
                      flex: 8,
                      fit: FlexFit.loose,
                      child: Padding(
                        padding: EdgeInsets.all(spacing),
                        child: Text(
                          item.diaryContent,
                          // '" Người giờ còn đây không? Thuyền này liệu còn sang sông? Buổi chiều dài mênh mông. Lòng người giờ hòa hay đông? Hồng mắt em cả bầu trời đỏ hoen..."',
                          style: TextStyle(
                            fontFamily: 'DancingScript',
                            fontSize: 15,
                            color: Colors.brown[700],
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
              top: size.width * 0.02,
              left: index % 2 == 0 ? size.width * 0.02 : null,
              right: index % 2 != 0 ? size.width * 0.02 : null,
              child: Container(
                height: size.width * 0.46,
                width: size.width * 0.46,
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
              bottom: spacing,
              left: index % 2 != 0 ? size.width * 0.02 : null,
              right: index % 2 == 0 ? size.width * 0.02 : null,
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
              bottom: size.width * 0.02,
              left: index % 2 == 0 ? size.width * 0.02 : null,
              right: index % 2 != 0 ? size.width * 0.02 : null,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(h + ':' + m,
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
    diaryBox.deleteAt(index);
    // var imageBox = await Hive.openBox('images' + index.toString());
    // imageBox.deleteFromDisk();
    // var textBox = await Hive.openBox('texts' + index.toString());
    // textBox.deleteFromDisk();
    // var emotionBox = await Hive.openBox('emotion' + index.toString());
    // emotionBox.deleteFromDisk();
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
