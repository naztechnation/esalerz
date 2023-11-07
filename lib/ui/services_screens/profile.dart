import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/auth/auth.dart';
import 'package:esalerz/ui/widgets/button_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../handlers/secure_handler.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/notification_widget.dart';
import '../widgets/text_edit_view.dart';

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
         
        actions: [
         GestureDetector(
          onTap: () {
            StorageHandler.clearCache();
            AppNavigator.pushAndReplacePage(context, page: LoginScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: AppColors.lightSecondary,
                    size: 30,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightSecondary,
                    ),
                  )
                ],
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
                              horizontal: 0.0, vertical: 8),
                          child: Material(
                            elevation: 0,
                            shadowColor: Colors.black87,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            child: TextEditView(
                              controller: firstNameController,
                              labelText: 'First Name',
                              prefixIcon: const Icon(
                                Ionicons.person,
                                color: AppColors.lightPrimary,
                              ),
                              filled: false,
                              hintText: 'Enter first name',
                              borderColor: Colors.white,
                              textColor: Colors.black,
                              borderRadius: 4,
                              borderWidth: 1,
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 8),
                          child: Material(
                            elevation: 0,
                            shadowColor: Colors.black87,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            child: TextEditView(
                              controller: lastNameController,
                              labelText: 'Last Name',
                              prefixIcon: const Icon(
                                Ionicons.person,
                                color: AppColors.lightPrimary,
                              ),
                              filled: false,
                              hintText: 'Enter last name',
                              borderColor: Colors.white,
                              textColor: Colors.black,
                              
                              borderRadius: 4,
                              borderWidth: 1,
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 8),
                          child: Material(
                            elevation: 0,
                            shadowColor: Colors.black87,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
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
                              borderRadius: 4,
                              borderWidth: 1,
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 8),
                          child: Material(
                            elevation: 0,
                            shadowColor: Colors.black87,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            child: TextEditView(
                              controller: phoneController,
                              labelText: 'Phone Number',
                              prefixIcon: const Icon(
                                Ionicons.phone_portrait,
                                color: AppColors.lightPrimary,
                              ),
                              filled: false,
                              hintText: 'Enter Phone number',
                              borderColor: Colors.white,
                              textColor: Colors.black,
                              borderRadius: 4,
                              borderWidth: 1,
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 8),
                          child: Material(
                            elevation: 0,
                            shadowColor: Colors.black87,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            child: TextEditView(
                              controller: addressController,
                              labelText: 'Address',
                              prefixIcon: const Icon(
                                Ionicons.location,
                                color: AppColors.lightPrimary,
                              ),
                              filled: false,
                              hintText: 'Enter Address',
                              borderColor: Colors.white,
                              textColor: Colors.black,
                              borderRadius: 4,
                              borderWidth: 1,
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        ButtonView(
                            color: AppColors.lightPrimary,
                            expanded: true,
                            borderRadius: 4,
                            onPressed: () {},
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                              ),
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
