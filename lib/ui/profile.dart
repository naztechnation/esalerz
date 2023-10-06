import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:esalerz/ui/widgets/button_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';

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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.arrow_back, color: AppColors.lightPrimary),
            ),
          ),
        ),
        actions: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Image.asset(
              'assets/images/notification1.png',
              height: 25,
              color: AppColors.lightPrimary,
            )),
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
                        TextInputField.customTextField(
                          labeText: 'First Name',
                          controller: firstNameController,
                          hintText: 'Enter first name',
                          focusedBorderColor: AppColors.lightPrimary,
                          enabledBorderColor: Colors.grey,
                        ),
                        const SizedBox(height: 20),
                        TextInputField.customTextField(
                          labeText: 'Last Name',
                          controller: lastNameController,
                          hintText: 'Enter last name',
                          focusedBorderColor: AppColors.lightPrimary,
                          enabledBorderColor: Colors.grey,
                        ),
                        const SizedBox(height: 20),
                        TextInputField.customTextField(
                          labeText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          hintText: 'Enter email',
                          focusedBorderColor: AppColors.lightPrimary,
                          enabledBorderColor: Colors.grey,
                        ),
                        const SizedBox(height: 20),
                        TextInputField.customTextField(
                          labeText: 'Phone Number',
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          hintText: 'Enter number',
                          focusedBorderColor: AppColors.lightPrimary,
                          enabledBorderColor: Colors.grey,
                        ),
                        const SizedBox(height: 20),
                        TextInputField.customTextField(
                          labeText: 'Address',
                          controller: addressController,
                          hintText: 'Enter adress',
                          focusedBorderColor: AppColors.lightPrimary,
                          enabledBorderColor: Colors.grey,
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
