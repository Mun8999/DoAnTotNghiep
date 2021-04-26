import 'package:flutter/material.dart';

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
String _sticker = '';
String _targetImageUrl;

class _StickerViewState extends State<StickerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // GridView.builder(
            //   shrinkWrap: false,
            //   scrollDirection: Axis.vertical,
            //   gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 8),
            //   itemBuilder: (context, index) {
            //     return Card(
            //       child: Padding(
            //         padding: const EdgeInsets.all(5),
            //         child: Draggable<String>(
            //           data: stickers[index],
            //           child: Container(
            //               decoration: BoxDecoration(
            //                   color: Colors.black,
            //                   image: DecorationImage(
            //                       image: AssetImage(stickers[index]),
            //                       fit: BoxFit.fill))),
            //           feedback: Opacity(
            //             opacity: 0.5,
            //             child: Container(
            //                 decoration: BoxDecoration(
            //                     color: Colors.black,
            //                     image: DecorationImage(
            //                         image: AssetImage(stickers[index]),
            //                         fit: BoxFit.fill))),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            //   itemCount: stickers.length,
            // ),
            Draggable<String>(
              data: stickers[0],
              child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: AssetImage(stickers[0]), fit: BoxFit.fill))),
              feedback: Opacity(
                opacity: 0.5,
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage(stickers[0]), fit: BoxFit.fill))),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            DragTarget<String>(
              onAccept: (data) {
                setState(() {
                  _sticker = data;
                  print(_sticker);
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                    height: 40,
                    width: 40,
                    color: Colors.black,
                    child: _sticker.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                    image: AssetImage(_sticker),
                                    fit: BoxFit.fill)))
                        : Container());
              },
            )
            // Draggable<String>(
            //   data:
            //       "https://www.kindacode.com/wp-content/uploads/2020/11/my-dog.jpg",
            //   child: Container(
            //     width: 300,
            //     height: 200,
            //     alignment: Alignment.center,
            //     color: Colors.purple,
            //     child: Image.network(
            //       'https://www.kindacode.com/wp-content/uploads/2020/11/my-dog.jpg',
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   // The widget to show under the pointer when a drag is under way
            //   feedback: Opacity(
            //     opacity: 0.4,
            //     child: Container(
            //       color: Colors.purple,
            //       width: 300,
            //       height: 200,
            //       alignment: Alignment.center,
            //       child: Image.network(
            //         'https://www.kindacode.com/wp-content/uploads/2020/11/my-dog.jpg',
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 50),
            // ////////////////////////
            // /// Target
            // DragTarget<String>(
            //   onAccept: (value) {
            //     setState(() {
            //       _targetImageUrl = value;
            //     });
            //   },
            //   builder: (_, candidateData, rejectedData) {
            //     return Container(
            //       width: 300,
            //       height: 200,
            //       color: Colors.amber,
            //       alignment: Alignment.center,
            //       child: _targetImageUrl != null
            //           ? Image.network(
            //               _targetImageUrl,
            //               fit: BoxFit.cover,
            //             )
            //           : Container(),
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
