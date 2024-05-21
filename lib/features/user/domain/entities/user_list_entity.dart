import 'package:equatable/equatable.dart';
import 'package:maids_task/features/user/domain/entities/user_entity.dart';

class UserListEntity extends Equatable {
 final List<UserEntity> users;
  final int total;
  final int skip;
  final int limit;

  const  UserListEntity({
    required this.users,
    required this.total,
    required this.skip,
    required this.limit,
  });

  

  @override
  List<Object?> get props => [
        users,
        total,
        skip,
        limit,
      ];
}
