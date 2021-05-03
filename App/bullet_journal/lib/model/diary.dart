class Diary {
  String? diaryId;
  String? diaryTitle;
  String? diaryContent;
  DateTime? diaryDate;
  String? diaryImageLink;
  Diary(String diaryId, String diaryTitle, String diaryContent,
      DateTime diaryDate, String? diaryImageLink) {
    this.diaryId = diaryId;
    this.diaryTitle = diaryTitle;
    this.diaryContent = diaryContent;
    this.diaryDate = diaryDate;
    this.diaryImageLink = diaryImageLink;
  }
}
