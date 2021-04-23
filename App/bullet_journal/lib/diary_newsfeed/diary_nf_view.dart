import 'dart:ui';

import 'package:bullet_journel/edit_image/edit_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
bool isTaped = false;

class _DiaryNewFeedsViewState extends State<DiaryNewFeedsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.black,
            ),
          ),
          title: Center(
            child: isTaped
                ? Container(
                    height: 40,
                    child: TextField(
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        )),
                  )
                : Text(
                    'Nhật ký',
                    style: TextStyle(color: Colors.black),
                  ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isTaped = !isTaped;
                  });
                },
                icon: Icon(
                  Icons.search_rounded,
                  color: Colors.black,
                ))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          height: height,
          width: width,
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
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
                        // border: Border.all(color: Colors.black),
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
                            boxShadow: [
                              // BoxShadow(
                              //     color: Colors.grey.withOpacity(0.5),
                              //     blurRadius: 1,
                              //     offset: Offset(2, 2))
                            ]),
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
        ));
  }
}
// CustomScrollView(
//   slivers: [
//     SliverAppBar(
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         onPressed: () {},
//         icon: Icon(
//           Icons.menu_rounded,
//           color: Colors.black,
//         ),
//       ),
//       title: Center(
//         child: Text(
//           'Nhật ký',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       actions: [
//         IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.search_rounded,
//               color: Colors.black,
//             ))
//       ],
//       // floating: true,
//       floating: true, pinned: true, snap: false,
//       elevation: 10.0,
//       expandedHeight: MediaQuery.of(context).size.height * 0.2,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           color: Colors.pink[100],
//         ),
//       ),
//     ),
//     // SliverFixedExtentList(
//     //   itemExtent: 50,
//     //   delegate: SliverChildBuilderDelegate(
//     //     (BuildContext context, int index) {
//     //       return Container(
//     //         alignment: Alignment.center,
//     //         color: Colors.lightBlue[100 * (index % 9)],
//     //         // child: Text('List Item $index'),
//     //       );
//     //     },
//     //   ),
//     // ),
//     SliverFillViewport(
//         viewportFraction: 1,
//         delegate:
//             SliverChildBuilderDelegate((BuildContext context, int index) {
//           return StaggeredGridView.countBuilder(
//             crossAxisCount: 4,
//             itemCount: 12,
//             itemBuilder: (BuildContext context, int index1) =>
//                 new Container(
//                     color: Colors.teal[100 * (index1 % 9)],
//                     child: new Center(
//                       child: new CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: new Text('$index1'),
//                       ),
//                     )),
//             staggeredTileBuilder: (int index1) =>
//                 new StaggeredTile.count(2, index1.isEven ? 2 : 1),
//             mainAxisSpacing: 4.0,
//             crossAxisSpacing: 4.0,
//           );
//         }, childCount: 1)),
//   ],
// );
// Scaffold(
//     appBar: AppBar(
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         onPressed: () {},
//         icon: Icon(
//           Icons.menu_rounded,
//           color: Colors.black,
//         ),
//       ),
//       title: Center(
//         child: Text(
//           'Nhật ký',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       actions: [
//         IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.search_rounded,
//               color: Colors.black,
//             ))
//       ],
//     ),
//     body:
//     Container(
//       margin: EdgeInsets.only(top: 10),
//       child: StaggeredGridView.countBuilder(
//         crossAxisCount: 4,
//         itemCount: 18,
//         itemBuilder: (BuildContext context, int index) => new Container(
//             color: Colors.teal[100 * (index % 9)],
//             child: new Center(
//               child: new CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: new Text('$index'),
//               ),
//             )),
//         staggeredTileBuilder: (int index) =>
//             new StaggeredTile.count(2, index.isEven ? 2 : 1),
//         mainAxisSpacing: 4.0,
//         crossAxisSpacing: 4.0,
//       ),
//     ));
// return CustomScrollView(
//   slivers: [
//     SliverAppBar(
//       title: Text('kdjfkdsjfds'),
//       pinned: true,
//       expandedHeight: MediaQuery.of(context).size.height * 0.1,
//       flexibleSpace: FlexibleSpaceBar(
//           background: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5), color: Colors.red),
//       )),
//     ),

//     // SliverGrid(
//     //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//     //     maxCrossAxisExtent: 200.0,
//     //     mainAxisSpacing: 10.0,
//     //     crossAxisSpacing: 10.0,
//     //     childAspectRatio: 4.0,
//     //   ),
//     //   delegate: SliverChildBuilderDelegate(
//     //     (BuildContext context, int index) {
//     //       return Container(
//     //         alignment: Alignment.center,
//     //         color: Colors.teal[100 * (index % 9)],
//     //         // child: Text('grid item $index'),
//     //       );
//     //     },
//     //     childCount: 20,
//     //   ),
//     // ),
//     // SliverFixedExtentList(
//     //   itemExtent: 50.0,
//     //   delegate: SliverChildBuilderDelegate(
//     //     (BuildContext context, int index) {
//     //       return Container(
//     //         alignment: Alignment.center,
//     //         color: Colors.lightBlue[100 * (index % 9)],
//     //         // child: Text('List Item $index'),
//     //       );
//     //     },
//     //   ),
//     // ),
//   ],
// );
//   }
// }
// SliverFixedExtentList(
//     itemExtent: 100,
//     delegate: SliverChildListDelegate(<Widget>[
//       Container(
//         height: MediaQuery.of(context).size.height * 0.9,
//         child: ListView(children: <Widget>[
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[100],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[100],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[100],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[100],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[100],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[100],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[100],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[100],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[100],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[100],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[600],
//           ),
//           Container(
//             height: 30,
//             color: Colors.amber[500],
//           ),
//         ]),
//       )
//     ])),
