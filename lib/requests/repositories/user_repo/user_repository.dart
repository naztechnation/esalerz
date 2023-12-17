 
 
import 'package:esalerz/model/auth_model/auth_user.dart';

import '../../../model/user_model/all_products.dart';
import '../../../model/user_model/all_services.dart';
import '../../../model/user_model/categories_list.dart';
import '../../../model/user_model/conversation_list.dart';
import '../../../model/user_model/feedback_lists.dart';
import '../../../model/user_model/message_list.dart';
import '../../../model/user_model/notification_details.dart';
import '../../../model/user_model/notifications.dart';
import '../../../model/user_model/services_sub_cat.dart'; 
 

abstract class UserRepository {
     

     Future<NotificationsInfo> getAllNotifications({ required String token});
     Future<AllProducts> getAllProducts({ required String token});
     Future<AllProducts> sendFeedback({ required String token, required String message,  required String adId,  required String rating,  });
     Future<AllProducts> sendReport({required String token, required String reason,  required String adId,    });
     Future<AllProducts> getProductDetails({ required String token, required String adId});
     Future<AllProducts> createLike({ required String token, required String adId});
     Future<AllProducts> removeLike({ required String token, required String adId});
     Future<AllProducts> saveProducts({ required String token, required String adId, required String url});
     Future<FeedbackList> getFeedbacks({ required String token, required String adId});
     Future<NotificationsDetail> getDetailsNotifications({ required String token, required String id});
     Future<CategoriesList> getCategories({ required String token,});
     Future<CategoriesList> getSubCategories({ required String token,required String catId,});
     Future<AuthUser> sendChatMessage({ required String bkey,required String receiver, required String message});
     Future<MessageList> getChatMessages({ required String bkey,required String receiver,  });
     Future<ConversationList> getConversations({ required String bkey, });
     Future<AllServices> getAllServices({ required String bkey, });
     Future<ServicesSubCat> getServicesSubCat({ required String bkey, required String serviceId, });
    


 }