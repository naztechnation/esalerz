import 'dart:io';

import '../../../model/auth_model/auth_user.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  Future<AuthUser> registerUser(
      {required String email,
      required String password,
      required String fullName,
      required String phone}) async {
    final map = await Requests().post(AppStrings.registerUrl, body: {
      "email": email,
      "password": password,
      "name": fullName,
      // "phone": phone,
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
      required File documentType,
      required String bio,
      required String bKey}) async {
    final map = await Requests().post(AppStrings.loginUrl, files: {
      'document': documentType,
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

  // @override
  // Future<AuthData> verifyCode(
  //     {required String code, required String token,}) async {
  //   final map =
  //       await Requests().post(AppStrings.verifyCodeUrl, body: {
  //     "code": code,
  //     "token": token,
  //   });

  //   return AuthData.fromJson(map);
  // }

  // @override
  // Future<AuthData> forgetPassword({required String email}) async {
  //   final map = await Requests().post(AppStrings.forgotPasswordUrl, body: {
  //     "email": email,

  //   });
  //   return AuthData.fromJson(map);
  // }

  //  @override
  // Future<AuthData> resetPassword(
  //     {required String token, required String password,}) async {
  //   final map =
  //       await Requests().post(AppStrings.resetPasswordUrl, body: {
  //     "token": token,
  //     "password": password,
  //   });

  //   return AuthData.fromJson(map);
  // }
}
