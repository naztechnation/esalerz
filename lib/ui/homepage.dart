import 'package:flutter/material.dart';

import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/home.dart';
import 'package:esalerz/ui/profile.dart';
import 'package:esalerz/ui/report.dart';
import 'package:esalerz/ui/settings.dart';
import 'package:provider/provider.dart';

import '../provider/items.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   
  final List<Widget> _pages = [
    const Home(),
      Settings(),
      Report(),
    const Profile(),
  ];

  List<BottomNavigationBarItem> _navItems(int selectedIndex) {
    const labels = ['Home', 'Services', 'Ads', 'Profile'];
    const icons = [
      'assets/images/homee.png',
      'assets/images/setting.png',
      'assets/images/reportt.png',
      'assets/images/person.png',
    ];

    return List.generate(
      labels.length,
      (index) => BottomNavigationBarItem(
        tooltip: labels.elementAt(index),
        icon: Image.asset(
          icons[index],
          height: 30,
          color: selectedIndex == index ? AppColors.lightPrimary : Colors.grey,
        ),
        label: labels[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     final pageIndexProvider = Provider.of<PageIndexProvider>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: AppColors.lightPrimary,
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 25,
          ),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 15,
          currentIndex: pageIndexProvider.currentPageIndex,
          onTap: (index){
                            pageIndexProvider.changePageIndex(index);

          },
          items: _navItems( pageIndexProvider.currentPageIndex),
        ),
      ),
      body: _pages[pageIndexProvider.currentPageIndex],
    );
  }
}
