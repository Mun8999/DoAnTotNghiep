import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class MatrixGestructor extends StatefulWidget {
  const MatrixGestructor({Key? key}) : super(key: key);

  @override
  _MatrixGestructorState createState() => _MatrixGestructorState();
}

// late Size _size;

class _MatrixGestructorState extends State<MatrixGestructor> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    final ValueNotifier<Matrix4> notifier2 = ValueNotifier(Matrix4.identity());
    // _size = MediaQuery.of(context).size;
    return Scaffold(
      body: MatrixGestureDetector(
        onMatrixUpdate: (m, tm, sm, rm) {
          notifier.value = m;
        },
        child: AnimatedBuilder(
          animation: notifier,
          builder: (context, child) {
            return Stack(
              children: [
                AnimatedBuilder(
                  animation: notifier,
                  builder: (ctx, child) {
                    return Stack(
                      children: [
                        Transform(
                          transform: notifier.value,
                          child: Container(
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/FB_IMG_1619035803604.jpg'),
                                    fit: BoxFit.contain)),
                          ),
                        ),
                      ],
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        image: DecorationImage(
                            image:
                                AssetImage('assets/FB_IMG_1619035803604.jpg'),
                            fit: BoxFit.contain)),
                  ),
                ),
                // AnimatedBuilder(
                //   animation: notifier2,
                //   builder: (ctx, child) {
                //     return Container(
                //       height: MediaQuery.of(context).size.height,
                //       width: MediaQuery.of(context).size.width,
                //       color: Colors.red,
                //       child: Stack(
                //         children: [
                //           Transform(
                //             transform: notifier2.value,
                //             child: Container(
                //               height: MediaQuery.of(context).size.width,
                //               width: MediaQuery.of(context).size.width,
                //               decoration: BoxDecoration(
                //                   color: Colors.yellow,
                //                   image: DecorationImage(
                //                       image: AssetImage(
                //                           'assets/FB_IMG_1619035803604.jpg'),
                //                       fit: BoxFit.contain)),
                //             ),
                //           ),
                //         ],
                //       ),
                //     );
                //   },
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
