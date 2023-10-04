import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../res/app_colors.dart';
import 'widgets/horizontal_selection.dart';
import 'widgets/text_edit_view.dart';

class Ads extends StatelessWidget {
  Ads({super.key});

  final searchController = TextEditingController();

  final List<String> items = [
    'All',
    'Laptops',
    'Home Appliances',
    'Phones',
    'Cars',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.cardColor,
          elevation: 1,
          centerTitle: true,
          title: const Text(
            'Ads Services',
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
          Expanded(
            child: GridView.custom(
              gridDelegate: SliverWovenGridDelegate.count(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                pattern: [
                  const WovenGridTile(0.8),
                  const WovenGridTile(
                    5 / 7,
                    crossAxisRatio: 0.9,
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SimilarAdsModel(
                        onPressed: () {},
                        imageUrl: 'assets/images/laugage.png',
                        title: 'Travel bag',
                        price: '20.99',
                        rating: 4, isListView: false,)),
              ),
            ),
          ),
          // Expanded(
          //   child: MasonryGridView.builder(
          //     itemCount: 6,
          //     gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2),
          //     itemBuilder: (context, index) => const Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: TrendingServiceModel(
          //             imageUrl: 'assets/images/laugage.png',
          //             title: 'House cleaning',
          //             price: '20.99',
          //             rating: 4)),
          //   ),
          // ),
        ],
      ),
    );
  }
}
