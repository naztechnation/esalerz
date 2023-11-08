import 'package:esalerz/res/app_colors.dart';
import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import '../widgets/image_view.dart';
import '../widgets/text_edit_view.dart';

class ServicesCategory extends StatefulWidget {
  ServicesCategory({
    super.key,
  });

  @override
  State<ServicesCategory> createState() => _ServicesCategoryState();
}

class _ServicesCategoryState extends State<ServicesCategory> {
  final searchController = TextEditingController();

  final PageController _pageController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageView.asset(
              AppImages.icon,
              height: 30,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              'Services Category',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  Icons.close,
                  color: AppColors.lightPrimary,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (selectedIndex == 0) ...[
            Container(
              padding: const EdgeInsets.only(top: 30, left: 14, right: 14),
              height: 110,
              color: AppColors.lightPrimary,
              child: TextEditView(
                controller: searchController,
                hintText: 'Find category...',
                filled: true,
                autofocus: false,
                isDense: true,
                fillColor: Colors.white,
                borderColor: AppColors.lightPrimary,
                prefixIcon: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.only(top: 30, left: 14, right: 14),
              height: 110,
              color: AppColors.lightPrimary,
              child: TextEditView(
                controller: searchController,
                hintText: 'Search subcategory...',
                filled: true,
                autofocus: false,
                isDense: true,
                fillColor: Colors.white,
                borderColor: AppColors.lightPrimary,
                prefixIcon: GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 700),
                      curve: Curves.ease,
                    );
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
          const Divider(
            height: 0,
            thickness: 1.0,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: categories.length,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 1.0,
                              height: 0,
                            );
                          },
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(
                                categoryIcons[index],
                                color: AppColors.lightPrimary,
                              ),
                              title: Text(categories[index]),
                              trailing: const Icon(Icons.keyboard_arrow_right,
                                  color: AppColors.lightPrimary),
                              onTap: () {
                                setState(() {
                                  selectedIndex = 1;
                                });
                                _pageController.animateToPage(
                                  1,
                                  duration: Duration(milliseconds: 700),
                                  curve: Curves.ease,
                                );
                              },
                            );
                          },
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: categories.length,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 1.0,
                              height: 0,
                            );
                          },
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(
                                categoryIcons[index],
                                color: AppColors.lightPrimary,
                              ),
                              title: Text(categories[index]),
                              trailing: const Icon(Icons.keyboard_arrow_right,
                                  color: AppColors.lightPrimary),
                              onTap: () {},
                            );
                          },
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> categories = [
    'Agriculture & Foods',
    'Babies & Kids',
    'Commercial Equipments & Tools',
    'Electronics',
    'Fashion',
    'Health & Beauty',
    'Home, Furniture & Appliances',
    'Jobs',
    'Mobile Phone & Tablets',
    'Pets',
    'Property',
    'Repair & Construction',
    'Services',
    'Sports, Arts & Outdoors',
    'Vehicles',
  ];

  List<IconData> categoryIcons = [
    Icons.agriculture,
    Icons.child_care,
    Icons.build_circle,
    Icons.electrical_services_rounded,
    Icons.woman_2_outlined,
    Icons.health_and_safety,
    Icons.home,
    Icons.work,
    Icons.phone_android_sharp,
    Icons.pets,
    Icons.house_siding_rounded,
    Icons.construction,
    Icons.laptop_sharp,
    Icons.sports_esports,
    Icons.fire_truck,
  ];
}
