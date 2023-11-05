import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:flutter/material.dart';

import '../handlers/secure_handler.dart';
import '../res/app_routes.dart';
import '../utils/animation.dart';
import '../utils/navigator/page_navigator.dart';
import 'widgets/image_view.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {

  bool hide = false;

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.bg2), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.black.withOpacity(.9),
            Colors.black.withOpacity(.4),
          ])),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const ImageView.asset(
                  AppImages.icon,
                  width: 180,
                  height: 150,
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const FadeAnimation(
                        1,
                        Text(
                          "Your All-in-One Services Platform",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const FadeAnimation(
                        1.3,
                        Text(
                          "Welcome to Esalerz, the ultimate platform for accessing a diverse world of artisan services.",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                    const SizedBox(
                      height: 100,
                    ),
                    // FadeAnimation(
                    //     1.7,
                    //     Padding(
                    //       padding: const EdgeInsets.only(bottom: 20),
                    //       child: InkWell(
                    //         onTap: () {
                    //           AppNavigator.pushAndReplaceName(context,
                    //               name: AppRoutes.loginScreen);   
                    //         },
                    //         child: Container(
                    //           height: 50,
                    //           decoration: BoxDecoration(
                    //               color: AppColors.lightPrimary,
                    //               borderRadius: BorderRadius.circular(50)),
                    //           child: const Center(
                    //             child: Text(
                    //               "Get started",
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     )),
                    
                         Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            onTap: () {
                               StorageHandler.saveOnboardState('true');
                               
                              AppNavigator.pushAndReplaceName(context,
                                  name: AppRoutes.loginScreen);   
                            },
                            child:  Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.lightPrimary),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Center(
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
