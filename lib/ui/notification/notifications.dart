import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user.dart';
import '../../../handlers/secure_handler.dart';
import '../../../res/app_images.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../model/user_model/notifications.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../widgets/loading_page.dart';
import 'notifications_details.dart';


class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: const Notifications(),
    );
  }
}
class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
bool showother =  false;

  late UserCubit _userCubit;

  String token = '';

  List<NotificationsData> notifications = [];

  getNotifications() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.createNotifications(token: token);
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final timeFormat = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is CreateNotifyLoaded) {
          if (state.notificationsInfo.status == 1) {
            notifications = state.notificationsInfo.data ?? [];
            setState(() {});
          } else {
            notifications = [];
          }
        }
      }, builder: (context, state) {
        if (state is UserNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.createNotifications(token: token),
          );
        } else if (state is UserNetworkErrApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.createNotifications(token: token),
          );
        }  

        return (state is CreateNotifyLoading )
            ? const LoadingPage()
            : Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Row(
                    children: [
                      ImageView.asset(
                        AppImages.icon,
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Esalerz',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
             const Padding(
               padding: EdgeInsets.symmetric(horizontal:16.0),
               child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Notifications',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                      ),
             ),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(children: [
                 
                  const SizedBox(
                    height: 10,
                  ),
                if(notifications.isEmpty)...[
                   SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Align(
                        //     alignment: Alignment.center,
                        //     child: ImageView.asset(AppImages.empty, height: 160,)),
                        SizedBox(height: 40.0),
                        Text(
                          "Empty",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          "You don’t have any notification at this time",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                ]else...[
                  ListView.builder(
                      itemCount: notifications.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: (){
                            AppNavigator.pushAndStackPage(context, page:  NotificationsDetails(notificationId: notifications[index].id ?? '1', bKey: token,));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration:   BoxDecoration(
                              color: (notifications[index].isRead == '0')? Colors.blueGrey.withOpacity(0.1) : Colors.white,
                              border:   Border(bottom: BorderSide(color: Colors.grey.shade300))),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child:   Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notifications[index].title!.toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 12.0),
                                  Text(
                                    notifications[index].message!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                    //  Text(
                                    //  timeFormat.getCurrentTime(notifications[index].createdAt!)  ,
                                    //  ),
                                     
                                       
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ]  
                 
                ]),
              ),
            )),
          ],
        );
  }),
    );
  }
}
