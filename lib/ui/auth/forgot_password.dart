import 'package:esalerz/ui/auth/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../blocs/accounts/account.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../res/enum.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../widgets/button_view.dart';
import '../widgets/modals.dart';
import '../widgets/text_edit_view.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final setToken = Provider.of<AccountViewModel>(context, listen: false);

    return Scaffold(
        body: BlocProvider<AccountCubit>(
      lazy: false,
      create: (_) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is SendCodeLoaded) {
            if (state.userData.status == 1) {
              Modals.showToast(state.userData.message ?? '',
                  messageType: MessageType.success);
              AppNavigator.pushAndReplacePage(context,
                                page: OtpScreen(
                                  email: _emailController.text.trim(),
                                   resetType: 'reset_password',
                                ));
              
            } else {
              Modals.showToast(state.userData.message ?? '',
                  );
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
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          AppImages.bg,
                        ),
                        fit: BoxFit.cover)),
              ),
              Container(
                color: Colors.white12,
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
              ),
              Container(
                height: MediaQuery.sizeOf(context).height,
                color: Colors.transparent,
                child: Form(
                  key: _formKey,
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
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.lightPrimary,
                                size: 25,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.18,
                      ),
                      const Text(
                        'Forgot Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.lightPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 31),
                      const Text(
                        'Enter your email address',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
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
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: ButtonView(
                          color: AppColors.lightPrimary,
                          processing: state is AccountProcessing,
                          borderColor: AppColors.lightPrimary,
                          borderRadius: 30,
                          onPressed: () {
                            
                             forgotPassword(context);
                          },
                          child: const Text(
                            'Continue',
                            style: TextStyle(color: AppColors.lightBackground),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  forgotPassword(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().forgotPassword(
            email: _emailController.text.trim(), type: 'reset_password',
          );
      FocusScope.of(ctx).unfocus();
    }
  }
}
