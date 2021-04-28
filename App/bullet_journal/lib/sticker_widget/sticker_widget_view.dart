import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class StickerView extends StatefulWidget {
  @override
  _StickerViewState createState() => _StickerViewState();
}

List<String> stickers = [
  'assets/icons/edit/approved.png',
  'assets/icons/edit/back-arrow.png',
  'assets/icons/edit/cancel.png',
  'assets/icons/edit/crop-tool.png',
  'assets/icons/edit/edit.png',
  'assets/icons/edit/filter.png',
  'assets/icons/edit/font.png',
  'assets/icons/edit/left-arrow.png',
  'assets/icons/edit/paintbrush.png',
  'assets/icons/edit/previous.png',
  'assets/icons/edit/reply.png',
  'assets/icons/edit/tick.png'
];
// bool isMoved = false;
Color caughtColor = Colors.deepPurple;
Offset _pos = Offset(100, 100);

class _StickerViewState extends State<StickerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: SafeArea(child: LayoutBuilder(
        //   builder: (context, constraints) {
        //     return Container(
        //       width: MediaQuery.of(context).size.width,
        //       height: MediaQuery.of(context).size.height,
        //       color: Colors.black,
        //       child: PhotoView(
        //         imageProvider: AssetImage(stickers[0]),
        //         customSize: Size(40, 40),
        //       ));
        //   },
        // )

        body: SafeArea(
      child: Container(
          color: Colors.green,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: 40,
                width: 40,
                color: Colors.red,
                child: PhotoView(
                  imageProvider: AssetImage(''),
                ),
              )
            ],
          )
          // Stack(
          //   children: [
          //     Positioned(
          //       left: _pos.dx,
          //       top: _pos.dy,
          //       child: Container(
          //         height: MediaQuery.of(context).size.height,
          //         width: MediaQuery.of(context).size.width,
          //         child: Draggable<String>(
          //           data: stickers[0],
          //           child: Container(
          //               width: 40,
          //               height: 40,
          //               // color: Colors.black,
          //               decoration: BoxDecoration(
          //                   image: DecorationImage(
          //                       image: AssetImage(stickers[0]),
          //                       fit: BoxFit.fill))),
          //           // child: PhotoView(
          //           //         imageProvider: AssetImage(stickers[0]),
          //           //         customSize: Size(40, 40),
          //           //       )
          //           //     : Container()),
          //           feedback: Opacity(
          //             opacity: 0.5,
          //             child: Container(
          //                 width: 40,
          //                 height: 40,
          //                 decoration: BoxDecoration(
          //                     image: DecorationImage(
          //                         image: AssetImage(stickers[0]),
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
          //     // Container(child: ResizeImage(),
          //   ],
          // ),

          ),
    ));
  }
}
