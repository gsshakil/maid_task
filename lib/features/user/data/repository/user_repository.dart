import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/core/api/server_exception.dart';
import 'package:maids_task/features/user/data/data_sources/i_user_data_source.dart';
import 'package:maids_task/features/user/data/models/user_list_model.dart';
import 'package:maids_task/features/user/data/models/user_model.dart';
import 'package:maids_task/features/user/domain/repository/i_user_repository.dart';

class UserRepository extends IUserRepository {
  final IUserDataSource userDataSource;

  UserRepository({required this.userDataSource});
  @override
  Future<Either<Failure, UserListModel>> getAllUsers() async {
    try {
     UserListModel result = await userDataSource.getAllUsers();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
     UserModel result = await userDataSource.getCurrentUser();
      return Right(result);
    }   on ServerException catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }
}
