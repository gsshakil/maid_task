import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/user/data/models/user_list_model.dart';
import 'package:maids_task/features/user/data/models/user_model.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserListModel>> getAllUsers();
  Future<Either<Failure, UserModel>> getCurrentUser();
}
