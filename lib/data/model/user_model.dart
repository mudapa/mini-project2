import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? email;
  final String? userName;
  final String? password;
  final int? role;

  const UserModel({
    this.id,
    this.email,
    this.userName,
    this.password,
    this.role,
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    return UserModel(
      id: id,
      email: json['email'],
      userName: json['userName'],
      password: json['password'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userName': userName,
      'password': password,
      'role': role,
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        userName,
        password,
        role,
      ];
}
