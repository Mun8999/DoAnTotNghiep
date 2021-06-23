// @dart=2.9
import 'package:bullet_journal/database/db_journey.dart';
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

  saveJouney(Box<JourneyDB> journeyBox, int state, JourneyDB journeyDB,
      List<String> images) async {
    int index = journeyBox.length;
    journeyDB.journeyTime = DateTime.now();
    journeyDB.jouneyImage = images[0];
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
    print('40> save note id: ' +
        journeyDB.journeyId.toString() +
        ', box id: ' +
        journeyDB.boxId.toString());
    var imageBox = await Hive.openBox<String>(
        'journeyimages' + journeyDB.boxId.toString());
    imageBox.clear();
    if (images.length > 0) {
      images.forEach((image) async {
        imageBox.add(image);
      });
    }
    await imageBox.close();
  }
}
