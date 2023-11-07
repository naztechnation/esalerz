import 'package:esalerz/extentions/custom_string_extension.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../widgets/text_edit_view.dart';

class AdsCategory extends StatefulWidget {
  final String category;

  AdsCategory({super.key, required this.category});

  @override
  State<AdsCategory> createState() => _AdsState(category: category);
}

class _AdsState extends State<AdsCategory> {
  final String category;

  _AdsState({required this.category});

  final searchController = TextEditingController();

  final List<String> items = [
    'All',
    'Laptops',
    'Home Appliances',
    'Phones',
    'Cars',
  ];

  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.cardColor,
          elevation: 1,
          centerTitle: true,
          title: Text(
            '${category.capitalizeFirstOfEach} Services',
            style: TextStyle(fontSize: 18, color: Colors.black),
          )),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: TextEditView(
                    controller: searchController,
                    hintText: 'What are you looking for...',
                    filled: false,
                    autofocus: false,
                    isDense: true,
                    borderColor: AppColors.lightPrimary,
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Services', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isGridView = !isGridView;
                        });
                      },
                      icon: Image.asset(
                        'assets/images/grid.png',
                        height: 40,
                        color: isGridView ? AppColors.lightPrimary : Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isGridView = !isGridView;
                        });
                      },
                      icon: Image.asset(
                        'assets/images/list.png',
                        height: 40,
                        color: isGridView ? Colors.black : AppColors.lightPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Visibility(
                    visible: isGridView,
                    child: buildMasonryGridView(),
                  ),
                  Visibility(
                    visible: !isGridView,
                    child: buildListView(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
