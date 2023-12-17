import 'package:esalerz/extentions/custom_string_extension.dart';
import 'package:esalerz/model/service_contents.dart';
import 'package:esalerz/model/user_model/all_products.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/bookmark_pages.dart';
import 'package:esalerz/ui/notification/notifications.dart';
import 'package:esalerz/ui/widgets/dotindicator.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/user_model/notifications.dart';
import '../../model/view_models/account_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../provider/items.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_images.dart';
import '../../utils/navigator/page_navigator.dart';
import '../ads_screens/ads_category.dart';
import '../search_page.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../widgets/loading_page.dart';
import '../widgets/location_container.dart';
import '../widgets/modals.dart';
import '../widgets/notification_widget.dart';
import 'package:animated_item/animated_item.dart';

import '../widgets/services_item.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final searchController = TextEditingController();

  late PageController _pageController;
  int _currentPage = 0;

  bool isGridView = true;

  late UserCubit _userCubit;

  String token = '';

  List<ProductsData> products = [];
  List<NotificationsData> notifications = [];

  getProducts() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.getProducts(token: token);
    _userCubit.createNotifications(token: token);
  }

  @override
  void initState() {
    super.initState();
    getProducts();
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
    final user = Provider.of<AccountViewModel>(context, listen: true);
    final notification = Provider.of<UserViewModel>(context, listen: true);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is CreateNotifyLoaded) {
          if (state.notificationsInfo.status == 1) {
            notifications = state.notificationsInfo.data ?? [];
            setState(() {});
          } else {
            notifications = [];
          }
        } else if (state is ProductsLoaded) {
          if (state.products.status == 1) {
            products = state.products.data ?? [];
            setState(() {});
          } else {
            products = [];
          }
        } else if (state is CreateLikeLoaded) {
          if (state.like.status == 1) {
            Modals.showToast(state.like.message ?? '');
          } else {
                       Modals.showToast(state.like.message ?? '');

          }
        }else if (state is RemoveLikeLoaded) {
          if (state.unlike.status == 1) {
            Modals.showToast(state.unlike.message ?? '');
          } else {
                       Modals.showToast(state.unlike.message ?? '');

          }
        }
      }, builder: (context, state) {
        if (state is UserNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            context: context,

            onRefresh: () => _userCubit.getProducts(token: token),
          );
        } else if (state is UserNetworkErrApiErr) {
          return EmptyWidget(
            title: 'Network error',
            context: context,

            description: state.message,
            onRefresh: () => _userCubit.getProducts(token: token),
          );
        }

        return (state is CreateNotifyLoading || state is ProductsLoading)
            ? Scaffold(body: const LoadingPage())
            : Scaffold(
                backgroundColor: AppColors.cardColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(60.0),
                  child: Container(
                    margin: const EdgeInsets.all(0.0),
                    child: AppBar(
                      backgroundColor: AppColors.cardColor,
                      elevation: 1,
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
                            'Esalerz',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                      automaticallyImplyLeading: false,
                      // leading: Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: const Center(
                      //     child: Icon(Icons.menu, color: AppColors.lightPrimary),
                      //   ),
                      // ),
                      actions: [
                        GestureDetector(
                            onTap: () {
                              AppNavigator.pushAndStackPage(context,
                                  page: BookmarksPage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 11.0),
                              child: Icon(
                                Icons.bookmark,
                                color: AppColors.lightPrimary,
                                size: 30,
                              ),
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigationHelper.navigateToPage(
                                context, const NotificationsScreen());
                          },
                          child: NotificationWidget(
                            icon: Icons.notifications,
                            notificationCount: notification.notify.length,
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
                    Container(
                      color: Colors.white54,
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Modals.showBottomSheetModal(context,
                                    page: CountryListWidget(
                                      countries: countries,
                                    ),
                                    heightFactor: 1,
                                    isScrollControlled: true);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_sharp,
                                    color: AppColors.lightSecondary,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${user.address.capitalizeFirstOfEach}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
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
                            TextEditView(
                              controller: searchController,
                              hintText: 'Search your service here...',
                              filled: false,
                              autofocus: false,
                              borderWidth: 2,
                              isDense: true,
                              onTap: () {
                                AppNavigator.pushAndStackPage(context,
                                    page: SearchPage(
                                      postsLists: [
                                        'Clothes',
                                        'Television',
                                        'Washing Machine',
                                        'Laptops',
                                        'Watches'
                                      ],
                                    ));
                              },
                              borderColor: AppColors.lightPrimary,
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Services',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                                GestureDetector(
                                  onTap: () {
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
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              child: Row(
                                children: [
                                  ServiceBoard(
                                    title: 'Cleaning',
                                    asset: 'assets/images/cleaning.png',
                                    onPressed: () {
                                      AppNavigator.pushAndStackPage(context,
                                          page: AdsCategory(
                                            category: 'Cleaning',
                                          ));
                                    },
                                  ),
                                  SizedBox(width: 20),
                                  ServiceBoard(
                                    title: 'Beauty',
                                    asset: 'assets/images/beauty.png',
                                    onPressed: () {
                                      AppNavigator.pushAndStackPage(context,
                                          page: AdsCategory(
                                            category: 'Beauty',
                                          ));
                                    },
                                  ),
                                  SizedBox(width: 20),
                                  ServiceBoard(
                                    title: 'AC Repair',
                                    asset: 'assets/images/repair.png',
                                    onPressed: () {
                                      AppNavigator.pushAndStackPage(context,
                                          page: AdsCategory(
                                            category: 'AC Repair',
                                          ));
                                    },
                                  ),
                                  SizedBox(width: 20),
                                  ServiceBoard(
                                    title: 'Salon',
                                    asset: 'assets/images/salon.png',
                                    onPressed: () {
                                      AppNavigator.pushAndStackPage(context,
                                          page: AdsCategory(
                                            category: 'Salon',
                                          ));
                                    },
                                  ),
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
                                  return AnimatedItem(
                                      controller: _pageController,
                                      index: index,
                                      effect: const ScaleEffect(),
                                      child: promoView(index, context));
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
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    pageIndexProvider.changePageIndex(2);
                                  },
                                  child: const Text(
                                    'View all',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.lightSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
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
                                    color: isGridView
                                        ? AppColors.lightPrimary
                                        : Colors.black,
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
                                    color: isGridView
                                        ? Colors.black
                                        : AppColors.lightPrimary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            // Visibility(
                            //   visible: isGridView,
                            //   child: ServiceItem(
                            //     products: products,
                            //     onTapLike: (adId, isLiked) {
                            //       if(isLiked) {
                            //       unLikeAds(context, adId);

                            //       }else{
                            //       likeAds(context, adId);

                            //       }
                            //     }, isHome: true, isListView: false, isLoading: (state is RemoveLikeLoading || state is CreateLikeLoading), 
                            //   ),
                            // ),
                            // Visibility(
                            //   visible: !isGridView,
                            //   child: ServiceItem(
                            //     products: products,
                            //     onTapLike: (adId, isLiked) {
                            //       if(isLiked) {
                            //       unLikeAds(context, adId);

                            //       }else{
                            //       likeAds(context, adId);

                            //       }
                            //     }, isHome: true, isListView: true, isLoading: (state is RemoveLikeLoading || state is CreateLikeLoading),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  likeAds(BuildContext ctx, String adId) {
    ctx.read<UserCubit>().createLike(
          token: token,
          adId: adId,
        );
  }

 unLikeAds(BuildContext ctx, String adId) {
    ctx.read<UserCubit>().removeLike(
          token: token,
          adId: adId,
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
