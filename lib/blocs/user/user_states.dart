import 'package:equatable/equatable.dart';
import 'package:esalerz/model/user_model/message_list.dart';

import '../../model/auth_model/auth_user.dart';
import '../../model/user_model/all_products.dart';
import '../../model/user_model/categories_list.dart';
import '../../model/user_model/conversation_list.dart';
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

class  ReportUserLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class ReportUserLoaded extends UserStates {
  final AllProducts report;
  const ReportUserLoaded(this.report);
  @override
  List<Object> get props => [report];
}

class  BookmarkLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class BookmarkLoaded extends UserStates {
  final AllProducts bookmark  ;
  const BookmarkLoaded(this.bookmark);
  @override
  List<Object> get props => [bookmark];
}

class  CategoriesLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class CategoriesLoaded extends UserStates {
  final CategoriesList categoriesList  ;
  const CategoriesLoaded(this.categoriesList);
  @override
  List<Object> get props => [categoriesList];
}

class  SubCategoriesLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class SubCategoriesLoaded extends UserStates {
  final CategoriesList categoriesList  ;
  const SubCategoriesLoaded(this.categoriesList);
  @override
  List<Object> get props => [categoriesList];
}

class  SendMessageLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class SendMessageLoaded extends UserStates {
  final AuthUser messageSent  ;
  const SendMessageLoaded(this.messageSent);
  @override
  List<Object> get props => [messageSent];
}

class  GetMessageLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class GetMessageLoaded extends UserStates {
  final MessageList messageList  ;
  const GetMessageLoaded(this.messageList);
  @override
  List<Object> get props => [messageList];
}

class  GetConversationsLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class GetGetConversationsLoaded extends UserStates {
  final ConversationList conversationList  ;
  const GetGetConversationsLoaded(this.conversationList);
  @override
  List<Object> get props => [conversationList];
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
