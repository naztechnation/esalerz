import 'dart:io';

import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/button_view.dart';
import 'package:esalerz/ui/widgets/custom_text.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';

import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';

import 'service_kyc_five.dart';

class KycServiceScreenFour extends StatelessWidget {
  KycServiceScreenFour({
    super.key,
  });

  final TextEditingController _serviceProviderAgeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final serviceProvider =
    //     Provider.of<ServiceProviderViewModel>(context, listen: true);

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
                    text: 'Your age',
                    weight: FontWeight.w700,
                    size: 32,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: TextEditView(
                      
                      controller: _serviceProviderAgeController,
                      isDense: true,
                      readOnly: true,
                      labelText: 'Year/Month/Day',
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        size: 32,
                      ),
                      onTap: () async {
                        await DatePickerHelper.showDatePickerDialog(
                            context, _serviceProviderAgeController);
                      },
                    ),
                  ),
                  const Spacer(),
                  //if (serviceProvider.serviceProviderAge != '')
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20),
                    child: ButtonView(
                      onPressed: () {
                        // serviceProvider.setServiceProviderAge(
                        //     _serviceProviderAgeController.text);

                        AppNavigator.pushAndStackPage(context,
                            page: KycServiceScreenFive());
                      },
                      color: AppColors.lightPrimary,
                      borderRadius: 22,
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

//age date picker
class DatePickerHelper {
  static Future<void> showDatePickerDialog(
      BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.lightPrimary, // header background color
              onPrimary: AppColors.cardColor, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.lightPrimary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      final DateFormat dateFormat = DateFormat('y/M/d');
      final String formattedDate = dateFormat.format(selectedDate);
      controller.text = formattedDate;
    }
  }
}
