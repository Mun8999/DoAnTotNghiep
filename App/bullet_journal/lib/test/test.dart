import 'package:bullet_journal/custom/render_widget/custom_expanded.dart';
import 'package:bullet_journal/custom/render_widget/render_column.dart';
import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomColumn(
        children: [
          // const CustomExpanded(child: const SizedBox()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'dsfhsdgfgfhdsgfwehgfwe\ndgfsdhgfds',
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
