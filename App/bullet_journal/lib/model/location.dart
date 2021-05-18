// @dart=2.9
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class MyAddress extends MyLocation {
  String _number, _street, _ward, _district, _city, _nation;
  MyLocation _myLocation = MyLocation();
  List<String> _numberStreet = [];
  initAddress() async {
    await _myLocation.innitLocation();
    print('innitAddress');
    // String a = _myLocation.getCurrentAddress;
    if (_myLocation.getCurrentAddress != null) {
      print('abc' + _myLocation.getCurrentAddress);
      String _numberStreetString = _myLocation.getCurrentAddress.split(', ')[0];
      _numberStreet = _numberStreetString.split(' ');
      this._number = _myLocation.getCurrentAddress.split(' ')[0];
      this._street = '';
      for (int i = 1; i < _numberStreet.length; i++) {
        this._street += _numberStreet[i] + ' ';
      }
      this._ward = _myLocation.getCurrentAddress.split(', ')[1];
      this._district = _myLocation.getCurrentAddress.split(', ')[2];
      this._city = _myLocation.getCurrentAddress.split(', ')[3];
      this._nation = _myLocation.getCurrentAddress.split(', ')[4];
      print('\n' + this._number);
      print('\n' + this._street);
      print('\n' + this._ward);
      print('\n' + this._district);
      print('\n' + this._city);
      print('\n' + this._nation);
    }
  }

  String getFullAddress() {
    return getNumber +
        ' ' +
        getStreet +
        ', ' +
        getWard +
        ', ' +
        getDistrict +
        '\n' +
        getCity +
        ', ' +
        getNation;
  }

  MyAddress() {}
  String get getNumber => this._number;
  String get getStreet => this._street;
  String get getWard => this._ward;
  String get getDistrict => this._district;
  String get getCity => this._city;
  String get getNation => this._nation;
}

class MyLocation {
  bool _serviceEnabled;
  LocationPermission _permission;
  bool _result = false;
  String _error;
  String _currentAddress;
  bool get getServiceEnable => this._serviceEnabled;
  String get getEror => this._error;
  String get getCurrentAddress => this._currentAddress;
  bool get getCheckResult => this._result;
  MyLocation() {}
  innitLocation() async {
    await _determinePosition();

    await _getLocation();
    // print('MyLocation');
    // print(_currentAddress);
  }

  _determinePosition() async {
    // Test if location services are enabled.
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      _error = 'Location services are disabled.';
      _result = false;
      return;
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        _error = 'Location permissions are denied.';
        _result = false;
        return;
      }
    }

    if (_permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
      _error =
          'Location permissions are permanently denied, we cannot request permissions.';
      _result = false;
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // return await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    _result = false;
    return;
  }

  _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    // print("${first.addressLine}");
    _currentAddress = first.addressLine;
    print('_getLocation: ' + _currentAddress);
  }
}
