import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../blocs/accounts/account.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../res/enum.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../auth/forgot_password.dart';
import '../auth/otp_page.dart';
import '../services_screens/landingpage.dart';
import 'button_view.dart';
import 'image_view.dart';
import 'modals.dart';
import 'text_edit_view.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool isShowPassword = true;

  showPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  bool isLogin = true;

  Widget logos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/facebook.png'),
          const SizedBox(width: 24),
          Image.asset('assets/images/google.png'),
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return TextButton(
      onPressed: () {
        AppNavigator.pushAndStackPage(context,
            page: const ForgotPasswordScreen());
      },
      child: Align(
        alignment: Alignment.center,
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.lightSecondary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final setToken = Provider.of<AccountViewModel>(context, listen: false);

    return BlocProvider<AccountCubit>(
        lazy: false,
        create: (_) => AccountCubit(
            accountRepository: AccountRepositoryImpl(),
            viewModel: Provider.of<AccountViewModel>(context, listen: false)),
        child: BlocConsumer<AccountCubit, AccountStates>(
          listener: (context, state) {
            if (state is AccountLoaded) {
              if (state.userData.status == 1) {
                Modals.showToast(state.userData.message ?? '',
                    messageType: MessageType.success);

                sendCode(context);
              } else {
                Modals.showToast(state.userData.message ?? '',
                    messageType: MessageType.success);
              }
            } else if (state is SendCodeLoaded) {
              if (state.userData.status == 1) {
                Modals.showToast(state.userData.message ?? '',
                    messageType: MessageType.success);
                AppNavigator.pushAndReplacePage(context,
                    page: OtpScreen(
                      email: _emailController.text.trim(),
                      resetType: 'activate_account',
                    ));

                clearTextViews();
              } else {
                Modals.showToast(
                  state.userData.message ?? '',
                );
              }
            }
            if (state is AccountUpdated) {
              if (state.user.status == 1) {
                if (state.user.data?.bkey == '' ||
                    state.user.data?.bkey == null) {
                  Modals.showToast(
                    'Unknown user',
                  );
                } else {
                  Modals.showToast(
                    state.user.message ?? '',
                  );
                  setToken.setToken(state.user.data?.bkey ?? '');
                  StorageHandler.saveUserEmail(_emailController.text);
                  StorageHandler.saveUserDetails(state.user.data?.fullName);
                  StorageHandler.saveUserPhone(state.user.data?.phone);
                  StorageHandler.saveAddress('');
                  StorageHandler.login();
                }
                AppNavigator.pushAndReplacePage(context,
                    page: const LandingPage());
              } else {
                Modals.showToast(
                  state.user.message ?? '',
                );
                if (state.user.message == 'Verify your email to continue') {
                  sendCode(context);
                }
              }
            } else if (state is AccountApiErr) {
              if (state.message != null) {
                Modals.showToast(state.message!,
                    messageType: MessageType.error);
              }
            } else if (state is AccountNetworkErr) {
              if (state.message != null) {
                Modals.showToast(state.message!,
                    messageType: MessageType.error);
              }
            }
          },
          builder: (context, state) => SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.08,
                  ),
                  const ImageView.svg(
                    AppImages.logo,
                    width: 100,
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Column(
                      children: [
                        Visibility(
                          visible: !isLogin,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.lightPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 32,
                                ),
                              ),
                              const SizedBox(height: 25),
                              const Text(
                                'Enter your email and password\n to create an account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.lightPrimary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: Material(
                                  elevation: 2,
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
                                  elevation: 2,
                                  shadowColor: Colors.black87,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: TextEditView(
                                    controller: _firstNameController,
                                    labelText: 'First Name',
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
                                  elevation: 2,
                                  shadowColor: Colors.black87,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: TextEditView(
                                    controller: _lastNameController,
                                    labelText: 'Last Name',
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
                                  elevation: 2,
                                  shadowColor: Colors.black87,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: TextEditView(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    labelText: 'Phone Number',
                                    prefixIcon: const Icon(
                                      Ionicons.call_outline,
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
                                  elevation: 2,
                                  shadowColor: Colors.black87,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: TextEditView(
                                    controller: _passwordController,
                                    validator: Validator.validate,
                                    labelText: 'Password',
                                    obscureText: isShowPassword,
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
                                    prefixIcon: const Icon(
                                      Ionicons.lock_closed_outline,
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
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: ButtonView(
                                  color: AppColors.lightPrimary,
                                  processing: state is AccountProcessing,
                                  borderColor: Colors.white,
                                  borderRadius: 30,
                                  onPressed: () {
                                    _registerUser(context);
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isLogin,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Log In',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.lightPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 32,
                                ),
                              ),
                              const SizedBox(height: 25),
                              const Text(
                                'Please enter your email and\n password to login',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.lightPrimary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: Material(
                                  elevation: 2,
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
                                  elevation: 2,
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
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: ButtonView(
                                  color: AppColors.lightPrimary,
                                  processing: state is AccountLoading ||
                                      state is AccountProcessing,
                                  borderColor: Colors.white,
                                  borderRadius: 30,
                                  onPressed: () {
                                    _loginUser(context);
                                  },
                                  child: const Text(
                                    'Log In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              forgotPassword(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                              ),
                              children: [
                                TextSpan(
                                  text: isLogin
                                      ? 'Don\'t have an account?  '
                                      : 'Already have an account?  ',
                                  style: const TextStyle(
                                      color: AppColors.lightSecondary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                                TextSpan(
                                  text: isLogin ? 'Sign Up' : 'Log In',
                                  style: const TextStyle(
                                      color: AppColors.lightSecondary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _registerUser(BuildContext ctx) {
    if (_emailController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      ctx.read<AccountCubit>().registerUser(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          phone: _phoneController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      FocusScope.of(ctx).unfocus();
    } else {
      Modals.showToast('Please fill in all the fields required');
    }
  }

  _loginUser(BuildContext ctx) {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      ctx.read<AccountCubit>().loginUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      FocusScope.of(ctx).unfocus();
    } else {
      Modals.showToast('Please fill in all the fields required');
    }
  }

  clearTextViews() {
    setState(() {
      _emailController.clear();
      _phoneController.clear();
      _firstNameController.clear();
      _lastNameController.clear();
      _phoneController.clear();
      _passwordController.clear();
    });
  }

  sendCode(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().forgotPassword(
            email: _emailController.text.trim(),
            type: 'activate_account',
          );
      FocusScope.of(ctx).unfocus();
    }
  }
}
