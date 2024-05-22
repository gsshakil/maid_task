part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserError extends UserState {
  final Failure failure;

  const UserError({required this.failure});
}

final class UserSuccess extends UserState {
  final UserListModel users;

  const UserSuccess({required this.users});
}

final class CurrentUserSuccess extends UserState {
  final UserModel user;

  const CurrentUserSuccess({required this.user});
}
