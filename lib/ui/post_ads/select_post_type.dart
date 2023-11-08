
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/button_view.dart'; 
import 'package:flutter/material.dart';

import '../../res/app_routes.dart';
import '../../utils/navigator/page_navigator.dart';
import '../services_screens/landingpage.dart';
import '../widgets/image_view.dart';

class SelectPostType extends StatefulWidget {
  const SelectPostType({super.key});

  @override
  State<SelectPostType> createState() => _SelectPostTypeState();
}

class _SelectPostTypeState extends State<SelectPostType> {
   
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
                'Esalerz',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                AppNavigator.pushAndReplacePage(context, page: LandingPage());
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
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AppImages.bg,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            color: Colors.white70,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height - AppBar().preferredSize.height -150,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.lightSecondary.withOpacity(0.03),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Please select what you want to offer...',
                            style: TextStyle(
                              color: AppColors.lightPrimary,
                              fontSize: 22,
                              fontWeight: FontWeight.w600

                            ),
                          ),
                          const SizedBox(height: 30,),
                          
                          ButtonView(onPressed: (){
                             AppNavigator.pushAndStackNamed(context,
                          name: AppRoutes.postAd);
                          
                          }, child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageView.asset(AppImages.worker, height: 50,),
                              const SizedBox(width: 10,),
                              Text(
                                'Offer Services'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700

                                ),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          color: AppColors.lightPrimary.withOpacity(0.5),
                          ),
                          const SizedBox(height: 30,),
                           ButtonView(onPressed: (){
                             AppNavigator.pushAndStackNamed(context,
                          name: AppRoutes.postAd);
                           }, child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                             children: [
                              ImageView.asset(AppImages.sale, height: 50,),
                              const SizedBox(width: 20,),
                               Text(
                                'Sale Product'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700

                                ),
                          ),
                             ],
                           ),
                           padding: const EdgeInsets.symmetric(vertical: 25),
                          color: AppColors.lightPrimary.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  )))
        ]));
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
    'Sports, Arts & Outdorrs',
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
