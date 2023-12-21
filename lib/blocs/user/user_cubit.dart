
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user_model/ads_options.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository.dart';

import '../../utils/exceptions.dart';
import 'user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit({required this.userRepository, required this.viewModel})
      : super(const InitialState());
  final UserRepository userRepository;
  final UserViewModel viewModel;

  Future<void> createNotifications({
    required String token,
  }) async {
    try {
      emit(CreateNotifyLoading());

      final notifications = await userRepository.getAllNotifications(
        token: token,
      );

      viewModel.setNotificationLength(notification: notifications.data ?? []);

      emit(CreateNotifyLoaded(notifications));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getNotificationsDetails({
    required String token,
    required String id,
  }) async {
    try {
      emit(NotifyDetailsLoading());

      final notifications = await userRepository.getDetailsNotifications(
        token: token,
        id: id,
      );
      emit(NotifyDetailsLoaded(notifications));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getProducts({
    required String token,
  }) async {
    try {
      emit(ProductsLoading());

      final products = await userRepository.getAllProducts(
        token: token,
      );

      // viewModel.setNotificationLength(notification: notifications.data ?? []);

      emit(ProductsLoaded(products));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getProductDetails(
      {required String token, required String adId}) async {
    try {
      emit(ProductsDetailsLoading());

      final products = await userRepository.getProductDetails(
        token: token,
        adId: adId,
      );

      // viewModel.setNotificationLength(notification: notifications.data ?? []);

      emit(ProductsDetailsLoaded(products));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> sendFeedback({
    required String token,
    required String adId,
    required String message,
    required String rating,
  }) async {
    try {
      emit(AddFeedbackLoading());

      final products = await userRepository.sendFeedback(
        token: token,
        adId: adId,
        rating: rating,
        message: message,
      );

      // viewModel.setNotificationLength(notification: notifications.data ?? []);

      emit(AddFeedbackLoaded(products));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getFeedback({
    required String token,
    required String adId,
  }) async {
    try {
      emit(GetFeedbackLoading());

      final feedbacks = await userRepository.getFeedbacks(
        token: token,
        adId: adId,
      );

      emit(GetFeedbackLoaded(feedbacks));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> createLike({
    required String token,
    required String adId,
  }) async {
    try {
      emit(CreateLikeLoading());

      final like = await userRepository.createLike(
        token: token,
        adId: adId,
      );

      emit(CreateLikeLoaded(like));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> removeLike({
    required String token,
    required String adId,
  }) async {
    try {
      emit(RemoveLikeLoading());

      final like = await userRepository.removeLike(
        token: token,
        adId: adId,
      );

      emit(RemoveLikeLoaded(like));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> sendReport({
    required String token,
    required String adId,
    required String reason,
  }) async {
    try {
      emit(ReportUserLoading());

      final report = await userRepository.sendReport(
        token: token,
        adId: adId,
        reason: reason,
      );

      emit(ReportUserLoaded(report));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

    Future<void> saveProduct({
    required String token,
    required String adId,
    required String url,
  }) async {
    try {
      emit(BookmarkLoading());

      final report = await userRepository.saveProducts(
        token: token,
        adId: adId,
        url: url,
      );

      emit(BookmarkLoaded(report));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

   Future<void> getCategories({
    required String token,
     
  }) async {
    try {
      emit(CategoriesLoading());

      final categories = await userRepository.getCategories(
        token: token,
         
      );

      emit(CategoriesLoaded(categories));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

   Future<void> getSubCategories({
    required String token,
    required String catId,
  }) async {
    try {
      emit(SubCategoriesLoading());

      final report = await userRepository.getSubCategories(
        token: token,
        catId: catId,
      );

      emit(SubCategoriesLoaded(report));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> sendMessage({ required String bkey,required String receiver, required String message}) async {
    try {
      emit(SendMessageLoading());

      final messageSent = await userRepository.sendChatMessage(
        bkey: bkey,
        receiver: receiver,
        message: message,
      );

      emit(SendMessageLoaded(messageSent));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getMessage({ required String bkey,required String receiver, }) async {
    try {
      emit(GetMessageLoading());

      final messageList = await userRepository.getChatMessages(
        bkey: bkey,
        receiver: receiver,
      );

      emit(GetMessageLoaded(messageList));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getConversationMessages({ required String bkey, }) async {
    try {
      emit(GetConversationsLoading());

      final messageList = await userRepository.getConversations(
        bkey: bkey,
      );

      emit(GetGetConversationsLoaded(messageList));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

    Future<void> getAllServices({ required String bkey, }) async {
    try {
      emit(GetAllServicesLoading());

      final servicesList = await userRepository.getAllServices(
        bkey: bkey,
      );

      emit(GetAllServicesLoaded(servicesList));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

    Future<void> getServicesSubCat({ required String bkey,required String serviceId, }) async {
    try {
      emit(ServicesSubCatLoading());

      final servicesList = await userRepository.getServicesSubCat(
        bkey: bkey, serviceId: serviceId,
      );

      emit(ServicesSubCatLoaded(servicesList));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

      Future<void> getAdsOptions({ required String bkey,required String adsId, }) async {
    try {
      emit(AdsOptionsLoading());

      final adsOptions = await userRepository.getAdsOptions(
        bkey: bkey, adsId: adsId,
      );

      emit(AdsOptionsLoaded(adsOptions));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

      Future<void> postAds({required List<AdsOptionsData> options,
      required File image,
      var controllers,
      var selectedValues,
      required String token}) async {
    try {
      emit(PostAdsLoading());

      final ads = await userRepository.uploadAds(options: options, image: image, token: token, controllers: controllers, selectedValues: selectedValues
        
      );

      emit(PostAdsLoaded(ads));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}
