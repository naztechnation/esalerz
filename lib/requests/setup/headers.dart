
import 'package:esalerz/ui/widgets/modals.dart';

import '../../handlers/secure_handler.dart';

String token = '';

Future<Map<String, String>> rawDataHeader([String? token]) async {
  final accessToken = token;
  return {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFnYm8ucmFwaDEyMzRAZ21haWwuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCIsImV4cCI6MTcwMzE1NDQzM30.HRn1YNwo2ON51uzGXNiSnn-qKOhuZ_wyKP2WkH0gKJcs',
  };
}

Future<Map<String, String>> formDataHeader([String? token]) async {

    token = await StorageHandler.getUserToken() ?? '';

    

  Map<String, String> headers = {
    'Authorization': '$token',
  };

  return headers;
}
