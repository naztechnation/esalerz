import 'package:esalerz/model/service_contents.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:esalerz/ui/widgets/dotindicator.dart';
import 'package:esalerz/ui/widgets/smalltext.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../res/app_images.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchController = TextEditingController();

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      //viewportFraction: 1,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.cardColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: AppBar(
              backgroundColor: AppColors.cardColor,
              elevation: 0,
              title: const Text(
                'Hello, Emma!',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(Icons.menu, color: AppColors.lightPrimary),
                ),
              ),
              actions: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(Icons.notifications,
                        color: AppColors.lightPrimary),
                  ),
                ),
              ],
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
                    fit: BoxFit.cover)),
          ),
          Container(color: Colors.white70,
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_sharp,
                          color: AppColors.lightSecondary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: SmallText(
                            size: 14,
                            text: '58 iweka road, Onitsha.',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: 'Services',
                          size: 16,
                        ),
                        SmallText(
                          text: 'View all',
                          size: 12,
                          color: AppColors.lightSecondary,
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      child: Row(
                        children: [
                          ServiceBoard(
                              title: 'Cleaning',
                              asset: 'assets/images/cleaning.png'),
                          SizedBox(width: 20),
                          ServiceBoard(
                              title: 'Beauty', asset: 'assets/images/beauty.png'),
                          SizedBox(width: 20),
                          ServiceBoard(
                              title: 'AC Repair',
                              asset: 'assets/images/repair.png'),
                          SizedBox(width: 20),
                          ServiceBoard(
                              title: 'Salon', asset: 'assets/images/salon.png'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    AspectRatio(
                      aspectRatio: 2.2,
                      child: PageView.builder(
                        itemCount: datalist.length,
                        physics: const BouncingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return promoView(index, context);
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    DotIndicator(
                      itemCount: datalist.length,
                      currentIndex: _currentPage,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: 'Trending services',
                          size: 15,
                        ),
                        SmallText(
                          text: 'View all',
                          size: 12,
                          color: AppColors.lightSecondary,
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 900,
                      child: MasonryGridView.builder(
                        itemCount: 6,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TrendingServiceModel(
                                imageUrl: 'assets/images/cleaner.jpg',
                                title: 'House cleaning',
                                price: 20.99,
                                rating: 4)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
