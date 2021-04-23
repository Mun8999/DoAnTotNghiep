// import 'package:bullet_journel/snap_photo/snap_photo_view.dart';
import 'package:bullet_journel/diary_newsfeed/diary_nf_view.dart';
import 'package:bullet_journel/edit_image/edit_image_view.dart';
// import 'package:bullet_journel/login/login_view.dart';
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
      home: DiaryNewFeedsView(),
    );
  }
}
