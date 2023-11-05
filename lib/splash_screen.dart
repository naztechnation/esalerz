import 'dart:async';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/res/app_routes.dart';
import 'package:esalerz/ui/auth/auth.dart';
import 'package:esalerz/ui/widgets/image_view.dart';
import 'package:esalerz/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';

import 'handlers/secure_handler.dart';
import 'ui/landingpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

    bool userLoggedIn = false;
  String isOnBoarding = '';

  getUserDetails() async {
    userLoggedIn = await StorageHandler.isLoggedIn();
    isOnBoarding = await StorageHandler.getOnBoardState();
  }

  startTime() async {
    // var duration = const Duration(seconds: 3);
    Future.delayed(const Duration(seconds:2, ),(){
  navigationPage();
    });
    //  Timer(duration, navigationPage);
  }

    void navigationPage() {

    if (isOnBoarding == '') {
          AppNavigator.pushAndReplaceName(context, name: AppRoutes.onBoardingScreen);

    } else if (userLoggedIn) {
      AppNavigator.pushAndReplacePage(context,
                      page: const LandingPage());
     
    }else{
      StorageHandler.logout();
       AppNavigator.pushAndReplacePage(context, page:LoginScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

       

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
     startTime();
  }

   @override
  void dispose() {
    animationController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppImages.bg,
                    ),
                    fit: BoxFit.cover)),
          ),
          Container(color: Colors.white38,
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'powered by premium eswop',
                    style: TextStyle(color: AppColors.lightPrimary),
                  ))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageView.asset(
                AppImages.logo,
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
