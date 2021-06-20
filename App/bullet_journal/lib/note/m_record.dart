import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

/*
 * This is an example showing how to record to a Dart Stream.
 * It writes all the recorded data from a Stream to a File, which is completely stupid:
 * if an App wants to record something to a File, it must not use Streams.
 *
 * The real interest of recording to a Stream is for example to feed a
 * Speech-to-Text engine, or for processing the Live data in Dart in real time.
 *
 */

///
typedef _Fn = void Function();

/// Example app.
// class MyRecord extends StatefulWidget {
//   @override
//   _MyRecordState createState() => _MyRecordState();
// }

class MyRecord {
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  final _mRecorderController = BehaviorSubject<FlutterSoundRecorder>();
  Stream get mRecorderController => this._mRecorderController.stream;
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  // final _mPlayerIsInitedController = BehaviorSubject<bool>();
  // final _mRecorderIsInitedController = BehaviorSubject<bool>();
  // final _mplaybackReadyController = BehaviorSubject<bool>();
  // Stream get mPlayerIsInitedController =>
  //     this._mPlayerIsInitedController.stream;
  // Stream get mRecorderIsInitedController =>
  //     this._mRecorderIsInitedController.stream;
  // Stream get mplaybackReadyController => this._mplaybackReadyController.stream;
  String _mPath = 'abc.aac';
  MyRecord() {
    _initState();
  }
  void _initState() {
    _mPlayer!.openAudioSession().then((value) {
      _mPlayerIsInited = true;
      // _mPlayerIsInitedController.sink.add(_mPlayerIsInited);
    });

    openTheRecorder().then((value) {
      _mRecorderIsInited = true;
      // _mRecorderIsInitedController.sink.add(_mRecorderIsInited);
    });
  }

  dispose() {
    _mPlayer!.closeAudioSession();
    _mPlayer = null;

    _mRecorder!.closeAudioSession();
    _mRecorder = null;
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openAudioSession();
    _mRecorderIsInited = true;
    // _mRecorderIsInitedController.sink.add(_mRecorderIsInited);
  }

  // ----------------------  Here is the code for recording and playback -------

  void record(String fileName) {
    _mPath = fileName;
    _mRecorder!.startRecorder(
      toFile: _mPath,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
    );
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      _mplaybackReady = true;
      // _mplaybackReadyController.sink.add(_mplaybackReady);
    });
  }

  void play(String fileName) {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!.startPlayer(
      fromURI: fileName,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
    );
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer();
  }

  void deleteRecord(String filename) {
    _mRecorder!.deleteRecord(fileName: filename);
  }
// ----------------------------- UI --------------------------------------------

  // _Fn? getRecorderFn() {
  //   if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
  //     return null;
  //   }
  //   return _mRecorder!.isStopped ? record : stopRecorder;
  // }

  // _Fn? getPlaybackFn() {
  //   if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
  //     return null;
  //   }
  //   return _mPlayer!.isStopped ? play : stopPlayer;
  // }
}
