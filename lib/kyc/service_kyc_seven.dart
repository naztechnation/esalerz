import 'dart:io';

import 'package:esalerz/kyc/service_kyc_nine.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/button_view.dart';
import 'package:esalerz/ui/widgets/custom_text.dart';
import 'package:esalerz/ui/widgets/modals.dart'; 
import 'package:esalerz/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_strings.dart';
import 'service_kyc_eight.dart';

class KycServiceScreenSeven extends StatelessWidget {
  KycServiceScreenSeven({super.key});

  String selectedOption = 'Select';

  List<String> options = [
    "Select",
    "NIN",
    "PVC",
    "International passport",
    "National ID card",
    "Drivers license",
    "Others"
  ];

  @override
  Widget build(BuildContext context) {
    //final serviceProvider = Provider.of<ServiceProviderViewModel>(context, listen: true);

    return Scaffold(
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
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  SafeArea(
                      child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
                  Row(
                    children: [
                       const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios, color: AppColors.lightPrimary,)),
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
                    height: MediaQuery.sizeOf(context).height * 0.35,
                  ),
                  const CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: 'Upload your ID card',
                    weight: FontWeight.w900,
                    size: 24,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 18.0),
                      child: CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        text: 'ID Card type',
                        weight: FontWeight.w400,
                        size: 16,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.lightBackground,
                        borderRadius: BorderRadius.circular(
                            30.0), // Adjust the border radius as needed.
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedOption,
                        onChanged: (value) {
                          selectedOption = value!;
                          
                          // serviceProvider.setPhotoId(options.indexOf(value).toString());
                        },
                        items: options.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option, // Ensure each value is unique.
                            child: Text(option),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20),
                    child: ButtonView(
                      onPressed: () {
                        if (selectedOption != 'Select') {
                          AppNavigator.pushAndStackPage(context,
                              page:   KycServiceScreenEight());
                        } else {
                          Modals.showToast('Please select an id Type');
                        }
                      },
                      color: AppColors.lightPrimary,
                      borderRadius: 30,
                      child: const CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: 'Next',
                        weight: FontWeight.w400,
                        size: 16,
                        fontFamily: AppStrings.interSans,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
