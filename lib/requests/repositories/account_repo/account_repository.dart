import 'dart:io';

import '../../../model/auth_model/auth_user.dart';

abstract class AccountRepository {
  Future<AuthUser> registerUser({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  });

  Future<AuthUser> loginUser({
    required String email,
    required String password,
  });

  Future<AuthUser> registerUserKyc({
    required String name,
    required String dob,
    required String location,
    required String gender,
    required String docType,
    required File documentType,
    required String bio,
    required String bKey,

  });
  //  Future<AuthData> verifyCode({required String code,required String token,});
  //  Future<AuthData> forgetPassword({required String email,});
  //  Future<AuthData> resetPassword({required String token, required String password,});
}
