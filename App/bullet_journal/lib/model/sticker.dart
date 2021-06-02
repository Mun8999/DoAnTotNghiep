// @dart=2.9
import 'dart:ui';

import 'package:bullet_journal/model/component.dart';

class Sticker extends Component {
  String _stickerId;
  String _stickerName;
  String _stickerImage;
  Sticker(String stickerId, String stickerName, String stickerImage,
      Offset offset, Size size)
      : super(offset, size) {
    this._stickerId = stickerId;
    this._stickerName = stickerName;
    this._stickerImage = stickerImage;
  }
  String get getStickerId => this._stickerId;
  String get getStickerName => this._stickerName;
  String get getStickerImage => this._stickerImage;
}

class StickerTitle {
  String _stickerTitleId;
  String _stickerTitleName;
  List<Sticker> _stickers;
  StickerTitle(String stickerTitleId) {}
}
