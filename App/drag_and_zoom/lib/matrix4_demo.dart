import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Matrix4Demo extends StatefulWidget {
  const Matrix4Demo({Key? key}) : super(key: key);

  @override
  _Matrix4DemoState createState() => _Matrix4DemoState();
}

double x = 0;
double y = 0;
double z = 0;
double scale = 1.0;
double preScale = 1.0;

class _Matrix4DemoState extends State<Matrix4Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          child: GestureDetector(
            onScaleStart: (details) {
              print(details);
              preScale = scale;
              setState(() {});
            },
            onScaleUpdate: (details) {
              print(details);
              scale = preScale * details.scale;
              setState(() {});
            },
            onScaleEnd: (details) {
              print(details);
              preScale = 1.0;
              setState(() {});
            },
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.diagonal3(Vector3(scale, scale, scale)),
              child: Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage('assets/FB_IMG_1619035803604.jpg'),
                        fit: BoxFit.contain)),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
