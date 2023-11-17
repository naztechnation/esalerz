import 'package:equatable/equatable.dart';

import '../../model/auth_model/auth_user.dart';
import '../../model/user_model/all_products.dart';
import '../../model/user_model/feedback_lists.dart';
import '../../model/user_model/notification_details.dart';
import '../../model/user_model/notifications.dart';


abstract class UserStates extends Equatable {
  const UserStates();
}

class InitialState extends UserStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class CreateNotifyLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class CreateNotifyLoaded extends UserStates {
  final NotificationsInfo notificationsInfo;
  const CreateNotifyLoaded(this.notificationsInfo);
  @override
  List<Object> get props => [notificationsInfo];
}


class  NotifyDetailsLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class NotifyDetailsLoaded extends UserStates {
  final NotificationsDetail notifyDetails;
  const NotifyDetailsLoaded(this.notifyDetails);
  @override
  List<Object> get props => [notifyDetails];
}

class  ProductsLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class ProductsLoaded extends UserStates {
  final AllProducts products;
  const ProductsLoaded(this.products);
  @override
  List<Object> get props => [products];
}

class  ProductsDetailsLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class ProductsDetailsLoaded extends UserStates {
  final AllProducts products;
  const ProductsDetailsLoaded(this.products);
  @override
  List<Object> get props => [products];
}

class  AddFeedbackLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class AddFeedbackLoaded extends UserStates {
  final AllProducts products;
  const AddFeedbackLoaded(this.products);
  @override
  List<Object> get props => [products];
}

class  CreateLikeLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class CreateLikeLoaded extends UserStates {
  final AllProducts like;
  const CreateLikeLoaded(this.like);
  @override
  List<Object> get props => [like];
}

class  RemoveLikeLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class RemoveLikeLoaded extends UserStates {
  final AllProducts unlike;
  const RemoveLikeLoaded(this.unlike);
  @override
  List<Object> get props => [unlike];
}

class  GetFeedbackLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class GetFeedbackLoaded extends UserStates {
  final FeedbackList feedbacks;
  const GetFeedbackLoaded(this.feedbacks);
  @override
  List<Object> get props => [feedbacks];
}
class UserNetworkErr extends UserStates {
  final String? message;
  const UserNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class UserNetworkErrApiErr extends UserStates {
  final String? message;
  const UserNetworkErrApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
