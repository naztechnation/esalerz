import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';

import '../../handlers/location_handler.dart';
import '../../handlers/secure_handler.dart';
import '../../res/app_colors.dart';
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
  String _userName = '';
  String _userGender = '';
  String _userDateOfBirth = '';
  String _userAddress = '';
  String _userAbout = '';
  String _userIdentityType = '';
  File? _imageURl;
  File? _imageURl2;


  double _latitude = 0;

  double _longitude = 0;

   setName(String name) async {
    _userName = name;

    setViewState(ViewState.success);
  }
   setGender(String gender) async {
    _userGender = gender;

    setViewState(ViewState.success);
  }

   setDateOfBirth(String dob) async {
    _userDateOfBirth = dob;

    setViewState(ViewState.success);
  }

   setAddress(String address) async {
    _address = address;

    setViewState(ViewState.success);
  }

   setAbout(String about) async {
    _userAbout = about;

    setViewState(ViewState.success);
  }

   setUserIdentityType(String idType) async {
    _userIdentityType = idType;

    setViewState(ViewState.success);
  }


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

  loadImage(BuildContext context, UploadType uploadType) async {
    await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Text('Select the images source',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.lightPrimary,
                        fontWeight: FontWeight.w500)),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  size: 35.0,
                  color: AppColors.lightPrimary,
                ),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);

                  final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);

                        if( uploadType == UploadType.photoId){
                        _imageURl2 = File(image!.path);
                      }else if( uploadType == UploadType.userPhoto){
                        _imageURl = File(image!.path);

                      }
                  
                  setViewState(ViewState.success);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo,
                  size: 35.0,
                  color: AppColors.lightPrimary,
                ),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                     if( uploadType == UploadType.photoId){
                        _imageURl2 = File(image!.path);
                      }else if( uploadType == UploadType.userPhoto){
                        _imageURl = File(image!.path);

                      }
                  setViewState(ViewState.success);
                },
              ),
            ],
          );
        });
  }


  File? get imageURl => _imageURl;
  File? get imageURl2 => _imageURl2;
  double get longitude => _longitude;
  String get address => _address;
  String get location => _userLocation;
  double get latitude => _latitude;
  String get userName => _userName;
  String get userGender => _userGender;
  String get userDateOfBirth => _userDateOfBirth;
  String get userAddress => _userAddress;
  String get userAbout => _userAbout;
  String get userIdentityType => _userIdentityType;
  String get token => _token;
}
