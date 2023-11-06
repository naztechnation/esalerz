import 'package:esalerz/ui/auth/auth.dart';
import 'package:esalerz/ui/on_boarding/boarding_screen.dart';
import 'package:esalerz/ui/welcomepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../splash_screen.dart';
import '../ui/services/landingpage.dart';
import '../ui/services/post_ad.dart';

class AppRoutes {
  static const String splashScreen = 'splashScreen';
  static const String onBoardingScreen = 'onBoardingScreen';
  static const String welcomeScreen = 'welcomeScreen';
  static const String loginScreen = 'loginScreen';
  static const String landingPage = 'landingPage';
  static const String postAd = 'postAd';

  static Map<String, Widget Function(BuildContext)> routes = {
    splashScreen: (context) => const SplashScreen(),
    onBoardingScreen: (context) => const OnboardingScreen(),
    welcomeScreen: (context) => const WelcomePage(),
    loginScreen: (context) => const LoginScreen(),
    landingPage: (context) => const LandingPage(),
    postAd: (context) => const PostAd(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Add your screen here as well as the transition you want
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case welcomeScreen:
        return MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case landingPage:
        return MaterialPageRoute(
          builder: (context) => const LandingPage(),
        );
      case postAd:
        return MaterialPageRoute(
          builder: (context) => const PostAd(),
        );
      default:
        return CupertinoPageRoute(
            builder: (context) => errorView(settings.name!));
    }
  }

  static Widget errorView(String name) {
    return Scaffold(body: Center(child: Text('404 $name View not found')));
  }
}
