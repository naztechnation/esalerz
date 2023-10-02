import 'package:flutter/material.dart';

import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/home.dart';
import 'package:esalerz/ui/profile.dart';
import 'package:esalerz/ui/report.dart';
import 'package:esalerz/ui/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Home(),
    const Settings(),
    const Report(),
    const Profile(),
  ];

  List<BottomNavigationBarItem> _navItems() {
    const labels = ['Home', 'Settings', 'Report', 'Profile'];
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
          color: _selectedIndex == index ? AppColors.lightPrimary : Colors.grey,
        ),
        label: labels[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
      },
      child: Scaffold(
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
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: _navItems(),
          ),
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
