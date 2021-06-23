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
    // _size = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
      body: MatrixGestureDetector(
        onMatrixUpdate: (m, tm, sm, rm) {
          notifier.value = m;
          print('>m: ' + notifier.value.toString());
        },
        child: AnimatedBuilder(
          animation: notifier,
          builder: (ctx, child) {
            return Transform(
                transform: notifier.value,
                child: Container(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                )
                // Container(
                //     decoration: BoxDecoration(
                //         // color: Colors.red,
                //         image: DecorationImage(
                //             image: AssetImage('assets/FB_IMG_1619035803604.jpg'),
                //             fit: BoxFit.contain))),
                );
          },
        ),
      ),
    ));
  }
}
