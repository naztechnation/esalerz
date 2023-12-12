import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/user_model/feedback_lists.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import 'empty_widget.dart';
import 'loading_page.dart';
import 'modals.dart';

class CustomerReviews extends StatelessWidget {
  final String adsId;
  const CustomerReviews({
    Key? key,
    this.adsId = '2',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: ReviewsPage(
        adsId: adsId,
      ),
    );
  }
}

class ReviewsPage extends StatefulWidget {
  final String adsId;

  const ReviewsPage({super.key, required this.adsId});

  @override
  State<ReviewsPage> createState() => _CustomerReviewsState();
}

class _CustomerReviewsState extends State<ReviewsPage> {
  DateTime today = DateTime.now();

  late UserCubit _userCubit;

  List<FeedbackData> reviews = [];

  String token = '';

  bool isLoading = false;

  getReviews() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    setState(() {
      isLoading = true;
    });

    await _userCubit.getFeedback(token: token, adId: widget.adsId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy/MM/dd').format(today);

    return BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
      if (state is GetFeedbackLoaded) {
        if (state.feedbacks.status == 1) {
          reviews = state.feedbacks.data ?? [];

          setState(() {});
        } else {
          reviews = [];
        }
      } else if (state is AddFeedbackLoaded) {
        Modals.showToast(state.products.message ?? '');
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

      return (isLoading || state is GetFeedbackLoading)
          ? Scaffold(body: const LoadingPage())
          : Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.cardColor,
                elevation: 0,
                title: const Text(
                  'Reviews',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child:
                          Icon(Icons.arrow_back, color: AppColors.lightPrimary),
                    ),
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
                      child: Icon(Icons.notifications_outlined,
                          color: AppColors.lightPrimary),
                    ),
                  ),
                ],
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
                    color: Colors.white70,
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                              itemCount: reviews.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return buildContainerWithListTile(
                                  title: reviews[index].fullName ?? '',
                                  subtitle: formattedDate,
                                  rating: double.parse(
                                      reviews[index].rating ?? '0.0'),
                                  thirdLineText: reviews[index].message ?? '',
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
