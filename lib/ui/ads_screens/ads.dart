import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/user_model/all_products.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_colors.dart';
import '../widgets/empty_widget.dart';
import '../widgets/horizontal_selection.dart';
import '../widgets/loading_page.dart';
import '../widgets/text_edit_view.dart';


class Ads extends StatelessWidget {
  const Ads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child:   AdsScreen(),
    );
  }
}
class AdsScreen extends StatefulWidget {
  AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsState();
}

class _AdsState extends State<AdsScreen> {
  final searchController = TextEditingController();

  final List<String> items = [
    'All',
    'Laptops',
    'Home Appliances',
    'Phones',
    'Cars',
  ];

  bool isGridView = true;

   late UserCubit _userCubit;

  String token = '';

  List<ProductsData> products = [];


  getProducts() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.getProducts(token: token);
    
    

  }

  @override
  void initState() {
    super.initState();
    getProducts();

  }

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
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
          if (state is ProductsLoaded) {
          if (state.products.status == 1) {
            products = state.products.data ?? [];
            setState(() {});
          } else {
            products = [];
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
            description: state.message,
            context: context,

            onRefresh: () => _userCubit.getProducts(token: token),
          );
        }  

        return ( state is  ProductsLoading)
            ? const LoadingPage()
            : Column(
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
                        child: buildMasonryGridView1(products: products, isHome: false, onTapLike: (){}),
                      ),
                      Visibility(
                        visible: !isGridView,
                        child: buildListView1(products: products),
                      ),
                  ],
                ),
              ),
            ),
           
             
          ],
        );
   } ),
    );
  }
}
