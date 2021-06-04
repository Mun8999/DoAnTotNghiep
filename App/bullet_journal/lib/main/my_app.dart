import 'package:bullet_journal/diary/diary_edit/diary_edit_view.dart';
import 'package:bullet_journal/diary/diary_newsfeed/diary_nf_view.dart';
import 'package:bullet_journal/home/home_view.dart';
import 'package:bullet_journal/sticker_widget/sticker_widget_view.dart';
import 'package:bullet_journal/test/test.dart';
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
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
