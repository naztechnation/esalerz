import 'package:esalerz/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/user_model/all_products.dart';
import '../../res/app_colors.dart';
import '../../res/app_strings.dart';
import '../services_screens/userservice_info.dart';
import 'image_view.dart';
import 'widget.dart';

class ServiceItem extends StatelessWidget {
  final List<ProductsData> products;
  final bool isHome;
  final Function(
    String adId,
    bool isLiked
  ) onTapLike;

  final bool isListView;
  final bool isLoading;
  const ServiceItem(
      {super.key,
      required this.products,
      required this.isHome,
      required this.onTapLike,
      required this.isListView,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isListView
        ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: (isHome)
                ? (products.length >= 4)
                    ? 4
                    : products.length
                : products.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              ProductsData productData = products[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ItemBody(context, productData),
              );
            },
          )
        : MasonryGridView.builder(
            itemCount: (isHome)
                ? (products.length >= 4)
                    ? 4
                    : products.length
                : products.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              ProductsData productData = products[index];

              return GestureDetector(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ItemBody(context, productData)),
              );
            });
  }

  Widget ItemBody(
    BuildContext context,
    ProductsData productData,
  ) {
    if (isListView) {
      return Container(
        height: 150,
        child: Row(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    NavigationHelper.navigateToPage(
                        context,
                        UserServiceInfo(
                          adsId: productData.id ?? '2',
                        ));
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        child: ImageView.network(
                          '${productData.file?.first}',
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onTapLike(productData.id ?? '', true);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 42,
                      width: 42,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: (isLoading) ? ImageView.asset(AppImages.loadingLike) : const Center(
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.lightSecondary,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  productData.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '₦ Free',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(Icons.star,
                        size: 16, color: AppColors.lightPrimary),
                    const SizedBox(width: 3),
                    Text(
                      '4',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.lightPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
         onTap: () {
                    NavigationHelper.navigateToPage(
                      context,
                      UserServiceInfo(
                        adsId: productData.id ?? '2',
                      ));
                  },
        child: Container(
          padding: const EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      // width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: ImageView.network(
                            '${productData.file?.first}',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                          color: AppColors.lightPrimary.withOpacity(0.2),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                    ),
                    GestureDetector(
                      onTap: () {
                      onTapLike(productData.id ?? '', false);
                    },
                      child: Positioned(
                        top: 5,
                        right: 5,
                        child: SizedBox(
                          height: 42,
                          width: 42,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: (isLoading) ? ImageView.asset(AppImages.loadingLike) : const Center(
                              child:  Icon(
                                Icons.favorite_border,
                                color: AppColors.lightSecondary,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                productData.title ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Free',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    size: 16, color: AppColors.lightPrimary),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '4',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.lightPrimary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
