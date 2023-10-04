import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerReviews extends StatefulWidget {
  const CustomerReviews({super.key});

  @override
  State<CustomerReviews> createState() => _CustomerReviewsState();
}

class _CustomerReviewsState extends State<CustomerReviews> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy/MM/dd').format(today);

    return Scaffold(
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
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildContainerWithListTile(
                    title: 'Chike',
                    subtitle: formattedDate,
                    rating: 2.5,
                    thirdLineText:
                        'Good customer service from the entire board',
                    onRatingChanged: (newRating) {
                      print('New rating: $newRating');
                    },
                  ),
                  const SizedBox(height: 10),
                  buildContainerWithListTile(
                    title: 'Timothy',
                    subtitle: formattedDate,
                    rating: 4,
                    thirdLineText:
                        'Good customer service from the entire board',
                    onRatingChanged: (newRating) {
                      print('New rating: $newRating');
                    },
                  ),
                  const SizedBox(height: 10),
                  buildContainerWithListTile(
                    title: 'Adaeze',
                    subtitle: formattedDate,
                    rating: 4,
                    thirdLineText:
                        'Good customer service from the entire board',
                    onRatingChanged: (newRating) {
                      print('New rating: $newRating');
                    },
                  ),
                  const SizedBox(height: 10),
                  buildContainerWithListTile(
                    title: 'Nwanneka',
                    subtitle: formattedDate,
                    rating: 1,
                    thirdLineText:
                        'Good customer service from the entire board',
                    onRatingChanged: (newRating) {
                      print('New rating: $newRating');
                    },
                  ),
                  const SizedBox(height: 10),
                  buildContainerWithListTile(
                    title: 'Promise',
                    subtitle: formattedDate,
                    rating: 4,
                    thirdLineText:
                        'Good customer service from the entire board',
                    onRatingChanged: (newRating) {
                      print('New rating: $newRating');
                    },
                  ),
                  const SizedBox(height: 10),
                  buildContainerWithListTile(
                    title: 'Chukwuemeka',
                    subtitle: formattedDate,
                    rating: 3.5,
                    thirdLineText:
                        'Good customer service from the entire board',
                    onRatingChanged: (newRating) {
                      print('New rating: $newRating');
                    },
                  ),
                  const SizedBox(height: 10),
                  buildContainerWithListTile(
                    title: 'Rambo44',
                    subtitle: formattedDate,
                    rating: 5,
                    thirdLineText:
                        'Good customer service from the entire board',
                    onRatingChanged: (newRating) {
                      print('New rating: $newRating');
                    },
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
