import 'dart:io';

import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/button_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../ui/widgets/custom_text.dart';
import 'service_kyc_two.dart';

class KycServiceScreenOne extends StatelessWidget {
  KycServiceScreenOne({
    super.key,
  });

  final TextEditingController _petNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //  final petProfile = Provider.of<AccountViewModel>(context, listen: false);

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
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: 'Now lets get to know \nabout you.',
                              weight: FontWeight.w700,
                              size: 28,
                              fontFamily: AppStrings.interSans,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.3),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 20),
                          child: ButtonView(
                            onPressed: () {
                              //   petProfile.setPetName(_petNameController.text);

                              AppNavigator.pushAndStackPage(context,
                                  page: KycServiceScreenTwo());
                            },
                            color: AppColors.lightPrimary,
                            borderRadius: 22,
                            borderColor: Colors.white,
                            child: const CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              text: 'Continue',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
