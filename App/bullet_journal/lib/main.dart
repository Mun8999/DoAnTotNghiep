// @dart=2.9
import 'package:bullet_journal/database/db_address.dart';
import 'package:bullet_journal/database/db_asset.dart';
import 'package:bullet_journal/database/db_component.dart';
import 'package:bullet_journal/database/db_diary.dart';
import 'package:bullet_journal/database/db_emotion.dart';
import 'package:bullet_journal/database/db_image.dart';
import 'package:bullet_journal/database/db_note.dart';
import 'package:bullet_journal/database/db_text.dart';
import 'package:bullet_journal/main/my_app.dart';
import 'package:bullet_journal/database/db_dailytask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var initSettingsAndroid = AndroidInitializationSettings('blind-face');
  // var initSettingsIOS = IOSInitializationSettings(
  //   requestAlertPermission: true,
  //   requestBadgePermission: true,
  //   requestSoundPermission: true,
  //   onDidReceiveLocalNotification: (id, title, body, payload) async {},
  // );
  // var initSettings = InitializationSettings(
  //     android: initSettingsAndroid, iOS: initSettingsIOS);
  // await flutterLocalNotificationsPlugin.initialize(
  //   initSettings,
  //   onSelectNotification: (String payload) async {
  //     if (payload != null) {
  //       //     print('notification pay load: ' + payload);
  //       //     await Navigator.push(
  //       //   context,
  //       //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  //       // );
  //     }
  //   },
  // );
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive
    ..registerAdapter(DiaryDBAdapter())
    ..registerAdapter(NoteDBAdapter())
    ..registerAdapter(AssetDBAdapter())
    ..registerAdapter(ImageDBAdapter())
    ..registerAdapter(TextDBAdapter())
    ..registerAdapter(EmotionDBAdapter())
    ..registerAdapter(AddressDBAdapter())
    ..registerAdapter(ComponentDBAdapter())
    ..registerAdapter(
        DailyTaskDBAdapter()); // bai hoc xuong mau> class extend phai de o cuoi cung nha -_-

  await Hive.openBox<DiaryDB>('diaries');
  await Hive.openBox<NoteDB>('notes');
  await Hive.openBox<DailyTaskDB>('dailytasks');

  runApp(MyApp());
  // SystemChrome.setEnabledSystemUIOverlays(
  //   SystemUiOverlayStyle.light(
  //   statusBarColor: Colors.white,
  //   statusBarBrightness: Brightness.dark,
  //   statusBarIconBrightness: Brightness.dark,
  // ));
}
