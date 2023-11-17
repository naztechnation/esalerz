import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

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
}
