import 'package:esalerz/model/service_contents.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
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
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      color: AppColors.lightSecondary.withOpacity(0.1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
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
                  SizedBox(height: 15),
                  //
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.lightSecondary.withOpacity(0.1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
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
                          title: 'Start chat',
                          textcolor: Colors.white,
                          backgroundcolor: AppColors.lightSecondary,
                          onpressed: () {},
                        ),
                      ],
                    ),
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
