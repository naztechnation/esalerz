import 'dart:io';

import 'package:esalerz/model/user_model/notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../res/enum.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  ImagePicker picker = ImagePicker();

  File? imageURl;
  String _draftLength = "0";
  String _publishedLength = "0";
  int _activeTab = 0;

  List<NotificationsData> _notification = [];

  Future<void> setPublishedLength({required String publishedLength}) async {
    _publishedLength = publishedLength;
    setViewState(ViewState.success);
  }

  Future<void> setNotificationLength(
      {required List<NotificationsData> notification}) async {
    _notification = notification;
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

  Future<File> fileFromImageUrl(
    String imageUrl,
  ) async {
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

  

  
  String formatTimeAgo(String date) {
    final DateTime dateTime = DateTime.parse(date);
    final DateTime now = DateTime.now();
    final DateTime yesterday = now.subtract(Duration(days: 1));

    if (isSameDay(dateTime, now)) {
      return 'today';
    } else if (isSameDay(dateTime, yesterday)) {
      return 'yesterday';
    }

    final Duration difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }



  File? get imgURl => imageURl;

  String get publishedLength => _publishedLength;

  List<NotificationsData> get notification => _notification;

  List<NotificationsData> get notify =>
      notification.where((p) => p.isRead == '0').toList();
}
