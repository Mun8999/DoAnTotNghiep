import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JourneyNewsfeedView extends StatefulWidget {
  @override
  _JourneyNewsfeedViewState createState() => _JourneyNewsfeedViewState();
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

class _JourneyNewsfeedViewState extends State<JourneyNewsfeedView> {
  @override
  Widget build(BuildContext context) {
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
                              margin: EdgeInsets.all(15),
                              height:
                                  MediaQuery.of(context).size.height * 0.125,
                              // padding: EdgeInsets.all(10),
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[600]!),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              // color: Colors.purple[50],
                              child: Stack(
                                children: [
                                  TextFormField(
                                    // showCursor: isTapedStatus,
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
                                            'assets/icons/emotion_icon.svg',
                                            height: 25,
                                            width: 25,
                                            color: Colors.red[400],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, right: 10, bottom: 10),
                                          child: SvgPicture.asset(
                                            'assets/icons/location_icon.svg',
                                            height: 25,
                                            width: 25,
                                            color: Colors.red[400],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: SvgPicture.asset(
                                            'assets/icons/picture_icon.svg',
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
          color: Colors.white,
          child: StaggeredGridView.countBuilder(
            // controller: _staggredGridController,
            physics:
                NeverScrollableScrollPhysics(), // không scroll theo widget này
            // shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 4,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Stack(children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 50),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // color: 100 * (index % 9) == 0
                        //     ? Colors.pink[50]
                        //     : Colors.pink[100 * (index % 9)],
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 1,
                              offset: Offset(2, 2))
                        ]),
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Hellllo',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ]),
              );
            },
            // ignore: missing_return
            staggeredTileBuilder: (index) {
              return new StaggeredTile.count(2, index.isEven ? 3 : 4);
            },
            // staggeredTileBuilder: (int index) =>
            //     new StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        ),
      ),
    );
  }
}
