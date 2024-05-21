import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;
  final String token;
  final String message;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
    required this.token,
    required this.message,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        password,
        token,
        message,
      ];
}
