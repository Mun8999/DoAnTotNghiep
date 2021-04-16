import 'dart:async';

import 'package:bullet_journel/login/validation.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel {
  final _userController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();
  final _btnLogin = BehaviorSubject<bool>();
  var usernameValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (username, sink) {
      sink.add(Validation.validateUsername(username));
    },
  );
  var passwordValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      sink.add(Validation.validatePassword(password));
    },
  );
  Stream get userStream =>
      _userController.stream.transform(usernameValidation).skip(1);
  Stream get passStream =>
      _passController.stream.transform(passwordValidation).skip(1);
  Stream get loginStream => _btnLogin.stream;
  Sink get userSink => _userController.sink;
  Sink get passSink => _passController.sink;
  Sink get loginSink => _btnLogin.sink;

  LoginViewModel() {
    Rx.combineLatest2(_userController, _passController, (username, password) {
      return Validation.validateUsername(username) == null &&
          Validation.validatePassword(password) == null;
    }).listen((enable) {
      _btnLogin.add(enable);
    });
  }
  dispose() {
    _userController.close();
    _passController.close();
    _btnLogin.close();
  }
}
