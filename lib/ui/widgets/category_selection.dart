import 'package:esalerz/res/app_colors.dart';
import 'package:flutter/material.dart';

import 'text_edit_view.dart';

class CategorySelection extends StatelessWidget {
  final List<String> categories;
  final List<IconData> categoryIcons;

  final searchController = TextEditingController();

  CategorySelection(
      {super.key, required this.categories, required this.categoryIcons});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
          const Divider(
            height: 0,
            thickness: 1.0,
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
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
        ],
      ),
    );
  }
}
