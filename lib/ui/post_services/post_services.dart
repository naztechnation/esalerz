

import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart'; 
import 'package:flutter/material.dart';

import '../../../utils/navigator/page_navigator.dart';
import '../widgets/image_view.dart';
import 'serviecs_categories.dart';

class PostServices extends StatefulWidget {
  const PostServices({super.key});

  @override
  State<PostServices> createState() => _PostAdState();
}

class _PostAdState extends State<PostServices> {
  final categoryController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
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
                            'Please Select the Category you want to publish to',
                            style: TextStyle(
                              color: AppColors.lightSecondary,
                              fontSize: 23,
                              fontWeight: FontWeight.w700

                            ),
                          ),
                          const SizedBox(height: 30,),
                          GestureDetector(
                            onTap: () {
                              AppNavigator.pushAndStackPage(context,
                          page: ServicesCategory());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                                // color: AppColors.lightPrimary,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: ListTile(
                                title: Text(
                                  'Select Categories',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          //       const SizedBox(height: 15),
                          //       //title
                          //       TextEditView(
                          //         readOnly: true,
                          //         controller: titleController,
                          //         hintText: 'Title*',
                          //         filled: false,
                          //         autofocus: false,
                          //         isDense: true,
                          //         borderColor: Colors.grey,
                          //       ),
                          //       const SizedBox(height: 15),

                          //       //description
                          //       TextEditView(
                          //         readOnly: true,
                          //         controller: descriptionController,
                          //         hintText: 'Description*',
                          //         filled: false,
                          //         autofocus: false,
                          //         isDense: true,
                          //         borderColor: Colors.grey,
                          //       ),
                          //       const SizedBox(height: 15),

                          //       //location
                          //       TextEditView(
                          //         readOnly: true,
                          //         controller: locationController,
                          //         hintText: 'Location*',
                          //         filled: false,
                          //         autofocus: false,
                          //         isDense: true,
                          //         borderColor: Colors.grey,
                          //         prefixIcon: const Icon(
                          //           Icons.location_on,
                          //           color: Colors.grey,
                          //         ),
                          //         suffixIcon: const Icon(
                          //           Icons.arrow_forward_ios,
                          //           color: Colors.grey,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(height: 20),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 15, vertical: 15),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(5),
                          //     color: AppColors.lightSecondary.withOpacity(0.03),
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       //Name
                          //       TextEditView(
                          //         readOnly: true,
                          //         controller: categoryController,
                          //         hintText: '',
                          //         labelText: 'Name*',
                          //         filled: false,
                          //         autofocus: false,
                          //         isDense: true,
                          //         borderColor: Colors.grey,
                          //       ),
                          //       const SizedBox(height: 15),
                          //       //Phone number
                          //       TextEditView(
                          //         readOnly: true,
                          //         controller: titleController,
                          //         hintText: '',
                          //         labelText: 'Phone number(digits only)*',
                          //         filled: false,
                          //         autofocus: false,
                          //         isDense: true,
                          //         borderColor: Colors.grey,
                          //       ),
                          //       const SizedBox(height: 15),
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(height: 25),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          //   child: ButtonView(
                          //         onPressed: () {
                          //            AppNavigator.pushAndReplacePage(context, page: LandingPage());
                          //         },
                          //         color:   AppColors.lightPrimary ,
                          //         borderRadius: 32,
                          //         borderColor: Colors.white,
                          //         child: CustomText(
                          //           textAlign: TextAlign.center,
                          //           maxLines: 1,
                          //           text: 'Post Ads',
                          //           weight: FontWeight.w700,
                          //           size: 16,
                          //           fontFamily: AppStrings.interSans,
                          //           color:    AppColors.cardColor  ,
                          //         ),
                          //       ),
                          // ),
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
