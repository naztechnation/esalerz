import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      required this.leadingIcon,
      required this.trailingIcon});
  final String title;
  final IconData leadingIcon;
  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: AppBar(
          backgroundColor: AppColors.lightBackground,
          elevation: 0,
          title: BigText(
            text: title,
          ),
          leading: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightPrimary),
            child: Center(
              child: Icon(leadingIcon),
            ),
          ),
          actions: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.lightPrimary),
              child: Center(
                child: Icon(trailingIcon),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
