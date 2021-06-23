import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class DragImage extends StatefulWidget {
  final Offset position;
  final String image;

  DragImage(this.position, this.image);

  @override
  DragImageState createState() => DragImageState();
}

class DragImageState extends State<DragImage> {
  double? _zoom;
  double? _previousZoom;
  Offset? _previousOffset;
  Offset? _offset;
  late Offset _position;
  late String _image;
  bool _onScale = false;
  @override
  void initState() {
    _zoom = 1.0;
    _previousZoom = null;
    _offset = Offset.zero;
    _position = widget.position;
    _image = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            new Positioned(
              left: _position.dx, //horizontal
              top: _position.dy, //vertical
              child: Draggable(
                //drag and drop
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  width: 350.0,
                  height: 450.0,
                  child: new GestureDetector(
                    //zoom
                    onScaleStart: _handleScaleStart,
                    onScaleUpdate: _handleScaleUpdate,
                    onScaleEnd: _handleScaleEnd,
                    onDoubleTap: _handleScaleReset,
                    child: new Transform(
                      transform: new Matrix4.diagonal3(
                          new Vector3(_zoom!, _zoom!, _zoom!)),
                      alignment: FractionalOffset.center,
                      child: new Image.asset(_image),
                    ),
                  ),
                ),
                onDraggableCanceled: (velocity, offset) {
                  //When you stop moving the image, it is necessary to setState the new coordinates
                  setState(() {
                    _position = offset;
                  });
                },
                feedback: _onScale
                    ? Container()
                    : Opacity(
                        opacity: 0.5,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          width: 350.0,
                          height: 450.0,
                          child: new Transform(
                            transform: new Matrix4.diagonal3(
                                new Vector3(_zoom!, _zoom!, _zoom!)),
                            alignment: FractionalOffset.center,
                            child: new Image.asset(_image),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleScaleStart(ScaleStartDetails start) {
    setState(() {
      _previousOffset = _offset;
      _previousZoom = _zoom;
      _onScale = true;
    });
  }

  void _handleScaleUpdate(ScaleUpdateDetails update) {
    setState(() {
      _zoom = _previousZoom! * update.scale;
    });
  }

  void _handleScaleReset() {
    setState(() {
      _zoom = 1.0;
      _offset = Offset.zero;
      _position = Offset.zero;
    });
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    setState(() {
      _onScale = false;
    });
  }
}
