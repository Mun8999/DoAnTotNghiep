// @dart=2.9

import 'package:hive/hive.dart';
part 'db_component.g.dart';

@HiveType(typeId: 0)
class ComponentDB extends HiveObject {
  @HiveField(0)
  double offset_dx;
  @HiveField(1)
  double offset_dy;
  @HiveField(2)
  double size_width;
  @HiveField(3)
  double size_height;
  @HiveField(4)
  double opacity;
  @HiveField(5)
  int state;
  ComponentDB(double offset_dx, double offset_dy, double size_width,
      double size_height, double opacity,
      {int state = 1}) {
    this.offset_dx = offset_dx;
    this.offset_dy = offset_dy;
    this.size_width = size_width;
    this.size_height = size_height;
    this.opacity = opacity;
    this.state = state;
  }
  // double get getOffsetDx => this._offset_dx;
  // double get getOffsetDy => this._offset_dy;
  // double get getSizeWidth => this._size_width;
  // double get getSizeHeight => this._size_height;
  // double get getOpacity => this._opacity;
}
