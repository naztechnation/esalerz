import 'package:esalerz/model/chat/chatmodel.dart';
import 'package:esalerz/model/service_contents.dart';
import 'package:esalerz/model/service_term.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:esalerz/ui/widgets/chat_screen.dart';
import 'package:esalerz/ui/widgets/customer_reviews.dart';
import 'package:esalerz/ui/widgets/dotindicator.dart';
import 'package:esalerz/ui/widgets/smalltext.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';

class UserServiceInfo extends StatefulWidget {
  const UserServiceInfo({super.key});

  @override
  State<UserServiceInfo> createState() => _UserServiceInfoState();
}

class _UserServiceInfoState extends State<UserServiceInfo> {
  final messageController = TextEditingController();
  late PageController _pageController;
  int _currentPage = 0;
  bool isGridView = true;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        elevation: 0,
        title: const Text(
          'Services',
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
              child: Icon(Icons.arrow_back, color: AppColors.lightPrimary),
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
              child:
                  Icon(Icons.more_vert_rounded, color: AppColors.lightPrimary),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.5,
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
                        return serviceView(index, context);
                      },
                    ),
                  ),
                  DotIndicator(
                    itemCount: datalist.length,
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
                            SmallText(text: 'Awka, Ngozika estate'),
                          ],
                        ),
                        const SizedBox(height: 5),
                        BigText(
                          text: 'General Fumigation and Cleaning',
                          size: 15,
                        ),
                        const SizedBox(height: 5),
                        SmallText(
                          text: "N15,000",
                          color: Colors.green,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallButton(
                              title: 'Request call back',
                              bordercolor: AppColors.lightPrimary,
                              textcolor: AppColors.lightPrimary,
                              backgroundcolor: Colors.white,
                              onpressed: () {},
                            ),
                            SmallButton(
                              title: 'Call',
                              bordercolor: AppColors.lightPrimary,
                              textcolor: Colors.white,
                              backgroundcolor: AppColors.lightPrimary,
                              onpressed: () {},
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
                        SmallText(text: 'Start Esalerz chat with seller'),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallButton(
                              title: 'Make an offer',
                              bordercolor: AppColors.lightPrimary,
                              textcolor: AppColors.lightPrimary,
                              backgroundcolor: Colors.white,
                              onpressed: () {},
                            ),
                            SmallButton(
                              title: 'Is this available',
                              bordercolor: AppColors.lightPrimary,
                              textcolor: AppColors.lightPrimary,
                              backgroundcolor: Colors.white,
                              onpressed: () {},
                            ),
                            SmallButton(
                              title: 'Last price',
                              bordercolor: AppColors.lightPrimary,
                              textcolor: AppColors.lightPrimary,
                              backgroundcolor: Colors.white,
                              onpressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextEditView(
                          borderWidth: 0.5,
                          controller: messageController,
                          hintText: 'Write your message here',
                          filled: false,
                          autofocus: false,
                          isDense: true,
                          borderColor: AppColors.lightPrimary,
                        ),
                        const SizedBox(height: 10),
                        DefaultButton(
                          bordercolor: AppColors.lightSecondary,
                          title: 'Start chat',
                          textcolor: Colors.white,
                          backgroundcolor: AppColors.lightSecondary,
                          onpressed: () {
                            final initialMessages = [
                              ChatMessage(
                                  text: messageController.text,
                                  timestamp: DateTime.now(),
                                  isMe: true)
                            ];
                            NavigationHelper.navigateToPage(
                              context,
                              ChatScreen(
                                  initialMessages:
                                      initialMessages), // Pass initial messages
                            );
                          },
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
                          title: SmallText(
                            text: 'COMPANY NAME',
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: SmallText(text: serviceTerm.companyName),
                        ),
                        ListTile(
                          minVerticalPadding: 3,
                          minLeadingWidth: 4,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title: SmallText(
                            text: 'FUMIGATION SERVICE INCLUDE',
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: SmallText(text: serviceTerm.service),
                        ),
                        ListTile(
                          minVerticalPadding: 3,
                          minLeadingWidth: 4,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title: SmallText(
                            text: 'FREQUENCY',
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: SmallText(text: serviceTerm.frequency),
                        ),
                        ListTile(
                          minVerticalPadding: 3,
                          minLeadingWidth: 4,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title: SmallText(
                            text: 'ROUND THE CLOCK SERVICE',
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: SmallText(text: serviceTerm.roundTheClock),
                        ),
                        ListTile(
                          minVerticalPadding: 3,
                          minLeadingWidth: 4,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title: SmallText(
                            text: 'FUMIGATION TYPE',
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: SmallText(text: serviceTerm.type),
                        ),
                        ListTile(
                          minVerticalPadding: 3,
                          minLeadingWidth: 4,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title: SmallText(
                            text: 'SERVICE AREA',
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: SmallText(text: serviceTerm.serviceArea),
                        ),
                        ListTile(
                          minVerticalPadding: 3,
                          minLeadingWidth: 4,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title: SmallText(
                            text: 'WORK EXPERIENCE',
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: SmallText(text: serviceTerm.workExperience),
                        ),
                        ListTile(
                          minVerticalPadding: 3,
                          minLeadingWidth: 4,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title: SmallText(
                            text: 'PROVIDE REGULAR SERVICE',
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: SmallText(text: serviceTerm.regularService),
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
                        SmallText(
                          text:
                              "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                        ),
                        const SizedBox(height: 15),
                        DefaultButton(
                          bordercolor: AppColors.lightPrimary,
                          title: 'Make an offer',
                          textcolor: AppColors.lightPrimary,
                          backgroundcolor: Colors.white,
                          onpressed: () {},
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
                          subtitle: SmallText(
                            text: 'online 57 min ago',
                            size: 12,
                          ),
                          trailing: SmallText(
                            text: 'View ad',
                            color: AppColors.lightPrimary,
                          ),
                        ),
                        //
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.cardColor),
                              child: Column(
                                children: [
                                  ListTile(
                                    minVerticalPadding: 3,
                                    minLeadingWidth: 4,
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 1, vertical: 1),
                                    leading: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/man.jpg'),
                                      radius: 15,
                                      backgroundColor: Colors.transparent,
                                    ),
                                    title: BigText(
                                      text: 'Chukwuemeka',
                                      size: 16,
                                    ),
                                    subtitle: SmallText(
                                      text:
                                          'Fantastic customer support and service',
                                      size: 12,
                                    ),
                                    trailing: const Icon(
                                      Icons.tag_faces,
                                      color: AppColors.lightPrimary,
                                    ),
                                  ),
                                  DefaultButton(
                                    title: 'See more reviews',
                                    bordercolor: AppColors.lightPrimary,
                                    textcolor: AppColors.lightPrimary,
                                    backgroundcolor: Colors.white,
                                    onpressed: () {
                                      NavigationHelper.navigateToPage(
                                          context, const CustomerReviews());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DefaultButton(
                          title: 'Leave feedback',
                          textcolor: AppColors.lightSecondary,
                          backgroundcolor: Colors.white,
                          onpressed: () {},
                          bordercolor: AppColors.lightSecondary,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DefaultButton(
                          title: 'Report abuse',
                          textcolor: AppColors.red,
                          backgroundcolor: Colors.white,
                          onpressed: () {},
                          bordercolor: AppColors.red,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DefaultButton(
                          title: 'Post ad like this',
                          textcolor: AppColors.lightPrimary,
                          backgroundcolor: Colors.white,
                          onpressed: () {},
                          bordercolor: AppColors.lightPrimary,
                        ),
                      ],
                    ),
                  ),

                  //similar ads
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: 'Similar Ads',
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isGridView =
                                    !isGridView; // Toggle the view mode
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
                                isGridView =
                                    !isGridView; // Toggle the view mode
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
  }
}

ServiceTerm serviceTerm = serviceTerms[0];
String companyName = serviceTerm.companyName;
