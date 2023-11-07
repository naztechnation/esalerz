import 'package:esalerz/res/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  final IconData icon;
  final int notificationCount;

  NotificationWidget({required this.icon, this.notificationCount = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 15),

      child: Stack(
        children: [
          Icon(icon, size: 35.0, color: AppColors.lightPrimary,),  
          if (notificationCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.red,  
                  borderRadius: BorderRadius.circular(30.0),
                ),
                constraints: BoxConstraints(
                  minWidth: 20,
                  minHeight: 18,
                ),
                child: Center(
                  child: Text(
                    notificationCount.toString(),
                    style: TextStyle(
                      color: Colors.white,  
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
