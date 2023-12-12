import 'package:equatable/equatable.dart';

import '../../model/auth_model/auth_user.dart';

abstract class AccountStates extends Equatable {
  const AccountStates();
}

class InitialState extends AccountStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class AccountProcessing extends AccountStates {
  @override
  List<Object> get props => [];
}

class ResetPasswordLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class ResetPasswordLoaded extends AccountStates {
  final AuthUser userData;
  const ResetPasswordLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class VerifyCodeLoaded extends AccountStates {
  final AuthUser userData;
  const VerifyCodeLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class SendCodeLoaded extends AccountStates {
  final AuthUser userData;
  const SendCodeLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class AccountLoaded extends AccountStates {
  final AuthUser userData;
  const AccountLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class AccountUpdated extends AccountStates {
  final AuthUser user;
  const AccountUpdated(this.user);
  @override
  List<Object> get props => [user];
}

class AccountPinChanged extends AccountStates {
  final String message;
  const AccountPinChanged(this.message);
  @override
  List<Object> get props => [message];
}

class OTPResent extends AccountStates {
  final String message;
  const OTPResent(this.message);
  @override
  List<Object> get props => [message];
}

class AccountLoggedOut extends AccountStates {
  final String message;
  const AccountLoggedOut(this.message);
  @override
  List<Object> get props => [message];
}

class AccountKycLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class AccountKycLoaded extends AccountStates {
  final AuthUser userData;
  const AccountKycLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}
class AccountNetworkErr extends AccountStates {
  final String? message;
  const AccountNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class AccountApiErr extends AccountStates {
  final String? message;
  const AccountApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
