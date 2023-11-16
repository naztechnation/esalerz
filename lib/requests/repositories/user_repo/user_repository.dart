 
 
import '../../../model/user_model/all_products.dart';
import '../../../model/user_model/notification_details.dart';
import '../../../model/user_model/notifications.dart'; 
 

abstract class UserRepository {
     

     Future<NotificationsInfo> getAllNotifications({ required String token});
     Future<AllProducts> getAllProducts({ required String token});
     Future<AllProducts> getProductDetails({ required String token, required String adId});
     Future<NotificationsDetail> getDetailsNotifications({ required String token, required String id});
    


 }