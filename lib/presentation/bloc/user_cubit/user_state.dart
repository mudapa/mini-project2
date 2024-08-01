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

final class ListUserLoading extends UserState {}

final class ListUserSuccess extends UserState {
  final List<UserModel> users;

  const ListUserSuccess(this.users);

  @override
  List<Object> get props => [users];
}

final class ListUserFailure extends UserState {
  final String message;

  const ListUserFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class UserUpdateLoading extends UserState {}

final class UserUpdateSuccess extends UserState {
  final UserModel user;

  const UserUpdateSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class UserUpdateFailure extends UserState {
  final String message;

  const UserUpdateFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class UserDeleteLoading extends UserState {}

final class UserDeleteSuccess extends UserState {
  final UserModel user;

  const UserDeleteSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class UserDeleteFailure extends UserState {
  final String message;

  const UserDeleteFailure(this.message);

  @override
  List<Object> get props => [message];
}
