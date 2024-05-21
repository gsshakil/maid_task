import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/core/api/server_exception.dart';
import 'package:maids_task/features/auth/data/data_sources/i_auth_data_source.dart';
import 'package:maids_task/features/auth/domain/repository/i_auth_repository.dart';
import 'package:maids_task/features/user/data/models/user_model.dart';

class AuthRepository extends IAuthRepository {
  final IAuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});
  @override
  Future<Either<Failure, UserModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      UserModel result =
          await authDataSource.login(username: username, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }
}
