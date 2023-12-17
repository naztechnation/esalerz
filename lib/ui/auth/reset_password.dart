 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../blocs/accounts/account.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/enum.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../widgets/button_view.dart';
import '../widgets/modals.dart';
import '../widgets/text_edit_view.dart';
import 'auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen(
      {super.key, required this.email, });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isShowPassword = true;

  showPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  @override
  void initState() {
    _emailController.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<AccountCubit>(
      lazy: false,
      create: (_) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is ResetPasswordLoaded) {
            if (state.userData.status == 1) {
              Modals.showToast(state.userData.message!,
                  messageType: MessageType.success);
              navigateToNextPage(context);
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: SystemUiOverlay.values);
            } else {
              Modals.showToast(state.userData.message!,
                  messageType: MessageType.error);
            }
          } else if (state is AccountApiErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
            }
          } else if (state is AccountNetworkErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
            }
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                 
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Icon(Icons.arrow_back_ios, color: AppColors.lightPrimary,),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.18,
                    ),
                    const Text(
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.lightPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 31),
                    const Text(
                      'Enter your new password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.lightPrimary,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 61,
                    ),
                     Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: Material(
                                  elevation: 1,
                                  shadowColor: Colors.black87,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: TextEditView(
                                    controller: _emailController,
                                    validator: Validator.validateEmail,
                                    labelText: 'Email',
                                    prefixIcon: const Icon(
                                      Ionicons.mail_outline,
                                      color: AppColors.lightPrimary,
                                    ),
                                    filled: false,
                                    borderColor: Colors.white,
                                    textColor: Colors.black,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: Material(
                                  elevation: 1,
                                  shadowColor: Colors.black87,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: TextEditView(
                                    controller: _passwordController,
                                    obscureText: isShowPassword,
                                    labelText: 'Password',
                                    prefixIcon: const Icon(
                                      Ionicons.lock_closed_outline,
                                      color: AppColors.lightPrimary,
                                    ),
                                    suffixIcon: isShowPassword
                                        ? GestureDetector(
                                            onTap: () {
                                              showPassword();
                                            },
                                            child: Icon(
                                              Ionicons.eye,
                                              color: AppColors.lightPrimary,
                                              size: 25,
                                            ))
                                        : GestureDetector(
                                            onTap: () {
                                              showPassword();
                                            },
                                            child: Icon(
                                              Ionicons.eye_off,
                                              color: AppColors.lightPrimary,
                                              size: 25,
                                            )),
                                    filled: false,
                                    borderColor: Colors.white,
                                    textColor: Colors.black,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    isDense: true,
                                  ),
                                ),
                              ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: ButtonView(
                        color: AppColors.lightPrimary,
                        processing: state is ResetPasswordLoading,
                        borderColor: AppColors.lightPrimary,
                        borderRadius: 30,
                        onPressed: () {
                          // navigateToNextPage(context, );
                           resetPassword(context);
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: AppColors.lightBackground),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                )),
          ),
        ),
      ),
    ));
  }

  resetPassword(
    BuildContext ctx,
  ) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().resetPassword(
            password: _passwordController.text.trim(), email: widget.email);
      FocusScope.of(ctx).unfocus();
    }
  }

  successWidget() {
    return   SizedBox(
      // height: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30,
          ),
         // ImageView.asset(AppImages.regSuccess),
          SizedBox(
            height: 43,
          ),
          Text(
            'Congratulations',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.lightSecondary,
              fontWeight: FontWeight.w400,
              fontSize: 32,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Your account is ready to use. You  would be redirected to Login to your account',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 30,
          ),
         // ImageView.asset(AppImages.loading),
        ],
      ),
    );
  }

  navigateToNextPage(BuildContext context) async {
    Future.delayed(
        const Duration(
          seconds: 4,
        ), () {
      AppNavigator.pushAndReplacePage(context, page: const LoginScreen());
    });
  }
}
