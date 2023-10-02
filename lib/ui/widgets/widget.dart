import 'package:esalerz/model/service_contents.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
              fit: BoxFit.cover,
              color: AppColors.lightPrimary,
              width: 60,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SmallText(
          text: title,
          size: 16,
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

  const TrendingServiceModel({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                4, // Half of the container height
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Title and Like Icon Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallText(text: title),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Handle like button tap
                  },
                ),
              ],
            ),
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
    );
  }
}
