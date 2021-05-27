// @dart=2.9
import 'package:bullet_journal/database/db_address.dart';
import 'package:bullet_journal/database/db_component.dart';
import 'package:bullet_journal/database/db_emotion.dart';
import 'package:bullet_journal/database/db_image.dart';
import 'package:bullet_journal/database/db_text.dart';
import 'package:bullet_journal/main/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  await Hive
    ..initFlutter()
    ..registerAdapter(ImageDBAdapter())
    ..registerAdapter(TextDBAdapter())
    ..registerAdapter(EmotionDBAdapter())
    ..registerAdapter(AddressDBAdapter())
    ..registerAdapter(ComponentDBAdapter());
  // Hive.registerAdapter(PersonAdapter());
  // var box = await Hive.openBox<Person>('db');
  // await Hive.openBox<Person>('person1');
  // Hive.deleteBoxFromDisk('person');
  // var box2 = Boxes.getPersonBox();
  // final person = Person()
  //   ..id = 1
  //   ..name = 'Văn Thị Ngân Hà'
  //   ..age = 22;
  // // // // await box.put(1, person);
  // await box2.add(person);
  // // print('id: ' + box2.getAt(0).id.toString() + '\nten: ' + box2.getAt(0).name);

  // box2.deleteAt(0);
  // box2.delete(1);
  runApp(MyApp());
  // SystemChrome.setEnabledSystemUIOverlays(
  //   SystemUiOverlayStyle.light(
  //   statusBarColor: Colors.white,
  //   statusBarBrightness: Brightness.dark,
  //   statusBarIconBrightness: Brightness.dark,
  // ));
}
