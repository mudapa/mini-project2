import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/user_model.dart';
import '../../../data/remote/user_remote.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void signUp({
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      emit(UserLoading());

      UserModel user = await UserRemote().signUp(
        email: email,
        userName: userName,
        password: password,
      );

      emit(UserRegisterSuccess(user));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  void signIn({
    required String userName,
    required String password,
  }) async {
    try {
      emit(UserLoading());

      UserModel user = await UserRemote().signIn(
        userName: userName,
        password: password,
      );

      emit(UserSignInSuccess(user));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(UserLoading());

      await UserRemote().signOut();

      emit(UserSignOutSuccess());
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  void getListUser() async {
    try {
      emit(ListUserLoading());

      List<UserModel> users = await UserRemote().fetchUsers();

      emit(ListUserSuccess(users));
    } catch (e) {
      emit(ListUserFailure(e.toString()));
    }
  }

  Future<void> updateUser({
    required String id,
    required String userName,
    required String email,
    String? image,
    int? role,
  }) async {
    emit(UserUpdateLoading());
    try {
      UserModel user = await UserRemote().updateUser(
        id: id,
        userName: userName,
        email: email,
        image: image!,
        role: role!,
      );

      emit(UserUpdateSuccess(user));
    } on SocketException {
      emit(const UserUpdateFailure('No internet connection'));
    } catch (e) {
      emit(UserUpdateFailure(e.toString()));
    }
  }

  Future<void> deleteUser(String id) async {
    emit(UserDeleteLoading());
    try {
      UserModel user = await UserRemote().deleteUser(id);

      emit(UserDeleteSuccess(user));
    } on SocketException {
      emit(const UserDeleteFailure('No internet connection'));
    } catch (e) {
      emit(UserDeleteFailure(e.toString()));
    }
  }
}
