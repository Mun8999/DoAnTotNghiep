// @dart=2.9
import 'dart:ui';

class Component {
  Offset prevPos;
  Offset curPos;
  Size prevSize;
  Size curSize;
  double preOpacity;
  double curOpacity;
  BlendMode preBlendMode;
  BlendMode curBlendMode;
  Component(
      Offset prevPos,
      Offset curPos,
      Size prevSize,
      Size curSize,
      double preOpacity,
      double curOpacity,
      BlendMode preBlendMode,
      BlendMode curBlendMode) {
    this.prevPos = prevPos;
    this.curPos = curPos;
    this.prevSize = prevSize;
    this.curSize = curSize;
    this.preOpacity = preOpacity;
    this.curOpacity = curOpacity;
    this.preBlendMode = preBlendMode;
    this.curBlendMode = curBlendMode;
  }
  Component.previous(
    Offset prevPos,
    Size prevSize,
    double preOpacity,
    BlendMode preBlendMode,
  ) {
    this.prevPos = prevPos;
    this.prevSize = prevSize;
    this.preOpacity = preOpacity;
    this.preBlendMode = preBlendMode;
  }
  Component.current(
    Offset curPos,
    Size curSize,
    double curOpacity,
    BlendMode curBlendMode,
  ) {
    this.curPos = curPos;
    this.curSize = curSize;
    this.curOpacity = curOpacity;
    this.curBlendMode = curBlendMode;
  }
}
