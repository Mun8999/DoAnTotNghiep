//@dart=2.9
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Matrix4Demo extends StatefulWidget {
  Matrix4Demo({Offset initOffset, double initScale});
  @override
  _Matrix4DemoState createState() => _Matrix4DemoState();
}

// double x = 0;
// double y = 0;
// double z = 0;
double _scale = 1.0;
double _preScale = 1.0;
// bool isEdit = false;
Offset _offset = Offset(10, 20);
Offset _preOffset;
GlobalKey _key = GlobalKey();
double _rotetate = 0.0;
double _preRotetate = 0.0;

class _Matrix4DemoState extends State<Matrix4Demo> {
  @override
  Widget build(BuildContext context) {
    // _offset;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          key: _key,
          left: _offset.dx,
          top: _offset.dy,
          child: GestureDetector(
              onScaleStart: (details) {
                RenderBox box = _key.currentContext.findRenderObject();
                Offset position = box.localToGlobal(Offset.zero);

                /// lấy vị trí tại điểm chạm vào màn hình trừ cho vị trí tại điểm trên cùng của widget
                _preOffset = details.focalPoint - position;
                _preScale = _scale;
                _rotetate = _preRotetate;
                // print('onScaleStart> rotetate: ' + _rotetate.toString());
                // print('onScaleStart> pre_rotetate: ' + _preRotetate.toString());
                setState(() {});
              },
              onScaleUpdate: (details) {
                /// cập nhật scale
                print('49> scale: ' + details.scale.toString());
                _scale = _preScale * details.scale;

                /// cập nhật vị trí
                _offset = details.focalPoint - _preOffset;
                _rotetate = details.rotation;
                if (_rotetate == 0.0) _rotetate = _preRotetate;
                // print('onScaleUpdate> rotetate: ' + _rotetate.toString());
                // print(
                //     'onScaleUpdate> pre_rotetate: ' + _preRotetate.toString());
                setState(() {});
              },
              onScaleEnd: (details) {
                // print(details);
                // print('>3');
                // print('onScaleEnd> rotetate: ' + _rotetate.toString());
                // print('onScaleEnd> pre_rotetate: ' + _preRotetate.toString());
                _preScale = 1.0;
                _preRotetate = _rotetate;
                setState(() {});
              },
              child: Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale))
                  ..rotateZ(_rotetate),
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: AssetImage('assets/FB_IMG_1619035803604.jpg'),
                          fit: BoxFit.contain)),
                ),
              )
              ),
        ),
      ],
    ));
  }
}
