import 'package:drag_and_zoom/interactive_view.dart';
import 'package:drag_and_zoom/matrix4_demo.dart';
import 'package:drag_and_zoom/matrix_demo.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setSystemUIOverlayStyle(
    //     // SystemUiOverlayStyle(statusBarColor: Colors.transparent
    //     // )
    //     SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bullet Journal App',
        debugShowCheckedModeBanner: false,
        home: Matrix4Demo());
  }
}
