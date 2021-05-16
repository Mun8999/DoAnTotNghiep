import 'package:flutter/material.dart';

class CustomPaintView extends StatefulWidget {
  @override
  _CustomPaintViewState createState() => _CustomPaintViewState();
}

Size _size = Size(0, 0);

class _CustomPaintViewState extends State<CustomPaintView> {
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height,
      width: _size.width,
      child: CustomPaint(
        foregroundPainter: LinearPainter(),
      ),
    );
  }
}

class LinearPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
