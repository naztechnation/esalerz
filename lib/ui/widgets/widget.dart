import 'package:esalerz/model/service_contents.dart';
import 'package:esalerz/model/service_term.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/ui/widgets/smalltext.dart';
import 'package:flutter/material.dart';

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
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
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

//trending service model
class TrendingServiceModel extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
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
        padding: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity, // Takes full width
        child: Column(
          children: [
            // Image
            Container(
              height: MediaQuery.of(context).size.height /
                  5, // Half of the container height
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
            // Title and Like Icon Row
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    text: title,
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.favorite_border),
                  //   onPressed: () {
                  //     // Handle like button tap
                  //   },
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // Price and Rating Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$$price', // Assuming price is in dollars
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.lightPrimary),
                      Text(
                        '$rating',
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.lightPrimary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
      required this.onpressed});
  final VoidCallback onpressed;
  final String title;
  final Color textcolor;
  final Color backgroundcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Align(
          child: Text(
            title,
            style: TextStyle(
              color: textcolor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildServiceTermsGrid(List<ServiceTerm> terms) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // Two columns
      childAspectRatio: 2.0, // Adjust as needed
    ),
    itemCount: terms.length,
    itemBuilder: (context, index) {
      final term = terms[index];
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
            Text(
              term.companyName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              term.workExperienceHeading,
              style: TextStyle(color: Colors.blue),
            ),
            Text(
              term.subtitle,
            ),
          ],
        ),
      );
    },
  );
}
