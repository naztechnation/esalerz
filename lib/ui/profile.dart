import 'package:esalerz/res/app_colors.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        elevation: 0,
        title: const Text(
          'Hello, Samson',
          style: TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.w900),
        ),
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Icon(Icons.menu, color: AppColors.lightPrimary),
          ),
        ),
      ),
    );
  }
}
