import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../widgets/horizontal_selection.dart';
import '../widgets/text_edit_view.dart';

class Services extends StatefulWidget {
  Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final searchController = TextEditingController();

  bool isGridView = true;

  final List<String> items = [
    'All',
    'House Cleaning',
    'Capenter',
    'Mechanic',
    'Dry Cleaning',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.cardColor,
          elevation: 1,
          centerTitle: true,
          title: const Text(
            'Trending Services',
            style: TextStyle(fontSize: 18, color: Colors.black),
          )),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: TextEditView(
                    controller: searchController,
                    hintText: 'Search your service here...',
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lightPrimary,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          HorizontalCardList(
            items: items,
          ),
          const SizedBox(
            height: 15,
          ),
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
                  height: 30,
                  color: isGridView ? Colors.black : AppColors.lightPrimary,
                ),
              ),
               const SizedBox(
            width: 15,
          ),
            ],
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
