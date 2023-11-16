 
  

import 'package:esalerz/model/user_model/all_products.dart';
import 'package:esalerz/model/user_model/feedback_lists.dart';

import '../../../model/user_model/notification_details.dart';
import '../../../model/user_model/notifications.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
 

  @override
  Future<NotificationsInfo> getAllNotifications({ required String token}) async {
    final map = await Requests().get(AppStrings.getNotifyUrl(token));

    return NotificationsInfo.fromJson(map);
  }

  @override
  Future<NotificationsDetail> getDetailsNotifications({required String token, required String id}) async {
    final map = await Requests().get(AppStrings.getNotifyDetailsUrl(token, id));

    return NotificationsDetail.fromJson(map);
  }

  @override
  Future<AllProducts> getAllProducts({required String token})  async {
    final map = await Requests().get(AppStrings.getAllProductsUrl(token));

    return AllProducts.fromJson(map);
  }
  
  @override
  Future<AllProducts> getProductDetails({required String token, required String adId}) async {
    final map = await Requests().get(AppStrings.getProductDetailsUrl(token, adId));

    return AllProducts.fromJson(map);
  }
  
  @override
  Future<AllProducts> sendFeedback({required String token, required String message,
   required String adId, required String rating}) async {
    final map = await Requests().post(AppStrings.createFeedbackUrl, body: {
      'bkey' : token,
      'message' : message,
      'ad_id' : adId,
      'rating' : rating,

    });

    return AllProducts.fromJson(map);
  }

  @override
  Future<FeedbackList> getFeedbacks({required String token, required String adId})  async {
    final map = await Requests().get(AppStrings.getFeedbackUrl(token, adId));

    return FeedbackList.fromJson(map);
  }

  
}