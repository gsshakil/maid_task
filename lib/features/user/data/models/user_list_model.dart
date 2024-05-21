import 'package:maids_task/features/user/data/models/user_model.dart';
import 'package:maids_task/features/user/domain/entities/user_entity.dart';
import 'package:maids_task/features/user/domain/entities/user_list_entity.dart';

class UserListModel extends UserListEntity {
  const UserListModel({
    required super.users,
    required super.total,
    required super.skip,
    required super.limit,
  });

  UserListModel copyWith({
    final List<UserEntity>? users,
    final int? total,
    final int? skip,
    final int? limit,
  }) {
    return UserListModel(
      users: users ?? this.users,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }

  factory UserListModel.init() => const UserListModel(
        users: [],
        total: 0,
        skip: 0,
        limit: 0,
      );

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        users: List<UserModel>.from(
            json["users"].map((x) => UserModel.fromJson(x))),
        total: json["total"] ?? 0,
        skip: json["skip"] ?? 0,
        limit: json["limit"] ?? 0,
      );
}
