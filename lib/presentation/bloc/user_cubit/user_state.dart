part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserRegisterSuccess extends UserState {
  final UserModel user;

  const UserRegisterSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class UserSignInSuccess extends UserState {
  final UserModel user;

  const UserSignInSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class UserSignOutSuccess extends UserState {}

final class UserFailure extends UserState {
  final String message;

  const UserFailure(this.message);

  @override
  List<Object> get props => [message];
}
