import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DiaryNewFeedsView extends StatefulWidget {
  @override
  _DiaryNewFeedsViewState createState() => _DiaryNewFeedsViewState();
}

List<String> images = [
  'assets/images/bg_login_1.jpg',
  'assets/images/bg_login_2.jpg',
  'assets/images/bg_login_3.jpg',
  'assets/images/bg_login_4.jpg',
  'assets/images/bg_login_5.jpg',
  'assets/images/bg_login_6.png',
  'assets/images/FB_IMG_1618136235995.jpg',
  'assets/icons/icon_cat.png'
];
int imageIndex = -1;

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
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(8),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: 16,
            itemBuilder: (BuildContext context, int index) {
              imageIndex++;
              if (imageIndex == images.length - 1) imageIndex = 0;
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: AssetImage(images[imageIndex]),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 1,
                              offset: Offset(2, 2))
                        ]),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          'Happy Day',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
            // ignore: missing_return
            staggeredTileBuilder: (index) {
              return new StaggeredTile.count(2, index.isEven ? 3 : 2);
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
