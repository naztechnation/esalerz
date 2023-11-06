import 'package:esalerz/kyc/service_kyc_one.dart';
import 'package:esalerz/ui/widgets/custom_button_nav.dart/custom_button_nav.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/home.dart';
import 'package:esalerz/ui/profile.dart';
import 'package:esalerz/ui/ads.dart';
import 'package:esalerz/ui/services.dart';
import 'package:provider/provider.dart';

import '../provider/items.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<Widget> _pages = [
    const Home(),
    Services(),
    Ads(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    final pageIndexProvider = Provider.of<PageIndexProvider>(context);
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: FloatingActionButton(
          heroTag: "Sell",
          elevation: 10,
          backgroundColor: AppColors.lightPrimary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: const BorderSide(color: AppColors.lightPrimary)),
          splashColor: AppColors.lightPrimary,
          child: const Text('Sell'),
          onPressed: () {
            NavigationHelper.navigateToPage(context, KycServiceScreenOne());
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppColors.cardColor, blurRadius: 14, spreadRadius: 3),
          ],
        ),
        child: FABBottomAppBar(
          onTabSelected: (index) {
            pageIndexProvider.changePageIndex(index);
          },
          color: Theme.of(context).textTheme.caption!.color!,
          selectedColor: AppColors.lightPrimary,
          backgroundColor: AppColors.cardColor,
          notchedShape: const CircularNotchedRectangle(),
          selectedFontSize: 15,
          items: [
            FABBottomAppBarItem(
              label: 'Home',
              icon: 'assets/images/homee.png',
              selectedIcon: 'assets/images/homee.png',
            ),
            FABBottomAppBarItem(
              label: 'Services',
              icon: 'assets/images/setting.png',
              selectedIcon: 'assets/images/setting.png',
            ),
            FABBottomAppBarItem(
              label: 'Ads',
              icon: 'assets/images/reportt.png',
              selectedIcon: 'assets/images/reportt.png',
            ),
            FABBottomAppBarItem(
              label: 'Profile',
              icon: 'assets/images/person.png',
              selectedIcon: 'assets/images/person.png',
            ),
          ],
        ),
      ),
      body: _pages[pageIndexProvider.currentPageIndex],
    );
  }
}
