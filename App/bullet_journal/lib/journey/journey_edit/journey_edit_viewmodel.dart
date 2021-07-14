// @dart=2.9
import 'package:bullet_journal/database/db_asset.dart';
import 'package:bullet_journal/database/db_journalitem.dart';
import 'package:bullet_journal/database/db_journey.dart';
import 'package:bullet_journal/model/journal_item.dart';
import 'package:hive/hive.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class JourneyEditViewModel {
  JourneyEditViewModel();
  Future<void> initJourneyData(
      JourneyDB journeyDB, int state, List<JournalItem> journalItems) async {
    print('11> init note id: ' +
        journeyDB.journeyId.toString() +
        ', box id: ' +
        journeyDB.boxId.toString());
    print('15> state: ' + state.toString());
    journalItems.clear();
    if (state == 1) return;
    await _initContent(journeyDB, journalItems);
  }

  Future<void> _initContent(
      JourneyDB journeyDB, List<JournalItem> journalItems) async {
    // if (state == 1) return;
    var journeyBoxs = await Hive.openBox<JournalItemDB>(
        'journey' + journeyDB.boxId.toString());
    JournalItem item;
    List<Asset> assets = [];
    List<String> texts = [];
    Asset asset;
    journeyBoxs.values.forEach((itemDB) async {
      var textBox = await Hive.openBox<String>(itemDB.textBoxId);
      var imageBox = await Hive.openBox<AssetDB>(itemDB.assetBoxId);
      textBox.values.forEach((textDB) {
        // print('abcbc> ' + textDB);
        texts.add(textDB.toString());
      });
      imageBox.values.forEach((assetDB) async {
        asset = Asset(assetDB.identifier, assetDB.name, assetDB.originalWidth,
            assetDB.originalHeight);
        assets.add(asset);
      });
      print('asset length?' + imageBox.length.toString());
      item =
          JournalItem(itemDB.journalItemId, texts, assets, date: itemDB.date);
      journalItems.add(item);
    });
    // var imageBox = await Hive.openBox<String>(
    //     'journeyimages' + journeyDB.boxId.toString());
    // if (imageBox.length > 0) {
    //   imageBox.values.forEach((image) async {
    //     await images.add(image);
    //   });
    // }
    // await imageBox.close();
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
    print('???????????????');
    ///// lưu hành trình
    print('40> save note id: ' +
        journeyDB.journeyId.toString() +
        ', box id: ' +
        journeyDB.boxId.toString());
    var journeyBoxs = await Hive.openBox<JournalItemDB>(
        'journey' + journeyDB.boxId.toString());
    await _deleteJounalItem(journeyDB, journeyBoxs);
    //xóa dữ liệu cũ, thêm dữ liệu mới
    await _addJournalItemData(journalItems, journeyDB, journeyBoxs);
    //thêm dữ liệu mới
    await _printData(journeyBoxs);
    // imageBox.clear();
    // if (images.length > 0) {
    //   images.forEach((image) async {
    //     imageBox.add(image);
    //   });
    // }
    // await imageBox.close();
  }

  Future<void> _deleteJounalItem(
      JourneyDB journeyDB, Box<JournalItemDB> journeyBoxs) async {
    journeyBoxs.values.forEach((itemDB) async {
      var textBox = await Hive.openBox<String>(itemDB.textBoxId);
      var imageBox = await Hive.openBox<AssetDB>(itemDB.assetBoxId);
      await textBox.deleteFromDisk();
      await imageBox.deleteFromDisk();
    });
    await journeyBoxs.clear();
  }

  Future<void> _addJournalItemData(List<JournalItem> journalItems,
      JourneyDB journeyDB, Box<JournalItemDB> journeyBoxs) async {
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
        // await textBox.close();
        // await imageBox.close();
      }
    });
  }

  Future<void> _printData(Box<JournalItemDB> journeyBoxs) async {
    journeyBoxs.values.forEach((element) async {
      print('85>journey>' + element.journalItemId);
      print(element.date);
      print(element.textBoxId);
      var textBox = await Hive.openBox<String>(element.textBoxId);
      print(textBox.values.toString());

      print(element.assetBoxId);
      var imageBox = await Hive.openBox<AssetDB>(element.assetBoxId);
      imageBox.values.forEach((element) async {
        print(element.identifier);
      });
      // await textBox.close();
      // await imageBox.close();
    });
    // await journeyBoxs.close();
  }
}
