// @dart=2.9
class Diary {
  String _diaryId;
  String _diaryTitle;
  String _diaryContent;
  DateTime _diaryDateTime;
  String _diaryImagePath;
  Diary _diary;
  Diary(String diaryId, String diaryTitle, String diaryContent,
      DateTime diaryDateTime, String diaryImagePath) {
    this._diaryId = diaryId;
    this._diaryTitle = diaryTitle;
    this._diaryContent = diaryContent;
    this._diaryDateTime = diaryDateTime;
    if (diaryImagePath == null)
      this._diaryImagePath = '';
    else
      this._diaryImagePath = diaryImagePath;
    // _diary = Diary(this._diaryId, this._diaryTitle, this._diaryContent,
    //     this._diaryDateTime, this._diaryImagePath);
  }
  Diary get getDiary {
    _diary = Diary(this._diaryId, this._diaryTitle, this._diaryContent,
        this._diaryDateTime, this._diaryImagePath);
    return _diary;
  }

  String get getDiaryId => _diaryId;
  String get getDiaryTitle => _diaryTitle;
  String get getDiaryContent => _diaryContent;
  DateTime get getDiaryDate => _diaryDateTime;
  String get getDiaryImagePath => _diaryImagePath;
}
