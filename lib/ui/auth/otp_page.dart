 
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/accounts/account.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../widgets/button_view.dart';
import '../widgets/modals.dart';
import '../widgets/pin_code_view.dart';
import 'auth.dart';
import 'reset_password.dart';

class OtpScreen extends StatefulWidget {
  final String resetType;
  final String email;
  
  const OtpScreen(
      {super.key, required this.email, required this.resetType});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isCountdownComplete = false;
  int countdown = 60;

  bool isResetPassword = false;

  final _pinController = TextEditingController();

  @override
  void initState() {
    startCountdown();
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
          if (state is VerifyCodeLoaded) {
            if (state.userData.status == 1) {
              if (widget.resetType == 'reset_password') {
                Modals.showToast('Token verified Successfully.',
                    messageType: MessageType.success);
                AppNavigator.pushAndReplacePage(context,
                    page: ResetPasswordScreen(
                      email: widget.email,
                    ));

                    _pinController.clear();
              }else if (isResetPassword){
                //  Modals.showToast(state.userData.message!,
                //     messageType: MessageType.success);
                //      getToken.setToken(state.userData.token!);
                     startCountdown();
                    _pinController.clear();


              } else if(widget.resetType == 'activate_account'){
                AppNavigator.pushAndReplacePage(context,
                    page: const LoginScreen());
                Modals.showToast(state.userData.message!,
                    messageType: MessageType.success);

                    _pinController.clear();

              }
            } else {
              Modals.showToast(state.userData.message!,
                  messageType: MessageType.error);
                    _pinController.clear();

            }
          } else if (state is AccountApiErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
                    _pinController.clear();

            }
          } else if (state is AccountNetworkErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
                    _pinController.clear();

            }
          }
        },
        builder: (context, state) => SingleChildScrollView(
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
                    'Check Your Email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.lightPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'We’ve sent a code to\n ${replaceSubstring(
                      widget.email,
                    )}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.lightPrimary,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 61,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width * 0.14),
                      child: PinCodeView(
                          length: 4,
                          obscureText: false,
                          controller: _pinController,
                          onChanged: (_) {},
                          onCompleted: (_) {
                            
                           
                          },
                          validator: Validator.validate),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {},
                      child: Text.rich(
                          TextSpan(
                              text: (!isCountdownComplete) ? 'Send Code again' : '',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.lightPrimary,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppStrings.urbanist,
                                  height: 2),
                              children: [
                                if (!isCountdownComplete)
                                  TextSpan(
                                      text: ' in $countdown seconds',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.red,
                                  fontFamily: AppStrings.urbanist,

                                        fontWeight: FontWeight.w500,
                                      )),
                                  const TextSpan(
                                          text: '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                  fontFamily: AppStrings.urbanist,

                                            fontWeight: FontWeight.w500,
                                          )),

                                     if (isCountdownComplete) 
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                             
                                               forgotPassword(context);
                                            },
                                          text: (state is AccountProcessing) ? '':'Resend',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              
                                              color: AppColors.lightSecondary,
                                              decoration: TextDecoration.underline,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: AppStrings.interSans,
                                              height: 2),
                                        )
                              ]),
                          textAlign: TextAlign.start),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: ButtonView(
                      color: AppColors.lightPrimary,
                      borderColor: AppColors.lightPrimary,
                      processing: state is AccountLoading || state is AccountProcessing,
                      borderRadius: 30,
                      onPressed: () {
                    
                        if (widget.resetType == 'reset_password'){
                               _verifyCode(context, 'reset_password');
                            }else{
                               _verifyCode(context, 'activate_account');

                            }
                      },
                      child: const Text(
                        'Verify Code',
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
    ));
  }

  Future<void> startCountdown() async {
    
    for (int i = 60; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        countdown = i;
      });
    }
    setState(() {
      isCountdownComplete = true;
    });
  }

  _verifyCode(BuildContext ctx, String type) async{

    if (_formKey.currentState!.validate()) {
     await ctx
          .read<AccountCubit>()
          .verifyCode(token: _pinController.text, type: type, email: widget.email);

            
      FocusScope.of(ctx).unfocus();
    }
  }

  String replaceSubstring(String input) {
    input = input.replaceRange(3, 6, '****');

    return input;
  }

  forgotPassword(BuildContext ctx) async{
   
    await  ctx.read<AccountCubit>().forgotPassword(
            email: widget.email, type: widget.resetType, 
          );
          

          setState(() {
            isResetPassword = true;
          });
      FocusScope.of(ctx).unfocus();
    
  }
}
