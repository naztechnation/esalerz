import 'dart:io';

import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/button_view.dart';
import 'package:esalerz/ui/widgets/custom_text.dart'; 
import 'package:flutter/material.dart';


import '../../../res/app_colors.dart';
import '../../../res/app_routes.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';

class KycServiceScreenNine extends StatelessWidget {
  const KycServiceScreenNine({super.key});

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<AccountViewModel>(context, listen: true);

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
            child: Column(
              children: [
                SafeArea(
                    child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
                const Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    CustomText(
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
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Material(
                    elevation: 1,
                    type: MaterialType.card,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: CustomText(
                              textAlign: TextAlign.justify,
                              maxLines: 3,
                              text:
                                  'Your Id upload is successful and is being reviewed, reviews normally take between 2-4 working days.',
                              weight: FontWeight.w500,
                              size: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                  child: ButtonView(
                    onPressed: () {
                      AppNavigator.pushNamedAndRemoveUntil(context,
                          name: AppRoutes.postAd);
                    },
                    color: AppColors.lightPrimary,
                    child: const CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'Continue to ad',
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
        ],
      ),
    );
  }
}
