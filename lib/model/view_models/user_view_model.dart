import 'dart:io';
 
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../res/app_colors.dart';
import '../../res/enum.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  ImagePicker picker = ImagePicker();

  File? imageURl;
  String _draftLength = "0";
  String _publishedLength = "0";
  int _activeTab  = 0;

  

  Future<void> setPublishedLength({required String publishedLength}) async {
    _publishedLength = publishedLength;
    setViewState(ViewState.success);
  }

  Future<void> setDraftLength({required String draftedLength}) async {
    _draftLength = draftedLength;
    setViewState(ViewState.success);
  }

   Future<void> setTabIndex({required int tabIndex}) async {
    _activeTab = tabIndex;
    setViewState(ViewState.success);
  }

  Future<void> clearImage() async {
    imageURl = null;
    setViewState(ViewState.success);
  }

  Future<File> fileFromImageUrl(String imageUrl, ) async {
    String img = imageUrl;
    final response = await http.get(Uri.parse(img));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final String imageName = imageUrl.split('/').last;
        final file = File('${documentDirectory.path}/$imageName');

        await file.writeAsBytes(response.bodyBytes);

    imageURl = file;
    setViewState(ViewState.success);
    return file;
  }

 


  String getCurrentTime(int timestampInSeconds)   {
     
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);

      String time = formatTimeAgo(date);
    

        setViewState(ViewState.success);


    return time;
  }

 String formatTimeAgo(DateTime inputDate) {
   
    DateTime now = DateTime.now();
  Duration difference = now.difference(inputDate);

  if (difference.inDays >= 3) {
    return DateFormat.yMMMd().format(inputDate);
  } else if (difference.inDays >= 1) {
    if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${difference.inDays} days ago';
    }
  } else if (difference.inHours >= 1) {
    if (difference.inHours == 1) {
      return '1 hour ago';
    } else {
      return '${difference.inHours} hours ago';
    }
  } else if (difference.inMinutes >= 1) {
    if (difference.inMinutes == 1) {
      return '1 minute ago';
    } else {
      return '${difference.inMinutes} minutes ago';
    }
  } else {
    return 'Just now'; 
  }
}








  File? get imgURl => imageURl;

 
  String get publishedLength => _publishedLength;

  
}
