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
    for (int i = 7; i < 13; i++) {
      frame = new Frame(i, 2);
      _frames.add(frame);
    }
    _frames[1]._setFramePath(
        'assets/images/frame/circle/circlecuteframeclipart.png', 1.4);
    _frames[2]._setFramePath(
        'assets/images/frame/circle/circleloveheartframedecoration.png', 1.6);
    _frames[3]._setFramePath(
        'assets/images/frame/circle/framebulletjournalclipart.png', 1.35);
    _frames[4]._setFramePath(
        'assets/images/frame/circle/leavesfloralclipart.png', 1.6);
    _frames[5]._setFramePath(
        'assets/images/frame/circle/lovelypinkheartframeclipart.png', 1.6);
    _frames[6]._setFramePath(
        'assets/images/frame/circle/vectorpinkloveborder.png', 1.32);
    _frames[7]._setFramePath(
        'assets/images/frame/rectangle/friday planner and bullet journal_6235721.png',
        1.3);
    _frames[8]._setFramePath(
        'assets/images/frame/rectangle/monday planner and bullet journal_6219048.png',
        1.3);
    _frames[9]._setFramePath(
        'assets/images/frame/rectangle/sunday planner and bullet journal_6235720.png',
        1.3);
    _frames[10]._setFramePath(
        'assets/images/frame/rectangle/thursday planner and bullet journal_6235718.png',
        1.3);
    _frames[11]._setFramePath(
        'assets/images/frame/rectangle/tuesday planner and bullet journal_6235722.png',
        1.3);
    _frames[12]._setFramePath(
        'assets/images/frame/rectangle/wednesday planner and bullet journal_6219049.png',
        1.3);
  }
  List<Frame> get getFrames => this._frames;
}
