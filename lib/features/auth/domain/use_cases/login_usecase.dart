import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/auth/domain/repository/i_auth_repository.dart';
import 'package:maids_task/features/user/data/models/user_model.dart';

class LoginUseCase {
  IAuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failure, UserModel>> call({
    required String username,
    required String password,
  }) async {
    return await authRepository.login(username: username, password: password);
  }
}
