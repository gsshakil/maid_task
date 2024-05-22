import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/user/data/models/user_model.dart';
import 'package:maids_task/features/user/domain/repository/i_user_repository.dart';

class GetCurrentUserUseCase {
  IUserRepository userRepository;

  GetCurrentUserUseCase({required this.userRepository});

  Future<Either<Failure, UserModel>> call() async {
    return await userRepository.getCurrentUser();
  }
}
