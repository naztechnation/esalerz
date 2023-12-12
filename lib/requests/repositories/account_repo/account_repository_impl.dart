import 'dart:io';

import '../../../model/auth_model/auth_user.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  Future<AuthUser> registerUser(

      {
      required String firstName,
    required String lastName,  
      required String email,
      required String password,
      
      required String phone}) async {
    final map = await Requests().post(AppStrings.registerUrl, body: {
      "email": email,
      "password": password,
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
    });
    return AuthUser.fromJson(map);
  }

  @override
  Future<AuthUser> loginUser(
      {required String email, required String password}) async {
    final map = await Requests().post(AppStrings.loginUrl, body: {
      "email": email,
      "password": password,
    });
    return AuthUser.fromJson(map);
  }

  @override
  Future<AuthUser> registerUserKyc(
      {required String name,
      required String dob,
      required String location,
      required String gender,
      required String docType,
      required File document,
      required String bio,
      required String bKey}) async {
    final map = await Requests().post(AppStrings.createKycUrl, files: {
      'document': document,
    }, body: {
      "name": name,
      "dob": dob,
      "location": location,
      "gender": gender,
      "d_type": docType,
      "bio": bio,
      "bkey": bKey,
    });
    return AuthUser.fromJson(map);
  }
  
  @override
  Future<AuthUser> forgetPassword({required String email, required String type})  async {
    final map = await Requests().post(AppStrings.resetPassword, body: {
      "email": email,
      "type": type,

    });
    return AuthUser.fromJson(map);
  }
  
  @override
  Future<AuthUser> resetPassword({required String email, required String password}) async {
    final map =
        await Requests().post(AppStrings.resetPassword, body: {
      "email": email,
      "password": password,
    });

    return AuthUser.fromJson(map);
  }
  
  @override
  Future<AuthUser> verifyCode({required String token, required String email, required String type}) async {
    final map =
        await Requests().post(AppStrings.confirmToken, body: {
      "token": token,
      "email": email,
      "type": type,
    });

    return AuthUser.fromJson(map);
  }

 

  
 
}
