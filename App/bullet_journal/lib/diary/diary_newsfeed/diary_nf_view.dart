// @dart=2.9
import 'dart:ui';

// import 'package:bullet_journel/edit_image/edit_image_view.dart';
import 'package:bullet_journal/diary/diary_edit/diary_edit_view.dart';
import 'package:bullet_journal/model/diary.dart';
import 'package:bullet_journal/model/location.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class DiaryNewFeedsView extends StatefulWidget {
  @override
  _DiaryNewFeedsViewState createState() => _DiaryNewFeedsViewState();
}

List<String> images = [
  'assets/images/FB_IMG_1618988919479.jpg',
  'assets/images/FB_IMG_1619003669083.jpg',
  'assets/images/FB_IMG_1619004242859.jpg',
  'assets/images/FB_IMG_1619006556060.jpg',
  'assets/images/FB_IMG_1619006780237.jpg',
  'assets/images/FB_IMG_1619007243993.jpg',
  'assets/images/FB_IMG_1619007315847.jpg',
  'assets/images/FB_IMG_1619032982645.jpg',
  'assets/images/FB_IMG_1619035711744.jpg',
  'assets/images/FB_IMG_1619035803604.jpg',
  'assets/images/FB_IMG_1619036146750.jpg',
  'assets/images/FB_IMG_1619036516420.jpg',
  'assets/images/FB_IMG_1619037184892.jpg',
  'assets/images/FB_IMG_1619088169362.jpg',
  'assets/images/FB_IMG_1619096684228.jpg',
  'assets/images/FB_IMG_1619157271674.jpg'
];
Size size = Size(0, 0);
// bool isTaped = false, isTapedStatus = false;

class _DiaryNewFeedsViewState extends State<DiaryNewFeedsView> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
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
                  leading: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu_rounded,
                      color: Colors.black,
                    ),
                  ),
                  title: Center(
                    child: Text(
                      'Nhật ký',
                      style: TextStyle(color: Colors.black),
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
                  expandedHeight: MediaQuery.of(context).size.height * 0.23,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          // Divider(
                          //   color: Colors.grey[300],
                          //   thickness: 1,
                          // ),
                          Container(
                            margin: EdgeInsets.all(10),
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
          child: ListView.separated(
            /// de o day de khong scroll theo cai nay
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      Diary diary = Diary(
                          '1',
                          'Đom Đóm - Jack',
                          '" Người giờ còn đây không?\nThuyền này liệu còn sang sông?\nBuổi chiều dài mênh mông\nLòng người giờ hòa hay đông?\nHồng mắt em cả bầu trời đỏ hoen\nTa như đứa trẻ ngây thơ\nQuên đi tháng ngày ngu ngơ... "',
                          DateTime.now());
                      return DiaryEditView(diary);
                    },
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    height: 250,
                    child: Stack(children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            // color: 100 * (index % 9) == 0
                            //     ? Colors.pink[50]
                            //     : Colors.pink[100 * (index % 9)],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3))
                            ]),
                        // child:
                      ),
                      Positioned(
                        top: 5,
                        left: index % 2 == 0 ? null : 5,
                        right: index % 2 != 0 ? null : 5,
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              width: 170,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: index % 2 != 0
                                          ? Radius.circular(10)
                                          : Radius.zero,
                                      bottomLeft: index % 2 != 0
                                          ? Radius.circular(10)
                                          : Radius.zero,
                                      topRight: index % 2 == 0
                                          ? Radius.circular(10)
                                          : Radius.zero,
                                      bottomRight: index % 2 == 0
                                          ? Radius.circular(10)
                                          : Radius.zero),
                                  color: 100 * (index % 9) == 0
                                      ? Colors.yellow[50]
                                      : Colors.yellow[100 * (index % 9)]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Đom Đóm - Jack',
                                        style: GoogleFonts.dancingScript(
                                            fontSize: 16,
                                            color: Colors.brown[800],
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        '" Người giờ còn đây không?\nThuyền này liệu còn sang sông?\nBuổi chiều dài mênh mông\nLòng người giờ hòa hay đông?\nHồng mắt em cả bầu trời đỏ hoen\nTa như đứa trẻ ngây thơ\nQuên đi tháng ngày ngu ngơ... "',
                                        style: GoogleFonts.dancingScript(
                                            fontSize: 13,
                                            color: Colors.brown[500]))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: index % 2 == 0 ? 5 : null,
                        right: index % 2 != 0 ? 5 : null,
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: index % 2 == 0
                                    ? Radius.circular(10)
                                    : Radius.zero,
                                bottomLeft: index % 2 == 0
                                    ? Radius.circular(10)
                                    : Radius.zero,
                                topRight: index % 2 != 0
                                    ? Radius.circular(10)
                                    : Radius.zero,
                                bottomRight: index % 2 != 0
                                    ? Radius.circular(10)
                                    : Radius.zero),
                            image: DecorationImage(
                                image: AssetImage(images[index]),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: index % 2 == 0 ? 10 : null,
                        right: index % 2 != 0 ? 10 : null,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text('9 tháng 9, 2021',
                                style: GoogleFonts.oswald(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.7))
                                // TextStyle(

                                //     color: Colors.white.withOpacity(0.7),
                                //     fontSize: 16),
                                ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 30,
              );
            },
          )),
    ));
  }
}
