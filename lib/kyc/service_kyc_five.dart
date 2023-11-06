import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/button_view.dart';
import 'package:esalerz/ui/widgets/custom_text.dart';
import 'package:esalerz/ui/widgets/modals.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

import '../../../res/app_colors.dart';

import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';

import '../model/view_models/account_view_model.dart';
import 'service_kyc_six.dart';

class KycServiceScreenFive extends StatelessWidget {
  KycServiceScreenFive({
    super.key,
  });

  String state = '';
  String country = '';
  String city = '';

  @override
  Widget build(BuildContext context) {
        final userProfile = Provider.of<AccountViewModel>(context, listen: false);


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
                    height: MediaQuery.sizeOf(context).height * 0.2,
                  ),
                  const SizedBox(height: 55),
                  const CustomText(
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    text: 'Your Location',
                    weight: FontWeight.w700,
                    size: 32,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: CSCPicker(
                      layout: Layout.vertical,
                      onCountryChanged: (value) {
                        
                        country = value;
                      },
                      onStateChanged: (value) {
                        
                        state = value ?? '';
                      },
                      onCityChanged: (value) {
                        
                        city = value ?? '';
                      },
                    ),
                  ),
                  const Spacer(),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20),
                    child: ButtonView(
                      onPressed: () {
                       

                        if (country == '') {
                          Modals.showToast('please select a country');
                        } else if (state == '') {
                          Modals.showToast('please select a state');
                        } else if (city == '') {
                          Modals.showToast('please select a city');
                        } else {
                          userProfile.setAddress('${country },${state}, ${city}');
                          AppNavigator.pushAndStackPage(context,
                              page: KycServiceScreenSix());
                        }
                      },
                      color: AppColors.lightPrimary,
                      borderRadius: 22,
                      borderColor: Colors.white,
                      child: const CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        text: 'Next',
                        weight: FontWeight.w500,
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
