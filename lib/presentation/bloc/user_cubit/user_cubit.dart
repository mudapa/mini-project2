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
}
