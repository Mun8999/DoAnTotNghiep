//@dart=2.9
import 'package:multi_image_picker/multi_image_picker.dart';

class JournalItem {
  String _journalItemId;
  DateTime _date;
  List<String> _texts = [];
  List<Asset> _assets = [];
  JournalItem(String journalItemId, List<String> texts, List<Asset> assets,
      {DateTime date}) {
    if (date != null) {
      this._date = date;
    }
    this._journalItemId = journalItemId;
    this._texts.addAll(texts);
    this._assets.addAll(assets);
  }
  String toString() {
    return _journalItemId.toString() +
        '\n' +
        _date.toString() +
        '\n' +
        _texts.toString();
  }

  setJournalItemId(String journalItemId) => this._journalItemId = journalItemId;
  setDate(DateTime date) => this._date = date;
  setTexts(List<String> texts) => this._texts.addAll(texts);
  setAssets(List<Asset> assets) => this._assets.addAll(assets);
  deleteData() {
    this._assets.clear();
    this._texts.clear();
  }

  String get getJournalItemId => this._journalItemId;
  DateTime get getDate => this._date;
  List<String> get getTexts => this._texts;
  List<Asset> get getAssets => this._assets;
}
