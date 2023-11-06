import 'dart:convert';
import 'dart:io';

import 'package:geocoding/geocoding.dart';

import '../../handlers/location_handler.dart';
import '../../handlers/secure_handler.dart';
import '../../res/enum.dart';
import 'base_viewmodel.dart';

class AccountViewModel extends BaseViewModel {
  AccountViewModel() {
    _intData();

    getToken();
  }

  String _token = "";
  String _address = '';
  String _userLocation = '';

  double _latitude = 0;

  double _longitude = 0;

  Future<void> _intData() async {
    final position = await LocationHandler.determinePosition();
    await setLongLat(
        latitude: position.latitude, longitude: position.longitude);
  }

  Future<void> setLongLat(
      {required double latitude, required double longitude}) async {
    _longitude = longitude;
    _latitude = latitude;
    final addresses = await placemarkFromCoordinates(
      _latitude,
      _longitude,
    );
    if (addresses.isNotEmpty) {
      final firstAddress = addresses.first;
      final address = "${firstAddress.locality},  ${firstAddress.country}";

      _address = address;
    } else {
      _address = '';
    }
    setViewState(ViewState.success);
  }

  setToken(String token) async {
    _token = token;

    StorageHandler.saveUserToken(_token);
    setViewState(ViewState.success);
  }

  updateAddress(String address) async {
    _address = address;

    setViewState(ViewState.success);
  }

  getToken() async {
    _token = await StorageHandler.getUserToken() ?? '';
    setViewState(ViewState.success);
  }

  double get longitude => _longitude;
  String get address => _address;
  String get location => _userLocation;
  double get latitude => _latitude;

  String get token => _token;
}
