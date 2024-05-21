part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}


final class AuthError extends AuthState {
  final Failure failure;

  const AuthError({required this.failure});
}

final class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess({required this.user});
}
