

import '../../../model/auth_model/auth_user.dart';
 

abstract class AccountRepository {
  Future<AuthUser> registerUser({
    required String fullName,
    
    required String email,required String password,required String phone,});

        Future<AuthUser> loginUser({required String email,required String password,});
      //  Future<AuthData> verifyCode({required String code,required String token,});
      //  Future<AuthData> forgetPassword({required String email,});
      //  Future<AuthData> resetPassword({required String token, required String password,});

}