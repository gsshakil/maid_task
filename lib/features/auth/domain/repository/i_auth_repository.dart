import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/user/data/models/user_model.dart';

abstract class IAuthRepository {
  Future<Either<Failure, UserModel>> login({
    required String username,
    required String password,
  });
}
