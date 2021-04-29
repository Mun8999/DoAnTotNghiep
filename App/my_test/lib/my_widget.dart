import 'package:flutter/material.dart';
import 'package:my_test/photo_view.dart';
// import 'package:my_app_demo/my_photo_view/lib/photo_view.dart';
// import 'photo_view.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

Offset _pos = Offset(0, 0);

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoView.customChild(
            childSize: Size(300, 400),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/FB_IMG_1619035803604.jpg'))),
            ))
      ],
    );
    // return Stack(
    //   children: [
    //     Positioned(
    //       left: _pos.dx,
    //       top: _pos.dy,
    //       child: Container(
    //         height: 300,
    //         width: 400,
    //         child: Draggable<String>(
    //           data: 'assets/FB_IMG_1619035803604.jpg',
    //           child: PhotoView(
    //             imageProvider: AssetImage('assets/FB_IMG_1619035803604.jpg'),
    //             // customSize: Size(40, 40),
    //           ),
    //           //     : Container()),
    //           feedback: Opacity(
    //             opacity: 0.5,
    //             child: Container(
    //                 height: 300,
    //                 width: 400,
    //                 decoration: BoxDecoration(
    //                     image: DecorationImage(
    //                         image:
    //                             AssetImage('assets/FB_IMG_1619035803604.jpg'),
    //                         fit: BoxFit.fill))),
    //           ),
    //           childWhenDragging: Container(
    //             width: 40,
    //             height: 40,
    //           ),
    //           onDraggableCanceled: (velocity, offset) {
    //             setState(() {
    //               _pos = offset;
    //             });
    //           },
    //         ),
    //       ),
    //     ),
    //   ],
    // );

    // return Stack(
    //   children: [
    //     Positioned(
    //       top: pos.dx,
    //       left: pos.dy,
    //       child: Draggable<String>(
    //         child: Container(
    //           child: PhotoView(
    //             imageProvider: AssetImage('assets/FB_IMG_1619035803604.jpg'),
    //           ),
    //         ),
    //         feedback: Container(
    //           child: PhotoView(
    //               imageProvider: AssetImage('assets/FB_IMG_1619035803604.jpg')),
    //         ),
    //         childWhenDragging: Container(
    //           width: 40,
    //           height: 40,
    //         ),
    //         onDraggableCanceled: (velocity, offset) {
    //           setState(() {
    //             pos = offset;
    //           });
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}
