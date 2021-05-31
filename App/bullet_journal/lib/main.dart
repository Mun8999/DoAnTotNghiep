// @dart=2.9
import 'package:bullet_journal/database/db_address.dart';
import 'package:bullet_journal/database/db_component.dart';
import 'package:bullet_journal/database/db_diary.dart';
import 'package:bullet_journal/database/db_emotion.dart';
import 'package:bullet_journal/database/db_image.dart';
import 'package:bullet_journal/database/db_text.dart';
import 'package:bullet_journal/main/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive
    ..registerAdapter(DiaryDBAdapter())
    ..registerAdapter(ImageDBAdapter())
    ..registerAdapter(TextDBAdapter())
    ..registerAdapter(EmotionDBAdapter())
    ..registerAdapter(AddressDBAdapter())
    ..registerAdapter(
        ComponentDBAdapter()); // bai hoc xuong mau> class extend phai de o cuoi cung nha -_-

  await Hive.openBox<DiaryDB>('diaries');
  runApp(MyApp());
  // SystemChrome.setEnabledSystemUIOverlays(
  //   SystemUiOverlayStyle.light(
  //   statusBarColor: Colors.white,
  //   statusBarBrightness: Brightness.dark,
  //   statusBarIconBrightness: Brightness.dark,
  // ));
}
