import 'dart:io';

import 'package:esalerz/model/auth_model/auth_user.dart';
import 'package:esalerz/model/user_model/all_products.dart';
import 'package:esalerz/model/user_model/all_services.dart';
import 'package:esalerz/model/user_model/categories_list.dart';
import 'package:esalerz/model/user_model/conversation_list.dart';
import 'package:esalerz/model/user_model/feedback_lists.dart';
import 'package:esalerz/model/user_model/message_list.dart';
import 'package:esalerz/model/user_model/services_sub_cat.dart';

import '../../../model/user_model/ads_options.dart';
import '../../../model/user_model/notification_details.dart';
import '../../../model/user_model/notifications.dart';
import '../../../res/app_strings.dart';
import '../../../ui/widgets/modals.dart';
import '../../setup/requests.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  @override
  Future<NotificationsInfo> getAllNotifications({required String token}) async {
    final map = await Requests().get(AppStrings.getNotifyUrl(token));

    return NotificationsInfo.fromJson(map);
  }

  @override
  Future<NotificationsDetail> getDetailsNotifications(
      {required String token, required String id}) async {
    final map = await Requests().get(AppStrings.getNotifyDetailsUrl(token, id));

    return NotificationsDetail.fromJson(map);
  }

  @override
  Future<AllProducts> getAllProducts({required String token}) async {
    final map = await Requests().get(AppStrings.getAllProductsUrl(token));

    return AllProducts.fromJson(map);
  }

  @override
  Future<AllProducts> getProductDetails(
      {required String token, required String adId}) async {
    final map =
        await Requests().get(AppStrings.getProductDetailsUrl(token, adId));

    return AllProducts.fromJson(map);
  }

  @override
  Future<AllProducts> sendFeedback(
      {required String token,
      required String message,
      required String adId,
      required String rating}) async {
    final map = await Requests().post(AppStrings.createFeedbackUrl, body: {
      'bkey': token,
      'message': message,
      'ad_id': adId,
      'rating': rating,
    });

    return AllProducts.fromJson(map);
  }

  @override
  Future<FeedbackList> getFeedbacks(
      {required String token, required String adId}) async {
    final map = await Requests().get(AppStrings.getFeedbackUrl(token, adId));

    return FeedbackList.fromJson(map);
  }

  @override
  Future<AllProducts> createLike(
      {required String token, required String adId}) async {
    final map = await Requests().post(AppStrings.likePost, body: {
      'bkey': token,
      'ad_id': adId,
    });

    return AllProducts.fromJson(map);
  }

  @override
  Future<AllProducts> removeLike(
      {required String token, required String adId}) async {
    final map = await Requests().get(AppStrings.unLikePost(token, adId));

    return AllProducts.fromJson(map);
  }

  @override
  Future<AllProducts> sendReport(
      {required String token,
      required String reason,
      required String adId}) async {
    final map = await Requests().post(AppStrings.reportAd, body: {
      'bkey': token,
      'ad_id': adId,
      'reason': reason,
    });

    return AllProducts.fromJson(map);
  }

  @override
  Future<AllProducts> saveProducts(
      {required String token,
      required String adId,
      required String url}) async {
    final map = await Requests().post(url, body: {
      'bkey': token,
      'ad_id': adId,
    });

    return AllProducts.fromJson(map);
  }

  @override
  Future<CategoriesList> getCategories({required String token}) async {
    final map = await Requests().get(AppStrings.getAllCategories(
      token,
    ));

    return CategoriesList.fromJson(map);
  }

  @override
  Future<CategoriesList> getSubCategories(
      {required String token, required String catId}) async {
    final map = await Requests().get(AppStrings.getSubCategories(token, catId));

    return CategoriesList.fromJson(map);
  }

  @override
  Future<AuthUser> sendChatMessage(
      {required String bkey,
      required String receiver,
      required String message}) async {
    final map = await Requests().post(AppStrings.sendChatUrl, body: {
      'bkey': bkey,
      'receiver': receiver,
      'message': message,
    });

    return AuthUser.fromJson(map);
  }

  @override
  Future<MessageList> getChatMessages(
      {required String bkey, required String receiver}) async {
    final map =
        await Requests().get(AppStrings.getChatMessages(bkey, receiver));

    return MessageList.fromJson(map);
  }

  @override
  Future<ConversationList> getConversations({
    required String bkey,
  }) async {
    final map = await Requests().get(AppStrings.getChatConversations(
      bkey,
    ));

    return ConversationList.fromJson(map);
  }

  @override
  Future<AllServices> getAllServices({required String bkey}) async {
    final map = await Requests().get(AppStrings.getAllServices(
      bkey,
    ));

    return AllServices.fromJson(map);
  }

  @override
  Future<ServicesSubCat> getServicesSubCat({
    required String bkey,
    required String serviceId,
  }) async {
    final map =
        await Requests().get(AppStrings.getServicesSubCat(bkey, serviceId));

    return ServicesSubCat.fromJson(map);
  }

  @override
  Future<AdsOptions> getAdsOptions(
      {required String bkey, required String adsId}) async {
    final map = await Requests().get(AppStrings.getAdsOptions(bkey, adsId));

    return AdsOptions.fromJson(map);
  }

  @override
  Future<AuthUser> uploadAds(
      {required List<AdsOptionsData> options,
      required File image,
      var controllers,
      var selectedValues,
      required String token}) async {
    Map<String, String> payload = {};

    

    for (var param in options) {
    if (param.paramType == 'textbox') {
      print('paramName: ${param.paramName}, paramValue: ${param.paramName}');
      String param1 = param.paramName?.split('-').first ?? '';


      String paramKey = param.paramName ?? '';

      String paramValue = controllers[paramKey]?.text;
      

      payload[param1] = paramValue; 
    }else if (param.paramType == 'select') {

      String param1 = param.paramName!.split('-').first;

      
      String paramKey = param.paramName ?? '';

      String selectedValue = selectedValues[paramKey] ?? '';

      payload[param1] = selectedValue;
    }
  }

    

   

    final map = await Requests().post(AppStrings.createPostAds,
        files: {
          'image[]': image,
        },
        body: payload);



    return AuthUser.fromJson(map);
  }
}
