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
}

