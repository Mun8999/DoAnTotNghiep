// @dart=2.9
import 'package:bullet_journal/edit_image/edit_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyBox extends Element {
  MyBox(Widget widget) : super(widget);

  @override
  bool get debugDoingBuild => throw UnimplementedError();

  @override
  void performRebuild() {}
  @override
  Element updateChild(Element child, Widget newWidget, Object newSlot) {
    return super.updateChild(child, newWidget, newSlot);
  }
}
