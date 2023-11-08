import 'dart:io';

import 'package:esalerz/ui/kyc/service_kyc_seven.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/button_view.dart';
import 'package:esalerz/ui/widgets/custom_text.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

import '../../../../res/app_colors.dart';
import '../../../../res/app_strings.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../model/view_models/account_view_model.dart';
 

class KycServiceScreenSix extends StatefulWidget {
  KycServiceScreenSix({
    super.key,
  });

  @override
  State<KycServiceScreenSix> createState() => _KycServiceScreenSixState();
}

class _KycServiceScreenSixState extends State<KycServiceScreenSix> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
        final serviceProvider = Provider.of<AccountViewModel>(context, listen: false);


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
              child: Column(
                children: [
                  SafeArea(
                    child: SizedBox(height: (Platform.isAndroid) ? 30 : 0),
                  ),
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
                    height: MediaQuery.sizeOf(context).height * 0.13,
                  ),
                  const CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Tell us about you',
                    weight: FontWeight.w700,
                    size: 28,
                    fontFamily: AppStrings.montserrat,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: TextEditView(
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: commentController,
                      fillColor: AppColors.cardColor,
                      maxLines: 10,
                      borderRadius: 22,
                      textInputAction: TextInputAction.done,
                      maxLength: 2000,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.10,
                  ),
                  if (commentController.text != '')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20),
                      child: ButtonView(
                        onPressed: () {
                          serviceProvider
                              .setAbout(commentController.text);
                          AppNavigator.pushAndStackPage(context,
                              page: KycServiceScreenSeven());
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
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
