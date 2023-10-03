import 'package:esalerz/model/service_contents.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:esalerz/ui/widgets/dotindicator.dart';
import 'package:esalerz/ui/widgets/smalltext.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../provider/items.dart';
import '../res/app_images.dart';
import 'widgets/location_container.dart';
import 'widgets/modals.dart';

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
     final pageIndexProvider = Provider.of<PageIndexProvider>(context);

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
                'What are You Searching For Today?',
                style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w900),
              ),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(Icons.menu, color: AppColors.lightPrimary),
                ),
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
                    GestureDetector(
                      onTap: (){
                        Modals.showBottomSheetModal(
                         
                          context, page: CountryListWidget(countries: countries,),  heightFactor: 1, isScrollControlled: true);
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            color: AppColors.lightSecondary,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                             
                             '58 iweka road, Onitsha.',
                             maxLines: 1,
                             
                             style: TextStyle(fontSize: 14, ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            color: Colors.black,
                          ),
                        ],
                      ),
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
                        const Text(
                            'Services',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800) ,
                          
                        ),
                        GestureDetector(
                          onTap: (){
                            pageIndexProvider.changePageIndex(1);
                          },
                          child: const Text(
                              'View all',
                              style: TextStyle(
                                 fontSize: 12,
                            color: AppColors.lightSecondary,
                            // decoration: TextDecoration.underline,
                              ),
                           
                          ),
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
                        const Text(
                            'Trending Ads',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800) ,
                          
                        ),
                                               GestureDetector(
                          onTap: (){
                            pageIndexProvider.changePageIndex(2);
                          },
                          child: const Text(
                              'View all',
                              style: TextStyle(
                                 fontSize: 12,
                            color: AppColors.lightSecondary,
                            // decoration: TextDecoration.underline,
                              ),
                           
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 460,
                      child: MasonryGridView.builder(
                        itemCount: 4,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TrendingServiceModel(
                                imageUrl: 'assets/images/laugage.png',
                                title: 'Travel Laugage',
                                price: '20,222333.99',
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

  List<String> countries = [
    'Abia',
    'Adamawa',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Edo',
    'Ekiti',
    'Enugu',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara',
  ];
}
