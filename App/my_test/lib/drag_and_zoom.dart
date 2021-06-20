// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';

class DragImage extends StatefulWidget {
  final Offset position;
  final File image;

  DragImage(this.position, this.image);

  @override
  DragImageState createState() => DragImageState();
}

class DragImageState extends State<DragImage> {
  double _zoom;
  double _previousZoom;
  Offset _previousOffset;
  Offset _offset;
  Offset _position;
  File _image;

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
    return new Positioned(
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
            onDoubleTap: _handleScaleReset,
            child: new Transform(
              // transform: new Matrix4.diagonal3(new vector.Vector3(_zoom, _zoom, _zoom)),
              //  transform: new Matrix4.diagonal3(new vector.Vector3(_zoom, _zoom, _zoom)),
              alignment: FractionalOffset.center,
              child: new Image.file(_image),
            ),
          ),
        ),
        onDraggableCanceled: (velocity, offset) {
          //When you stop moving the image, it is necessary to setState the new coordinates
          setState(() {
            _position = offset;
          });
        },
        feedback: Container(
          //Response when moving the image. Increase the width and height to 100.0 to see the difference
          width: 1.0,
          height: 1.0,
          child: new Image.file(_image),
        ),
      ),
    );
  }

  void _handleScaleStart(ScaleStartDetails start) {
    setState(() {
      _previousOffset = _offset;
      _previousZoom = _zoom;
    });
  }

  void _handleScaleUpdate(ScaleUpdateDetails update) {
    setState(() {
      _zoom = _previousZoom * update.scale;
    });
  }

  void _handleScaleReset() {
    setState(() {
      _zoom = 1.0;
      _offset = Offset.zero;
      _position = Offset.zero;
    });
  }
}
