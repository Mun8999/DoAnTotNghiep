//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Filter {
  int _id;
  String _name;
  BlendMode _blendMode;
  Color _color1;
  Color _color2;
  Filter(this._id, this._name, this._blendMode, this._color1, this._color2);
  int get getId => this._id;
  String get getName => this._name;
  BlendMode get getBlendMode => this._blendMode;
  Color get getColor1 => this._color1;
  Color get getColor2 => this._color2;
}

class Filters {
  List<Filter> _filters = [];
  Filters() {
    _initFilter();
  }
  Future _initFilter() async {
    _filters.add(
        Filter(0, 'Original', BlendMode.clear, Colors.black, Colors.black));
    List<Color> colors1 = [
      Colors.green,
      Colors.teal,
      Colors.blue,
      Colors.deepPurple,
      Colors.purple,
      Colors.pink
    ];
    List<Color> colors2 = [
      Colors.red,
      Colors.deepOrange,
      Colors.orange,
      Colors.orangeAccent,
      Colors.yellow,
      Colors.greenAccent
    ];
    List<BlendMode> blendModes = [];
    blendModes.add(BlendMode.values[2]);
    blendModes.add(BlendMode.values[4]);
    blendModes.add(BlendMode.values[15]);
    blendModes.add(BlendMode.values[16]);
    blendModes.add(BlendMode.values[19]);
    blendModes.add(BlendMode.values[21]);
    blendModes.add(BlendMode.values[25]);
    blendModes.add(BlendMode.values[27]);
    Filter filter;
    int t = 1;
    for (int i = 0; i < blendModes.length; i++) {
      for (int j = 0; j < colors1.length; j++) {
        filter = Filter(t, 'H$t', blendModes[i], colors1[j], colors2[j]);
        _filters.add(filter);
        t++;
      }
    }
    print('FilterClass? length: ' + _filters.length.toString());
  }

  List<Filter> get getFilters => this._filters;
}
