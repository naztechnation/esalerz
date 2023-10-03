import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class HorizontalCardList extends StatefulWidget {
  final List<String> items;
  const HorizontalCardList({super.key, required this.items});

  @override
  _HorizontalCardListState createState() => _HorizontalCardListState();
}

class _HorizontalCardListState extends State<HorizontalCardList> {
  int selectedIndex = 0; 

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;  
              });
            },
            child: Card(
              shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
              color: selectedIndex == index ? AppColors.lightPrimary : Colors.white,
              child: Container(
                width: 130.0,
                height: 100.0,
                alignment: Alignment.center,
                child: Text(
                  widget.items[index],
                  style:   TextStyle(
                    fontSize: 13.0,
                    color: selectedIndex == index ? Colors.white :  AppColors.lightPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}