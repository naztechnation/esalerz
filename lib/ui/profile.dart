import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:esalerz/ui/widgets/button_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../handlers/secure_handler.dart';
import '../utils/navigator/page_navigator.dart';
import 'auth/auth.dart';
import 'widgets/text_edit_view.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        elevation: 0,
        title: const Text(
          'Hello, John',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        
        actions: [
          SafeArea(
            child: GestureDetector(
              onTap: (){
                StorageHandler.clearCache();
                AppNavigator.pushAndReplacePage(context, page:LoginScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 30,
                    width: 40,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(80),
                        color: AppColors.lightPrimary),
                    child: Center(
                        child: Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                      size: 30,
                    )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
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
            color: Colors.white70,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //profile image
                  Align(
                    child: ProfileImagePicker(),
                  ),
                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.lightSecondary.withOpacity(0.05),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                    child: Column(
                      children: [
                        Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: Material(
                                  elevation: 4,
                                  shadowColor: Colors.black87,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: TextEditView(
                                    controller: firstNameController,
                                    labelText: 'First Name',
                                    prefixIcon: const Icon(
                                      Ionicons.mail_outline,
                                      color: AppColors.lightPrimary,
                                    ),
                                    filled: false,
                          hintText: 'Enter first name',

                                    borderColor: Colors.white,
                                    textColor: Colors.black,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    isDense: true,
                                  ),
                                ),
                              ),
                        
                        const SizedBox(height: 20),
                         Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: Material(
                                  elevation: 4,
                                  shadowColor: Colors.black87,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: TextEditView(
                                    controller: lastNameController,
                                    labelText: 'Last Name',
                                    prefixIcon: const Icon(
                                      Ionicons.mail_outline,
                                      color: AppColors.lightPrimary,
                                    ),
                                    filled: false,
                          hintText: 'Enter last name',

                                    borderColor: Colors.white,
                                    textColor: Colors.black,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    isDense: true,
                                  ),
                                ),
                              ),
                         
                        const SizedBox(height: 20),
                       Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: Material(
                                  elevation: 4,
                                  shadowColor: Colors.black87,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: TextEditView(
                                    controller: emailController,
                                    labelText: 'Email',
                                    prefixIcon: const Icon(
                                      Ionicons.mail_outline,
                                      color: AppColors.lightPrimary,
                                    ),
                                    filled: false,
                          hintText: 'Enter Email address',

                                    borderColor: Colors.white,
                                    textColor: Colors.black,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    isDense: true,
                                  ),
                                ),
                              ),
                        const SizedBox(height: 20),
                         Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: Material(
                                  elevation: 4,
                                  shadowColor: Colors.black87,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: TextEditView(
                                    controller: phoneController,
                                    labelText: 'Phone Number',
                                    prefixIcon: const Icon(
                                      Ionicons.mail_outline,
                                      color: AppColors.lightPrimary,
                                    ),
                                    filled: false,
                          hintText: 'Enter Phone number',

                                    borderColor: Colors.white,
                                    textColor: Colors.black,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    isDense: true,
                                  ),
                                ),
                              ),
                        const SizedBox(height: 20),
                         Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12),
                                child: Material(
                                  elevation: 4,
                                  shadowColor: Colors.black87,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: TextEditView(
                                    controller: phoneController,
                                    labelText: 'Address',
                                    prefixIcon: const Icon(
                                      Ionicons.mail_outline,
                                      color: AppColors.lightPrimary,
                                    ),
                                    filled: false,
                          hintText: 'Enter Address',

                                    borderColor: Colors.white,
                                    textColor: Colors.black,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    isDense: true,
                                  ),
                                ),
                              ),
                        const SizedBox(height: 40),
                        ButtonView(
                            color: AppColors.lightPrimary,
                            onPressed: () {},
                            child: BigText(
                              text: 'Save',
                              color: Colors.white,
                            )),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
