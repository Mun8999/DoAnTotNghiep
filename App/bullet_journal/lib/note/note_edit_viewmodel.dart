// @dart=2.9
import 'package:bullet_journal/database/db_asset.dart';
import 'package:bullet_journal/database/db_note.dart';
import 'package:hive/hive.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class NoteEditViewModel {
  NoteEditViewModel();
  Future initNoteData(NoteDB noteDB, int state, List<String> records,
      List<Asset> assets) async {
    print('11> init note id: ' +
        noteDB.noteId.toString() +
        ', box id: ' +
        noteDB.boxId.toString());
    print('15> state: ' + state.toString());
    records.clear();
    assets.clear();
    if (state == 1) return;
    await _initContent(noteDB, state, records, assets);
  }

  _initContent(NoteDB noteDB, int state, List<String> records,
      List<Asset> assets) async {
    var recordBox =
        await Hive.openBox<String>('records' + noteDB.boxId.toString());
    var assetBox =
        await Hive.openBox<AssetDB>('assets' + noteDB.boxId.toString());
    String record;
    // if (records.length > 0) return;
    // if (assets.length > 0) return;
    if (recordBox.length > 0) {
      recordBox.values.forEach((recordDB) async {
        record = recordDB;
        records.add(record);
      });
    }
    Asset asset;
    if (assetBox.length > 0) {
      assetBox.values.forEach((assetDB) async {
        asset = Asset(assetDB.identifier, assetDB.name, assetDB.originalWidth,
            assetDB.originalHeight);
        assets.add(asset);
      });
    }
    await recordBox.close();
    await assetBox.close();
  }

  saveNote(Box<NoteDB> noteBox, int state, NoteDB noteDB, List<String> records,
      List<Asset> assets) async {
    int index = noteBox.length;
    noteDB.noteTime = DateTime.now();
    print('38> index: ' + index.toString());
    if (state == 1) {
      noteDB.noteId = index;
      if (noteBox.length == 0)
        noteDB.boxId = 0;
      else
        noteDB.boxId = noteBox.getAt(index - 1).boxId + 1;
      print('addddd');
      await noteBox.add(noteDB);
    } else
      await noteBox.putAt(noteDB.noteId, noteDB);
    print('40> save note id: ' +
        noteDB.noteId.toString() +
        ', box id: ' +
        noteDB.boxId.toString());
    var recordBox =
        await Hive.openBox<String>('records' + noteDB.boxId.toString());
    var assetBox =
        await Hive.openBox<AssetDB>('assets' + noteDB.boxId.toString());
    recordBox.clear();
    assetBox.clear();
    if (records.length > 0) {
      records.forEach((record) async {
        recordBox.add(record);
      });
    }
    // await recordBox.close();
    AssetDB assetDB;
    if (assets.length > 0) {
      assets.forEach((asset) async {
        assetDB = AssetDB(asset.identifier, asset.name, asset.originalWidth,
            asset.originalHeight);
        assetBox.add(assetDB);
      });
    }
    await recordBox.close();
    await assetBox.close();
    // await assetBox.close();
  }

  deleteNote(Box<NoteDB> noteBox, NoteDB noteDB) async {
    await noteBox.deleteAt(noteDB.boxId);
    int boxIndex = noteDB.boxId;
    var recordBox = await Hive.openBox<String>('records' + boxIndex.toString());
    var assetBox = await Hive.openBox<AssetDB>('assets' + boxIndex.toString());
    if (recordBox.length > 0) recordBox.deleteFromDisk();
    if (assetBox.length > 0) assetBox.deleteFromDisk();
  }
}
