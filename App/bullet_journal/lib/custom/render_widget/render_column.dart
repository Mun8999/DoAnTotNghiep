import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

class CustomColumn extends MultiChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomColumn();
  }

  CustomColumn({Key? key, List<Widget> children = const []})
      : super(key: key, children: []);
}

class CustomColumnParentData extends ContainerBoxParentData<RenderBox> {
  int? flex;
}

class RenderCustomColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CustomColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CustomColumnParentData> {
  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! CustomColumnParentData) {
      child.parentData = CustomColumnParentData();
    }
  }

  @override
  void performLayout() {
    double width = 0, height = 0;
    RenderBox? child = firstChild;
    print(child);
    while (child != null) {
      final childParentData = child.parentData as CustomColumnParentData;
      child.layout(BoxConstraints(maxWidth: constraints.maxWidth),
          parentUsesSize: true);
      height += child.size.height;
      width = max(width, child.size.width);
      child = childParentData.nextSibling;
      // print('width' + width.toString() + 'height' + height.toString());
    }
    child = firstChild;
    var childOffset = Offset(0, 0);
    while (child != null) {
      final childParentData = child.parentData as CustomColumnParentData;
      childParentData.offset = Offset(0, childOffset.dy);
      childOffset += Offset(0, child.size.height);
      child = childParentData.nextSibling;
      // print('width' + width.toString() + 'height' + height.toString());
    }
    size = Size(width, height);
    print('width' + width.toString() + 'height' + height.toString());
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  // @override
  // void applyPaintTransform(covariant RenderObject child, Matrix4 transform) {
  //   // TODO: implement applyPaintTransform
  //   super.applyPaintTransform(child, transform);
  // }
}
