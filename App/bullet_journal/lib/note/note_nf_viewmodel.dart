// @dart=2.9
import 'dart:math';
import 'package:bullet_journal/database/db_asset.dart';
import 'package:bullet_journal/database/db_note.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/subjects.dart';

class NoteViewNewsFeedViewModel {
  List<double> _random = [];
  final _randomController = BehaviorSubject<List<double>>();
  NoteViewNewsFeedViewModel() {
    //_init();
  }
  _init() async {
    Random rd = Random();
    for (int i = 0; i < 7; i++) {
      i = rd.nextInt(4) + 2;
      _random.add(i.toDouble());
    }
    await _randomController.sink.add(_random);
  }

  deleteNote(Box<NoteDB> noteBox, NoteDB noteDB) async {
    await noteBox.deleteAt(noteDB.boxId);
    int boxIndex = noteDB.boxId;
    var recordBox = await Hive.openBox<String>('records' + boxIndex.toString());
    var assetBox = await Hive.openBox<AssetDB>('assets' + boxIndex.toString());
    if (recordBox.length > 0) recordBox.deleteFromDisk();
    if (assetBox.length > 0) assetBox.deleteFromDisk();
  }

  Stream get getRadomController => this._randomController.stream;
}
