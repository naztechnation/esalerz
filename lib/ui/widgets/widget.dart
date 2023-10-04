import 'package:esalerz/model/service_contents.dart';
import 'package:esalerz/model/service_term.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:esalerz/ui/widgets/category_selection.dart';
import 'package:esalerz/ui/widgets/smalltext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//service board
class ServiceBoard extends StatelessWidget {
  const ServiceBoard({super.key, required this.title, required this.asset});
  final String title;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 4,
                blurRadius: 5,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              asset,
              height: 50,
              fit: BoxFit.contain,
              color: AppColors.lightPrimary,
              width: 50,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SmallText(
          text: title,
          size: 13,
        ),
      ],
    );
  }
}

//promoview
Widget promoView(int index, BuildContext context) {
  return promoCard(
    datalist[index],
    () {
      // Use Navigator to push the corresponding route
      switch (index) {
        case 0:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Container()));
          break;
        case 1:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Container()));
          break;
        case 2:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Container()));
          break;
        case 3:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Container()));
          break;
        // Add more cases for additional cards
        default:
          break;
      }
    },
  );
}

//promocard

Widget promoCard(ServiceContents data, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
              image: AssetImage('assets/images/percent.jpg'),
              fit: BoxFit.cover)),
    ),
  );
}

//serviceview
Widget serviceView(int index, BuildContext context) {
  return servicecard(
    datalist[index],
    () {
      // Use Navigator to push the corresponding route
      switch (index) {
        case 0:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Container()));
          break;
        case 1:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Container()));
          break;
        case 2:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Container()));
          break;
        case 3:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Container()));
          break;
        // Add more cases for additional cards
        default:
          break;
      }
    },
  );
}

//servicescard
Widget servicecard(ServiceContents data, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
              image: AssetImage('assets/images/fumigation.jpeg'),
              fit: BoxFit.cover)),
    ),
  );
}

//trending service model
class TrendingServiceModel extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final double rating;
  final VoidCallback onPressed;

  const TrendingServiceModel({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              // Image
              Stack(
                children: [
                  Container(
                    height: 120, // Half of the container height
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                        color: AppColors.lightPrimary.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: SizedBox(
                      height: 42,
                      width: 42,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.favorite_border,
                            color: AppColors.lightSecondary,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Title and Like Icon Row
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '₦$price',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 16, color: AppColors.lightPrimary),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                '$rating',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.lightPrimary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//similar ads  model
class SimilarAdsModel extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final double rating;
  final VoidCallback onPressed;
  final bool isListView;

  const SimilarAdsModel({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
    required this.onPressed,
    required this.isListView, // Add a flag to determine the layout
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isListView) {
      // For List View layout
      return GestureDetector(
        onTap: onPressed,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            leading: Container(
              width: 80, // Adjust the width as needed
              height: 200, // Half of the container height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₦$price per service',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star,
                        size: 16, color: AppColors.lightPrimary),
                    const SizedBox(width: 3),
                    Text(
                      '$rating',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.lightPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: onPressed,
          ),
        ),
      );
    } else {
      // For Grid View layout (your existing code)
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                // Image
                Stack(
                  children: [
                    Container(
                      height: 120, // Half of the container height
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                          color: AppColors.lightPrimary.withOpacity(0.2),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: SizedBox(
                        height: 42,
                        width: 42,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.favorite_border,
                              color: AppColors.lightSecondary,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Title and Like Icon Row
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '₦$price',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    size: 16, color: AppColors.lightPrimary),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '$rating',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.lightPrimary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

//navigation helper
class NavigationHelper {
  static void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

//small button
class SmallButton extends StatelessWidget {
  const SmallButton(
      {super.key,
      required this.title,
      required this.bordercolor,
      required this.textcolor,
      required this.backgroundcolor,
      required this.onpressed});
  final VoidCallback onpressed;
  final String title;
  final Color bordercolor;
  final Color textcolor;
  final Color backgroundcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: bordercolor,
            width: 1.5,
          ),
        ),
        height: 40,
        //width: 80,
        child: Align(
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textcolor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//default button

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {super.key,
      required this.title,
      required this.textcolor,
      required this.backgroundcolor,
      required this.onpressed,
      required this.bordercolor});
  final VoidCallback onpressed;
  final String title;
  final Color textcolor;
  final Color backgroundcolor;
  final Color bordercolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: bordercolor,
          ),
        ),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Align(
          child: Text(
            title,
            style: TextStyle(
              color: textcolor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildContainerWithListTile({
  required String title,
  required String subtitle,
  required double rating,
  required String thirdLineText,
  required Function(double) onRatingChanged,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.lightSecondary.withOpacity(0.05),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/man.jpg'),
        backgroundColor: Colors.transparent,
        radius: 25,
      ),
      title: BigText(
        text: title,
        size: 15,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallText(
            text: subtitle,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          SmallText(
            text: thirdLineText,
            color: Colors.black54,
          ),
        ],
      ),
      trailing: RatingBar.builder(
        initialRating: rating,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 16.0,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: onRatingChanged,
      ),
      isThreeLine: true,
      dense: true,
      contentPadding: const EdgeInsets.all(8.0),
      onTap: () {},
      tileColor: Colors.grey[100],
      subtitleTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}

//expandable container
class ExpandableContainer extends StatefulWidget {
  final String heading;
  final IconData icon;
  final String address;

  ExpandableContainer({
    required this.heading,
    required this.icon,
    required this.address,
  });

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.lightSecondary.withOpacity(0.03),
      ),
      child: ListTile(
        leading: Icon(widget.icon),
        title: Row(
          children: [
            Expanded(
                child: SmallText(
              text: widget.heading,
              fontWeight: FontWeight.bold,
            )),
            Text(
              _expanded ? 'Hide' : 'Show',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.lightPrimary, // Set the desired color
              ),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        subtitle: _expanded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SmallText(
                    text: widget.address,
                    size: 13,
                  ),
                ],
              )
            : null, // Show subtitle only when expanded
      ),
    );
  }
}
