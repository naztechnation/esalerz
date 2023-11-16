import 'package:esalerz/extentions/custom_string_extension.dart';
import 'package:esalerz/model/chat/chatmodel.dart';
import 'package:esalerz/model/service_term.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:esalerz/ui/widgets/customer_reviews.dart';
import 'package:esalerz/ui/widgets/dotindicator.dart';
import 'package:esalerz/ui/widgets/modals.dart';
import 'package:esalerz/ui/widgets/ratings.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/user_model/all_products.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_strings.dart';
import '../../utils/validator.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../widgets/loading_page.dart';

class UserServiceInfo extends StatelessWidget {
  final String adsId;
  const UserServiceInfo({
    Key? key,
    this.adsId = '2',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: UserInfo(
        adsId: adsId,
      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  final String adsId;
  const UserInfo({
    Key? key,
    required this.adsId,
  }) : super(key: key);
  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final messageController = TextEditingController();
  late PageController _pageController;
  int _currentPage = 0;
  bool isGridView = true;

  late UserCubit _userCubit;

  int ratingNumber = 0;

  String token = '';

  List<ProductsData> products = [];

  List<String> Images = [];

  bool isLoading = false;

  final commentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  getProducts() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    setState(() {
      isLoading = true;
    });

    await _userCubit.getProductDetails(token: token, adId: widget.adsId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getProducts();

    _pageController = PageController(
      initialPage: _currentPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
      if (state is ProductsDetailsLoaded) {
        if (state.products.status == 1) {
          products = state.products.data ?? [];
          List<String> files = state.products.data?[0].file ?? [];

          for (String imgUrl in files) {
            Images.add(imgUrl);
          }

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
          onRefresh: () => _userCubit.getProducts(token: token),
        );
      } else if (state is UserNetworkErrApiErr) {
        return EmptyWidget(
          title: 'Network error',
          description: state.message,
          onRefresh: () => _userCubit.getProducts(token: token),
        );
      }

      return (isLoading)
          ? Scaffold(body: const LoadingPage())
          : Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.cardColor,
                elevation: 0,
                title: Text(
                  products.first.category ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.black),
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
                      child: Icon(Icons.bookmark_border_outlined,
                          color: AppColors.lightPrimary),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Icon(Icons.more_vert_rounded,
                          color: AppColors.lightPrimary),
                    ),
                  ),
                ],
              ),
              body: Stack(
                children: [
                  Container(
                    color: Colors.white70,
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1.7,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: PageView.builder(
                                itemCount: Images.length,
                                physics: const BouncingScrollPhysics(),
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentPage = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: ImageView.network(
                                        Images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DotIndicator(
                            itemCount: Images.length,
                            currentIndex: _currentPage,
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.lightSecondary.withOpacity(0.03),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_on),
                                    Text('Awka, Ngozika estate'),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                BigText(
                                  text: products.first.title ?? '',
                                  size: 15,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "N15,000",
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: ButtonView(
                                        onPressed: () {},
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 0),
                                        color: Colors.white,
                                        borderColor: AppColors.lightPrimary,
                                        expanded: false,
                                        child: const Text(
                                          'Request call back',
                                          style: TextStyle(
                                            color: AppColors.lightPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: ButtonView(
                                        onPressed: () {},
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        color: AppColors.lightPrimary,
                                        borderColor: Colors.white,
                                        expanded: false,
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.call,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Call',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          //
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.lightSecondary.withOpacity(0.03),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Start Esalerz chat with seller'),
                                const SizedBox(height: 5),
                                Wrap(
                                  children: [
                                    ButtonView(
                                      onPressed: () {},
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      borderColor: AppColors.lightPrimary,
                                      expanded: false,
                                      child: const Text(
                                        'Make an offer',
                                        style: TextStyle(
                                          color: AppColors.lightPrimary,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    ButtonView(
                                      onPressed: () {},
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      color: Colors.white,
                                      borderColor: AppColors.lightPrimary,
                                      expanded: false,
                                      child: const Text(
                                        'Is this available',
                                        style: TextStyle(
                                          color: AppColors.lightPrimary,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    ButtonView(
                                      onPressed: () {},
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      color: Colors.white,
                                      borderColor: AppColors.lightPrimary,
                                      expanded: false,
                                      child: const Text(
                                        'Last price',
                                        style: TextStyle(
                                          color: AppColors.lightPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                TextEditView(
                                  borderWidth: 0.5,
                                  controller: messageController,
                                  hintText: 'Write your message here',
                                  filled: false,
                                  autofocus: false,
                                  isDense: true,
                                  borderColor: AppColors.lightPrimary,
                                ),
                                const SizedBox(height: 25),
                                ButtonView(
                                  onPressed: () {
                                    final initialMessages = [
                                      ChatMessage(
                                          text: messageController.text,
                                          timestamp: DateTime.now(),
                                          isMe: true)
                                    ];

                                    //   NavigationHelper.navigateToPage(
                                    //     context,
                                    //  //   ChatScreen(initialMessages: initialMessages),
                                    //   );
                                  },
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 14),
                                  color: AppColors.lightPrimary,
                                  borderColor: Colors.white,
                                  expanded: true,
                                  child: const Text(
                                    'Start Chat',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          //
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.lightSecondary.withOpacity(0.03),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  minVerticalPadding: 3,
                                  minLeadingWidth: 4,
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1),
                                  title: Text(
                                    'COMPANY NAME',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(serviceTerm.companyName),
                                ),
                                ListTile(
                                  minVerticalPadding: 3,
                                  minLeadingWidth: 4,
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1),
                                  title: Text(
                                    'FUMIGATION SERVICE INCLUDE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(serviceTerm.service),
                                ),
                                ListTile(
                                  minVerticalPadding: 3,
                                  minLeadingWidth: 4,
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1),
                                  title: Text(
                                    'FREQUENCY',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(serviceTerm.frequency),
                                ),
                                ListTile(
                                  minVerticalPadding: 3,
                                  minLeadingWidth: 4,
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1),
                                  title: Text(
                                    'ROUND THE CLOCK SERVICE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(serviceTerm.roundTheClock),
                                ),
                                ListTile(
                                  minVerticalPadding: 3,
                                  minLeadingWidth: 4,
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1),
                                  title: Text(
                                    'FUMIGATION TYPE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(serviceTerm.type),
                                ),
                                ListTile(
                                  minVerticalPadding: 3,
                                  minLeadingWidth: 4,
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1),
                                  title: Text(
                                    'SERVICE AREA',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(serviceTerm.serviceArea),
                                ),
                                ListTile(
                                  minVerticalPadding: 3,
                                  minLeadingWidth: 4,
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1),
                                  title: Text(
                                    'WORK EXPERIENCE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(serviceTerm.workExperience),
                                ),
                                ListTile(
                                  minVerticalPadding: 3,
                                  minLeadingWidth: 4,
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1),
                                  title: Text(
                                    'PROVIDE REGULAR SERVICE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(serviceTerm.regularService),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          //
                          ExpandableContainer(
                            heading: 'Store Adress',
                            icon: Icons.storefront_outlined,
                            address:
                                'No. 28 Ngozika estate, awka Anambra state Nigeria',
                          ),
                          const SizedBox(height: 15),

                          //
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.lightSecondary.withOpacity(0.03),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                                ),
                                const SizedBox(height: 15),
                                ButtonView(
                                  onPressed: () {},
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  borderRadius: 5,
                                  borderWidth: 1,
                                  borderColor: AppColors.lightPrimary,
                                  child: const Text(
                                    'Make an offer',
                                    style: TextStyle(
                                      color: AppColors.lightPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 15),
                          //
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.lightSecondary.withOpacity(0.03),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  minVerticalPadding: 3,
                                  minLeadingWidth: 4,
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey,
                                    child: BigText(
                                      text: 'C',
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: BigText(
                                    text: 'Drago119',
                                    size: 16,
                                  ),
                                  subtitle: Text(
                                    'online 57 min ago',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  trailing: Text(
                                    'View ad',
                                    style: TextStyle(
                                      color: AppColors.lightPrimary,
                                    ),
                                  ),
                                ),
                                //
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.cardColor),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            minVerticalPadding: 3,
                                            minLeadingWidth: 4,
                                            dense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 1, vertical: 1),
                                            leading: const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/images/man.jpg'),
                                              radius: 15,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            title: BigText(
                                              text: 'Chukwuemeka',
                                              size: 16,
                                            ),
                                            subtitle: Text(
                                              'Fantastic customer support and service',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            trailing: const Icon(
                                              Icons.tag_faces,
                                              color: AppColors.lightPrimary,
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          ButtonView(
                                            onPressed: () {
                                              NavigationHelper.navigateToPage(
                                                  context,
                                                  const CustomerReviews());
                                            },
                                            color: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            borderRadius: 5,
                                            borderWidth: 1,
                                            borderColor: AppColors.lightPrimary,
                                            child: const Text(
                                              'See more reviews',
                                              style: TextStyle(
                                                color: AppColors.lightPrimary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                ButtonView(
                                  onPressed: () {
                                    Modals.showBottomSheetModal(context,
                                        isDissmissible: true,
                                        heightFactor: 1,
                                        page: Ratings(
                                            ctxt: context,
                                            username: 'Buyer',
                                            agentName:
                                                'Seller',
                                            agentId:
                                                // widget.agents?.id.toString() ??
                                                    ''));
                                  },
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  borderRadius: 5,
                                  borderWidth: 1,
                                  borderColor: AppColors.lightSecondary,
                                  child: const Text(
                                    'Leave feedback',
                                    style: TextStyle(
                                      color: AppColors.lightSecondary,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                ButtonView(
                                  onPressed: () {
                                    NavigationHelper.navigateToPage(
                                        context, const CustomerReviews());
                                  },
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  borderRadius: 5,
                                  borderWidth: 1,
                                  borderColor: AppColors.lightSecondary,
                                  child: const Text(
                                    'Report abuse',
                                    style: TextStyle(
                                      color: AppColors.lightSecondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ButtonView(
                                  onPressed: () {
                                    NavigationHelper.navigateToPage(
                                        context, const CustomerReviews());
                                  },
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  borderRadius: 5,
                                  borderWidth: 1,
                                  borderColor: AppColors.lightPrimary,
                                  child: const Text(
                                    'Post ads like this',
                                    style: TextStyle(
                                      color: AppColors.lightPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //similar ads
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Similar Ads',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isGridView = !isGridView;
                                      });
                                    },
                                    icon: Image.asset(
                                      'assets/images/grid.png',
                                      height: 20,
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
                                      height: 20,
                                      color: isGridView
                                          ? Colors.black
                                          : AppColors.lightPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Visibility(
                            visible: isGridView,
                            child: buildMasonryGridView(),
                          ),
                          Visibility(
                            visible: !isGridView,
                            child: buildListView(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }

  Ratings({
    required String username,
    required BuildContext ctxt,
    required String agentName,
    required String agentId,
  }) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rate this ${agentName.capitalizeFirstOfEach}\'s Services',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              RatingView(
                rating: ratingNumber,
                size: 30,
                onSelected: (value) {
                  setState((() {
                    ratingNumber = value + 1;
                  }));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: TextEditView(
                  controller: commentController,
                  validator: (value) {
                    return Validator.validate(value,);
                  },
                  isDense: true,
                  textViewTitle: 'Write a review',
                  hintText: 'Enter comment',
                  borderWidth: 0.5,
                  fillColor: Colors.white,
                  borderColor: Color.fromARGB(255, 41, 12, 12),
                  borderRadius: 30,
                  onChanged: ((value) {
                    setState(() {});
                  }),
                  maxLines: 6,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
             
              const SizedBox(
                height: 20,
              ),
              // if (commentController.text.isNotEmpty)
                ButtonView(
                  //  processing: isProcessing,
                  onPressed: () {
                    setState(() {});
                    // _postProductReviews(
                    //   ctx: ctxt,
                    //   username: username,
                    //   agentId: widget.agents?.id.toString() ?? "",
                    //   rating: ratingNumber.toString(),
                    //   comment: commentController.text,
                    // );
                  },
                  color: AppColors.lightSecondary,
                  borderRadius: 30,
                  borderColor: AppColors.lightSecondary,
                  child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Submit',
                    weight: FontWeight.w400,
                    size: 16,
                    fontFamily: AppStrings.interSans,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

ServiceTerm serviceTerm = serviceTerms[0];
String companyName = serviceTerm.companyName;
