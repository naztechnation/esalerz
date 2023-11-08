 
  

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

 

  
}