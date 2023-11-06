import 'package:esalerz/model/chat/chatmodel.dart';
import 'package:esalerz/model/service_contents.dart';
import 'package:esalerz/model/service_term.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:esalerz/ui/widgets/customer_reviews.dart';
import 'package:esalerz/ui/widgets/dotindicator.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'widgets/button_view.dart';

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
          'Product Services',
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
                            Text(  'Awka, Ngozika estate'),
                          ],
                        ),
                        const SizedBox(height: 5),
                        BigText(
                          text: 'General Fumigation and Cleaning',
                          size: 15,
                        ),
                        const SizedBox(height: 5),
                         Text(
                           "N15,000",
                           style: TextStyle(color: Colors.green,),
                          
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                         Text(  'Start Esalerz chat with seller'),
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
                          title:  Text(
                             'COMPANY NAME',
                             style: TextStyle(
                            fontWeight: FontWeight.bold,

                             ),
                          ),
                          subtitle: Text( serviceTerm.companyName),
                        ),
                        ListTile(
                          minVerticalPadding: 3,
                          minLeadingWidth: 4,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title:  Text(
                              'FUMIGATION SERVICE INCLUDE',
                              style: TextStyle(
                            fontWeight: FontWeight.bold,

                              ),
                          ),
                          subtitle: Text(  serviceTerm.service),
                        ),
                        ListTile(
                          minVerticalPadding: 3,
                          minLeadingWidth: 4,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title:  Text(
                             'FREQUENCY',
                             style: TextStyle(
                            fontWeight: FontWeight.bold,

                             ),
                          ),
                          subtitle:  Text(  serviceTerm.frequency),
                        ),
                        ListTile(
                          minVerticalPadding: 3,
                          minLeadingWidth: 4,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title:  Text(
                              'ROUND THE CLOCK SERVICE',
                              style: TextStyle(
                            fontWeight: FontWeight.bold,

                              ),
                          ),
                          subtitle:  Text(  serviceTerm.roundTheClock),
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
                          subtitle: Text(  serviceTerm.type),
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
                          subtitle:  Text( serviceTerm.serviceArea),
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
                          subtitle: Text(  serviceTerm.workExperience),
                        ),
                        ListTile(
                          minVerticalPadding: 3,
                          minLeadingWidth: 4,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title:  Text(
                             'PROVIDE REGULAR SERVICE',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,

                              ),
                          ),
                          subtitle:  Text(  serviceTerm.regularService),
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
                                          context, const CustomerReviews());
                                          
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
