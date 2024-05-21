import 'package:maids_task/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.username,
    required super.password,
    required super.token,
    required super.message,
  });

  UserModel copyWith({
    final int? id,
    final String? firstName,
    final String? lastName,
    final String? email,
    final String? username,
    final String? password,
    final String? token,
    final String? message,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token,
      message: message ?? this.message,
    );
  }

  factory UserModel.init() => const UserModel(
        id: 0,
        firstName: '',
        lastName: '',
        email: '',
        username: '',
        password: '',
        token: '',
        message: '',
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? 0,
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        email: json["email"] ?? '',
        username: json["username"] ?? '',
        password: json["password"] ?? '',
        token: json["token"] ?? '',
        message: json["message"] ?? '',
      );
}
