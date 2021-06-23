// @dart=2.9
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class MatrixGestructor extends StatefulWidget {
  const MatrixGestructor({Key key}) : super(key: key);

  @override
  _MatrixGestructorState createState() => _MatrixGestructorState();
}

Size _size;

class _MatrixGestructorState extends State<MatrixGestructor> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    _size = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
      body: MatrixGestureDetector(
        onMatrixUpdate: (m, tm, sm, rm) {
          notifier.value = m;
        },
        child: AnimatedBuilder(
          animation: notifier,
          builder: (ctx, child) {
            return Transform(
              transform: notifier.value,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: _size.width,
                    width: _size.width,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/FB_IMG_1619035803604.jpg'),fit: BoxFit.contain))),
                  // Positioned.fill(
                  //   child: Container(
                  //     transform: notifier.value,
                  //     child: FittedBox(
                  //       fit: BoxFit.contain,
                  //       child: Icon(
                  //         Icons.favorite,
                  //         color: Colors.deepPurple.withOpacity(0.5),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   decoration: FlutterLogoDecoration(),
                  //   padding: EdgeInsets.all(32),
                  //   alignment: Alignment(0, -0.5),
                  //   child: Text(
                  //     'use your two fingers to translate / rotate / scale ...',
                  //     style: Theme.of(context).textTheme.display2,
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
