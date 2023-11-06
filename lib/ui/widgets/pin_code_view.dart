 
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../res/app_colors.dart';

class PinCodeView extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String> onChanged;
  final int length;
  final bool obscureText;
  final bool autoFocus;
  final String? label;
  const PinCodeView({
    required this.controller,
    this.validator,
    this.length=6,
    this.obscureText=false,
    this.autoFocus=false,
    this.onCompleted,
    required this.onChanged,
    this.label,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label!=null)...[
          Text(label!,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              )),
          const SizedBox(height: 15)
        ],
        PinCodeTextField(
          controller: controller,
          length: length,
          obscureText: obscureText,
          autoFocus: autoFocus,
          obscuringCharacter: '*',
          keyboardType: TextInputType.number,
          animationType: AnimationType.fade,
          autoDismissKeyboard: true,
          validator: validator,
          enablePinAutofill: true,
          textStyle: const TextStyle(color: AppColors.lightPrimary, fontWeight: FontWeight.w300),
          pinTheme: PinTheme(
            
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(16.0),
            borderWidth: 1.8,
            activeBorderWidth: 0.7,
            inactiveBorderWidth: 0.7,
            selectedBorderWidth: 0.7,
            fieldHeight: 55,
            fieldWidth: 55,
            
            selectedColor: AppColors.lightPrimary,
            activeFillColor: Colors.white,
            selectedFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            inactiveColor: AppColors.lightPrimary,
            activeColor: AppColors.lightPrimary
          ),
          
          enableActiveFill: true,
          animationDuration: const Duration(milliseconds: 300),
          onCompleted: onCompleted,
          onChanged: onChanged,
          beforeTextPaste: (text) {
            return true;
          },
          appContext: context,
        ),

        
      ],
    );
  }
}
