// @dart=2.9
class Frame {
  int _frameId;
  int _typeOfFrame;
  double _tile;
  String _framePath;
  Frame(int frameId, int typeOfFrame,
      {double tile = 1.5, String framePath = ''}) {
    this._frameId = frameId;
    this._typeOfFrame = typeOfFrame;
    this._framePath = framePath;
  }
  _setFramePath(String framePath, double tile) {
    this._framePath = framePath;
    this._tile = tile;
  }

  int get getFrameId => this._frameId;
  int get getTypeOfFrame => this._typeOfFrame;
  double get getTiLe => this._tile;
  String get getFramePath => this._framePath;
}

class Frames {
  List<Frame> _frames = [];
  Frames() {
    _frames.add(Frame(0, 0));
    Frame frame;
    for (int i = 1; i < 7; i++) {
      frame = new Frame(i, 1);
      _frames.add(frame);
    }
    _frames[1]._setFramePath(
        'assets/icons/frame/circle/circlecuteframeclipart.png', 1.4);
    _frames[2]._setFramePath(
        'assets/icons/frame/circle/circleloveheartframedecoration.png', 1.6);
    _frames[3]._setFramePath(
        'assets/icons/frame/circle/framebulletjournalclipart.png', 1.35);
    _frames[4]._setFramePath(
        'assets/icons/frame/circle/leavesfloralclipart.png', 1.6);
    _frames[5]._setFramePath(
        'assets/icons/frame/circle/lovelypinkheartframeclipart.png', 1.6);
    _frames[6]._setFramePath(
        'assets/icons/frame/circle/vectorpinkloveborder.png', 1.32);
  }
  List<Frame> get getFrames => this._frames;
}
