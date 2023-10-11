import 'dart:io';

import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../ui/widgets/button_view.dart';
import '../ui/widgets/custom_text.dart';
import 'service_kyc_four.dart';

class KycServiceScreenThree extends StatefulWidget {
  KycServiceScreenThree({
    super.key,
  });

  @override
  State<KycServiceScreenThree> createState() => _KycServiceScreenThreeState();
}

class _KycServiceScreenThreeState extends State<KycServiceScreenThree> {
  // PetGenderType _petGenderType = PetGenderType.none;

  @override
  Widget build(BuildContext context) {
    // final serviceProvider =
    //     Provider.of<ServiceProviderViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
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
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(),
                child: Column(children: [
                  SafeArea(
                      child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
                  Row(
                    children: [
                      backButton(context),
                      const SizedBox(
                        width: 40,
                      ),
                      const CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        text: 'KYC  Registration',
                        weight: FontWeight.w800,
                        size: 16,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.2,
                  ),
                  const SizedBox(height: 55),
                  const CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: 'Your gender',
                    weight: FontWeight.w700,
                    size: 32,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 22.0),
                      child: CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        text: 'Select gender',
                        weight: FontWeight.w500,
                        size: 16,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  inputField('Enter gender', Ionicons.person_outline),
                  const Spacer(),
                  // if (_petGenderType != PetGenderType.none)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20),
                    child: ButtonView(
                      onPressed: () {
                        // serviceProvider
                        //     .setServiceProviderGender(_petGenderType.name);
                        AppNavigator.pushAndStackPage(context,
                            page: KycServiceScreenFour());
                      },
                      color: AppColors.lightPrimary,
                      borderRadius: 32,
                      borderColor: Colors.white,
                      child: const CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        text: 'Next',
                        weight: FontWeight.w400,
                        size: 16,
                        fontFamily: AppStrings.interSans,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget inputField(String hint, IconData iconData) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
    child: SizedBox(
      height: 50,
      child: Material(
        elevation: 8,
        shadowColor: Colors.black87,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            prefixIcon: Icon(iconData),
          ),
        ),
      ),
    ),
  );
}
