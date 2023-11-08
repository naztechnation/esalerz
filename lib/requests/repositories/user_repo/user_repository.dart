 
 
import '../../../model/user_model/notification_details.dart';
import '../../../model/user_model/notifications.dart'; 
 

abstract class UserRepository {
     

     Future<NotificationsInfo> getAllNotifications({ required String token});
     Future<NotificationsDetail> getDetailsNotifications({ required String token, required String id});
    


 }