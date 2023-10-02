import 'package:esalerz/model/service_contents.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:esalerz/ui/widgets/dotindicator.dart';
import 'package:esalerz/ui/widgets/smalltext.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
        backgroundColor: AppColors.lightBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: AppBar(
              backgroundColor: AppColors.lightBackground,
              elevation: 0,
              title: BigText(
                text: 'Hello, Tony Stark!',
              ),
              leading: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.lightPrimary),
                child: const Center(
                  child: Icon(Icons.menu),
                ),
              ),
              actions: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lightPrimary),
                  child: const Center(
                    child: Icon(Icons.notifications),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_sharp,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: SmallText(
                        text: '50 Moonee Beach Rd, Coffs Harbour, South Wales',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
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
                    Container(
                      height: 60,
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
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BigText(text: 'Services'),
                    SmallText(text: 'View all'),
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
                const SizedBox(height: 20),
                AspectRatio(
                  aspectRatio: 1.6,
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
                const SizedBox(height: 10),
                DotIndicator(
                  itemCount: datalist.length,
                  currentIndex: _currentPage,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BigText(text: 'Trending services'),
                    SmallText(text: 'View all'),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  height: 200,
                  child: MasonryGridView.builder(
                    itemCount: 6,
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
      ),
    );
  }
}
