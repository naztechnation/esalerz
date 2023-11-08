 
import 'package:flutter/material.dart';
import '../../res/app_images.dart';


class LoadingPage extends StatelessWidget {
  final int length;
  const LoadingPage({this.length = 5, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
            color:Colors.white,),
        child:   Align(child: Image.asset(AppImages.loading, height: 100, width: 100,)),
      ),
    );
    
    }}