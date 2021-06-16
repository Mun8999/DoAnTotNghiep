//@dart=2.9
import 'package:bullet_journal/task/daily_task_nf/daily_task_nf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class JourneyNewsfeedView extends StatefulWidget {
  @override
  _JourneyNewsfeedViewState createState() => _JourneyNewsfeedViewState();
}

double spacing;
Size size;

class _JourneyNewsfeedViewState extends State<JourneyNewsfeedView> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    spacing = size.width * 0.02;
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
                                  // onTap: () {
                                  //   Navigator.push(context, MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return DiaryEditView(
                                  //         DiaryDB(DateTime.now()),
                                  //         state: 1,
                                  //       );
                                  //     },
                                  //   ));
                                  // },
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
    );
  }
}
