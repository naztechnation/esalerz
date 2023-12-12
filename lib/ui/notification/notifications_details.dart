
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/user_view_model.dart';
import '../../../res/app_colors.dart';
import '../../blocs/user/user.dart';
import '../../model/user_model/notification_details.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../widgets/empty_widget.dart';
import '../widgets/loading_page.dart';


class NotificationsDetails extends StatelessWidget {
  final String notificationId, bKey;
  const NotificationsDetails({
    Key? key, required this.notificationId, required this.bKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child:   Notifications(notificationId: notificationId, bKey: bKey,),
    );
  }
}

class Notifications extends StatefulWidget {
  final String notificationId, bKey;

    Notifications({super.key, required this.notificationId, required this.bKey});

  @override
  State<Notifications> createState() => _NotificationsState(bKey: bKey, notificationId: notificationId);
}

class _NotificationsState extends State<Notifications> {
  final String notificationId, bKey;

     late UserCubit _userCubit;

  _NotificationsState({required this.notificationId, required this.bKey});
 


  getNotifications() async {
    _userCubit = context.read<UserCubit>();
 

    _userCubit.getNotificationsDetails(token: bKey, id: notificationId);
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  DetailsData? notificationsDetail;

  @override
  Widget build(BuildContext context) {

    final timeFormat = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is NotifyDetailsLoaded) {
          if (state.notifyDetails.status == 1) {
            notificationsDetail = state.notifyDetails.data;
            setState(() {});
          } else {
            
          }
        }
      }, builder: (context, state) {
        if (state is UserNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            context: context,

            onRefresh: () =>    _userCubit.getNotificationsDetails(token: bKey, id: notificationId),

          );
        } else if (state is UserNetworkErrApiErr) {
          return EmptyWidget(
            title: 'Network error',
            context: context,

            description: state.message,
            onRefresh: () =>     _userCubit.getNotificationsDetails(token: bKey, id: notificationId),

          );
        }  

        return (state is NotifyDetailsLoading )
            ? const LoadingPage()
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(children: [
                SafeArea(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.04,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:   Align(
                        alignment: Alignment.topLeft,
                        child:  GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios, color: AppColors.lightPrimary,)),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      "Notification",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height,
                        decoration: BoxDecoration(
                            color: AppColors.lightPrimary.withOpacity(0.1),
                            border: Border(
                                bottom: BorderSide(color: Colors.grey.shade300))),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child:   Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notificationsDetail?.title?.toUpperCase() ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                notificationsDetail?.message ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                              SizedBox(height: 20.0),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                                   
                              //     Padding(
                              //       padding: EdgeInsets.only(right: 12.0),
                              //       child: Text(
                              //               timeFormat.getCurrentTime(int.parse(date)),
                                      
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ))
              ]),
            );
   } ),
    );
  }
}
