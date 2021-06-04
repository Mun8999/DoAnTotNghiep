// @dart=2.9
import 'package:bullet_journal/snap_photo/snap_photo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});
  String iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SvgPicture.asset(item.iconData, color: color, size: widget.iconSize),
                SvgPicture.asset(
                  item.iconData,
                  color: color,
                  height: widget.iconSize,
                  width: widget.iconSize,
                ),
                Text(
                  item.text,
                  style: TextStyle(color: color, fontSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// class BottomNavigator extends StatefulWidget {
//   const BottomNavigator({Key key}) : super(key: key);

//   @override
//   _BottomNavigatorState createState() => _BottomNavigatorState();
// }

// Size size;
// int _selectedItem = 0;

// class _BottomNavigatorState extends State<BottomNavigator> {
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery.of(context).size;
//     // return

//     // BottomNavigationBar(
//     //   elevation: 10,
//     //   iconSize: 30,
//     //   // fixedColor: Colors.black,
//     //   items: const <BottomNavigationBarItem>[
//     //     BottomNavigationBarItem(
//     //       icon: Icon(Icons.home),
//     //       label: 'Home',
//     //     ),
//     //     BottomNavigationBarItem(
//     //       icon: Icon(Icons.business),
//     //       label: 'Business',
//     //     ),
//     //     BottomNavigationBarItem(
//     //       icon: Icon(Icons.school),
//     //       label: 'School',
//     //     ),
//     //     BottomNavigationBarItem(
//     //       icon: Icon(Icons.school),
//     //       label: 'School',
//     //     ),
//     //     BottomNavigationBarItem(
//     //       icon: Icon(Icons.school),
//     //       label: 'School',
//     //     ),
//     //   ],
//     //   currentIndex: _selectedItem,
//     //   selectedItemColor: Colors.yellow[900],
//     //   unselectedItemColor: Colors.black,
//     //   onTap: (value) {
//     //     setState(() {
//     //       _selectedItem = value;
//     //     });
//     //   },
//     //   // onTap: _onItemTapped,
//     // );
//   }
// }
