// @dart=2.9
import 'package:bullet_journal/database/db_asset.dart';
import 'package:bullet_journal/database/db_journalitem.dart';
import 'package:bullet_journal/database/db_journey.dart';
import 'package:bullet_journal/model/journal_item.dart';
import 'package:hive/hive.dart';

class JourneyEditViewModel {
  JourneyEditViewModel();
  Future initNoteData(
      JourneyDB journeyDB, int state, List<String> images) async {
    print('11> init note id: ' +
        journeyDB.journeyId.toString() +
        ', box id: ' +
        journeyDB.boxId.toString());
    print('15> state: ' + state.toString());
    images.clear();
    if (state == 1) return;
    await _initContent(journeyDB, state, images);
  }

  _initContent(JourneyDB journeyDB, int state, List<String> images) async {
    var imageBox = await Hive.openBox<String>(
        'journeyimages' + journeyDB.boxId.toString());
    if (imageBox.length > 0) {
      imageBox.values.forEach((image) async {
        await images.add(image);
      });
    }
    await imageBox.close();
  }

  saveJouney(Box<JourneyDB> journeyBox, String jouneyImage, int state,
      JourneyDB journeyDB, List<JournalItem> journalItems) async {
    int index = journeyBox.length;
    journeyDB.journeyTime = DateTime.now();
    journeyDB.jouneyImage = jouneyImage;
    print('38> index: ' + index.toString());
    if (state == 1) {
      journeyDB.journeyId = index;
      if (journeyBox.length == 0)
        journeyDB.boxId = 0;
      else
        journeyDB.boxId = journeyBox.getAt(index - 1).boxId + 1;
      print('addddd');
      await journeyBox.add(journeyDB);
    } else
      await journeyBox.putAt(journeyDB.journeyId, journeyDB);

    ///// lưu hành trình
    print('40> save note id: ' +
        journeyDB.journeyId.toString() +
        ', box id: ' +
        journeyDB.boxId.toString());

    var journeyBoxs = await Hive.openBox<JournalItemDB>(
        'journey' + journeyDB.boxId.toString());
    journeyBoxs.values.forEach((itemDB) async {
      var textBox = await Hive.openBox<String>(itemDB.textBoxId);
      var imageBox = await Hive.openBox<AssetDB>(itemDB.assetBoxId);
      textBox.deleteFromDisk();
      imageBox.deleteFromDisk();
    });
    journeyBoxs.clear(); //xóa dữ liệu cũ, thêm dữ liệu mới

    JournalItemDB itemDB;
    String boxId;
    journalItems.forEach((item) async {
      boxId = item.getJournalItemId + journeyDB.boxId.toString();
      itemDB = JournalItemDB(
          item.getJournalItemId, item.getDate, 'text' + boxId, 'image' + boxId);
      await journeyBoxs.add(itemDB);
      var textBox = await Hive.openBox<String>(itemDB.textBoxId);
      if (item.getTexts.length > 0) await textBox.addAll(item.getTexts);
      var imageBox = await Hive.openBox<AssetDB>(itemDB.assetBoxId);
      AssetDB assetDB;
      if (item.getAssets.length > 0) {
        item.getAssets.forEach((asset) async {
          assetDB = AssetDB(asset.identifier, asset.name, asset.originalWidth,
              asset.originalHeight);
          await imageBox.add(assetDB);
        });
      }
    });

    // imageBox.clear();
    // if (images.length > 0) {
    //   images.forEach((image) async {
    //     imageBox.add(image);
    //   });
    // }
    // await imageBox.close();
  }
}
