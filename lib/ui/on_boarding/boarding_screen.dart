import 'package:esalerz/res/app_colors.dart';
import 'package:flutter/material.dart';

import '../../model/onboarding_contents.dart';
import '../../res/app_images.dart';
import '../../res/app_routes.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/size_config.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = [
    const Color(0xffDAD3C8).withOpacity(0.7),
    const Color(0xffFFE5DE).withOpacity(0.7),
    const Color(0xffDCF6E6).withOpacity(0.7),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: AppColors.lightPrimary,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Stack(
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
              color: colors[_currentPage],
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
            ),
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (value) =>
                        setState(() => _currentPage = value),
                    itemCount: contents.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            Image.asset(
                              contents[i].image,
                              height: SizeConfig.blockV! * 35,
                            ),
                            SizedBox(
                              height: (height >= 840) ? 60 : 30,
                            ),
                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.lightPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: (width <= 550) ? 30 : 35,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              contents[i].desc,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: (width <= 550) ? 17 : 25,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          contents.length,
                          (int index) => _buildDots(
                            index: index,
                          ),
                        ),
                      ),
                      _currentPage + 1 == contents.length
                          ? Padding(
                              padding: const EdgeInsets.all(30),
                              child: ElevatedButton(
                                onPressed: () {
                                  
                                  AppNavigator.pushAndReplaceName(context,
                                      name: AppRoutes.welcomeScreen);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.lightPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: (width <= 550)
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 20)
                                      : EdgeInsets.symmetric(
                                          horizontal: width * 0.2,
                                          vertical: 25),
                                  textStyle: TextStyle(
                                      fontSize: (width <= 550) ? 13 : 17),
                                ),
                                child: const Text("GET STARTED", style: TextStyle(color: Colors.white),),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _controller.jumpToPage(2);
                                    },
                                    style: TextButton.styleFrom(
                                      elevation: 0,
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: (width <= 550) ? 13 : 17,
                                      ),
                                    ),
                                    child: const Text(
                                      "SKIP",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeIn,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.lightPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      elevation: 0,
                                      padding: (width <= 550)
                                          ? const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 20)
                                          : const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 25),
                                      textStyle: TextStyle(
                                          fontSize: (width <= 550) ? 13 : 17),
                                    ),
                                    child: const Text("NEXT", style: TextStyle(color: Colors.white),),
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
