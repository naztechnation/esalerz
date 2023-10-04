import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/category_selection.dart';
import 'package:esalerz/ui/widgets/modals.dart';
import 'package:esalerz/ui/widgets/smalltext.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';

class PostAd extends StatefulWidget {
  const PostAd({super.key});

  @override
  State<PostAd> createState() => _PostAdState();
}

class _PostAdState extends State<PostAd> {
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
        title: const Text(
          'Post New Ad',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.arrow_back, color: AppColors.lightPrimary),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.lightSecondary.withOpacity(0.03),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //category
                        GestureDetector(
                          onTap: () {
                            Modals.showBottomSheetModal(context,
                                page: CategorySelection(
                                  categoryIcons: categoryIcons,
                                  categories: categories,
                                ),
                                heightFactor: 1,
                                isScrollControlled: true);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.5),
                              borderRadius: BorderRadius.circular(10),
                              // color: AppColors.lightPrimary,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: ListTile(
                              title: SmallText(
                                text: 'Categories*',
                                color: Colors.grey,
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        //title
                        TextEditView(
                          readOnly: true,
                          controller: titleController,
                          hintText: 'Title*',
                          filled: false,
                          autofocus: false,
                          isDense: true,
                          borderColor: Colors.grey,
                        ),
                        const SizedBox(height: 15),

                        //description
                        TextEditView(
                          readOnly: true,
                          controller: descriptionController,
                          hintText: 'Description*',
                          filled: false,
                          autofocus: false,
                          isDense: true,
                          borderColor: Colors.grey,
                        ),
                        const SizedBox(height: 15),

                        //location
                        TextEditView(
                          readOnly: true,
                          controller: locationController,
                          hintText: 'Location*',
                          filled: false,
                          autofocus: false,
                          isDense: true,
                          borderColor: Colors.grey,
                          prefixIcon: const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                          suffixIcon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.lightSecondary.withOpacity(0.03),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Name
                        TextEditView(
                          readOnly: true,
                          controller: categoryController,
                          hintText: '',
                          labelText: 'Name*',
                          filled: false,
                          autofocus: false,
                          isDense: true,
                          borderColor: Colors.grey,
                        ),
                        const SizedBox(height: 15),
                        //Phone number
                        TextEditView(
                          readOnly: true,
                          controller: titleController,
                          hintText: '',
                          labelText: 'Phone number(digits only)*',
                          filled: false,
                          autofocus: false,
                          isDense: true,
                          borderColor: Colors.grey,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  DefaultButton(
                    title: 'Post Ad',
                    textcolor: Colors.white,
                    backgroundcolor: AppColors.lightPrimary,
                    onpressed: () {},
                    bordercolor: AppColors.lightPrimary,
                  ),
                ],
              ),
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
