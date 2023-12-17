import 'package:esalerz/model/user_model/categories_list.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_images.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../widgets/loading_page.dart';
import '../widgets/text_edit_view.dart';

class AdsCategory extends StatelessWidget {
  const AdsCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: CategoriesScreen(),
    );
  }
}

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({
    super.key,
  });

  @override
  State<CategoriesScreen> createState() => _ServicesCategoryState();
}

class _ServicesCategoryState extends State<CategoriesScreen> {
  final searchController = TextEditingController();

  final PageController _pageController = PageController();
  int selectedIndex = 0;

  late UserCubit _userCubit;

  String token = '';

  List<CategoriesData> categories = [];
  List<CategoriesData> subcategory = [];

  getCategories() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.getCategories(token: token);
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
      if (state is CategoriesLoaded) {
        if (state.categoriesList.status == 1) {
          categories = state.categoriesList.data ?? [];
          setState(() {});
        } else {
          categories = [];
        }
      } else if (state is SubCategoriesLoaded) {
        if (state.categoriesList.status == 1) {
          subcategory = state.categoriesList.data ?? [];
           
            selectedIndex = 1;
          
          Future.delayed(Duration(milliseconds: 100), (){
            _pageController.animateToPage(
            1,
            duration: Duration(milliseconds: 700),
            curve: Curves.ease,
          );
          });
         
        } else {
          subcategory = [];
        }
      }
    }, builder: (context, state) {
      if (state is UserNetworkErr) {
        selectedIndex = 0;
        return EmptyWidget(
          title: 'Network error',
          description: state.message,
            context: context,

          onRefresh: () => _userCubit.getCategories(token: token),
        );
      } else if (state is UserNetworkErrApiErr) {
        selectedIndex = 0;
        return EmptyWidget(
          title: 'Network error',
          description: state.message,
            context: context,

          onRefresh: () => _userCubit.getCategories(token: token),
        );
      }

      return (state is SubCategoriesLoading || state is CategoriesLoading)
          ? Scaffold(body: const LoadingPage())
          : Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.cardColor,
                elevation: 0,
                automaticallyImplyLeading: false,
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
                      'Ads Category',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: AppColors.lightPrimary,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  if (selectedIndex == 0) ...[
                    Container(
                      padding:
                          const EdgeInsets.only(top: 30, left: 14, right: 14),
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
                  ] else ...[
                    Container(
                      padding:
                          const EdgeInsets.only(top: 30, left: 14, right: 14),
                      height: 110,
                      color: AppColors.lightPrimary,
                      child: TextEditView(
                        controller: searchController,
                        hintText: 'Search subcategory...',
                        filled: true,
                        autofocus: false,
                        isDense: true,
                        fillColor: Colors.white,
                        borderColor: AppColors.lightPrimary,
                        prefixIcon: GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              0,
                              duration: Duration(milliseconds: 700),
                              curve: Curves.ease,
                            );
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                  const Divider(
                    height: 0,
                    thickness: 1.0,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _pageController,
                              children: [
                                ListView.separated(
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
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: ImageView.network(
                                          categories[index].categIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      title: Text(
                                          categories[index].categName ?? ''),
                                      trailing: const Icon(
                                          Icons.keyboard_arrow_right,
                                          color: AppColors.lightPrimary),
                                      onTap: () {
                                        _userCubit.getSubCategories(
                                            token: token,
                                            catId: categories[index].id ?? '');
                                      },
                                    );
                                  },
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: subcategory.length,
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      thickness: 1.0,
                                      height: 0,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: ImageView.network(
                                            subcategory[index].categIcon,
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      title: Text(
                                          subcategory[index].categName ?? ''),
                                      trailing: const Icon(
                                          Icons.keyboard_arrow_right,
                                          color: AppColors.lightPrimary),
                                      onTap: () {},
                                    );
                                  },
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
