// @dart=2.9
class Emotion {
  String _emotionId;
  String _emotionName;
  String _emotionImage;
  Emotion(String emotionId, String emotionName, String emotionImage) {
    this._emotionId = emotionId;
    this._emotionName = emotionName;
    this._emotionImage = emotionImage;
  }
  String toString() =>
      this._emotionId + ' - ' + this._emotionName + ' - ' + this._emotionImage;
  String get getEmotionId => _emotionId;
  String get getEmotionName => _emotionName;
  String get getEmotionImage => _emotionImage;
}

class ListEmotion {
  ListEmotion();
  // List<Emotion> _emotions = [
  //   Emotion('angry', 'Giận dữ', 'assets/icons/emotion/angry-face.svg'),
  //   Emotion('bad', 'Tệ', 'assets/icons/emotion/bad-face.svg'),
  //   Emotion('surprised', 'Bất ngờ', 'assets/icons/emotion/blind-face.svg'),
  //   Emotion('boring', 'Chán nãn', 'assets/icons/emotion/boring-face.svg'),
  //   Emotion('silence', 'Bí mật',
  //       'assets/icons/emotion/face-of-silence-with-a-cross-as-mouth.svg'),
  //   Emotion('frown', 'Không hài lòng', 'assets/icons/emotion/frown-face.svg'),
  //   Emotion('happy', 'Hạnh phúc', 'assets/icons/emotion/happy-face.svg'),
  //   Emotion('money', 'Vui vì có tiền', 'assets/icons/emotion/money-face.svg'),
  //   Emotion('sad', 'Hoang mang', 'assets/icons/emotion/sad-face.svg'),
  //   Emotion('smile', 'Giận dữ', 'assets/icons/emotion/straight-face.svg'),
  //   Emotion('smile_with_sunglasses', 'Thật ngầu',
  //       'assets/icons/emotion/smile-face-with-sunglasses.svg'),
  //   Emotion('straight', 'Tức giận', 'assets/icons/emotion/straight-face.svg'),
  //   Emotion('scare', 'Sợ hãi', 'assets/icons/emotion/surprised-face.svg'),
  //   Emotion(
  //       'talk_face', 'Tuyệt vời', 'assets/icons/emotion/talk-face-smiley.svg'),
  //   Emotion('wink', 'Có động lực',
  //       'assets/icons/emotion/wink-circular-face-symbol.svg'),
  // ];
  List<Emotion> _emotions = [
    Emotion('angry', 'Giận dữ', 'assets/icons/emotion/001-unicorn.svg'),
    Emotion('bad', 'Tệ', 'assets/icons/emotion/002-unicorn.svg'),
    Emotion('surprised', 'Bất ngờ', 'assets/icons/emotion/004-unicorn.svg'),
    Emotion('boring', 'Chán nản', 'assets/icons/emotion/005-unicorn.svg'),
    Emotion('silence', 'Bí mật', 'assets/icons/emotion/006-unicorn.svg'),
    Emotion('frown', 'Không hài lòng', 'assets/icons/emotion/007-unicorn.svg'),
    Emotion('happy', 'Hạnh phúc', 'assets/icons/emotion/050-unicorn.svg'),
    Emotion('money', 'Vui vì có tiền', 'assets/icons/emotion/008-unicorn.svg'),
    Emotion('sad', 'Hoang mang', 'assets/icons/emotion/015-unicorn.svg'),
    Emotion('smile', 'Giận dữ', 'assets/icons/emotion/017-unicorn.svg'),
    // Emotion('smile_with_sunglasses', 'Thật ngầu',
    //     'assets/icons/emotion/018-unicorn.svg'),
    // Emotion('straight', 'Tức giận', 'assets/icons/emotion/019-unicorn.svg'),
    // Emotion('scare', 'Sợ hãi', 'assets/icons/emotion/028-unicorn.svg'),
    // Emotion('talk_face', 'Tuyệt vời', 'assets/icons/emotion/033-unicorn.svg'),
    // Emotion('wink', 'Có động lực', 'assets/icons/emotion/049-unicorn.svg'),
  ];
  List<Emotion> get getEmotions => this._emotions;
}
