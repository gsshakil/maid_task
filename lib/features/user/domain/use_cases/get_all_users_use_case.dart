import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/user/data/models/user_list_model.dart';
import 'package:maids_task/features/user/domain/repository/i_user_repository.dart';

class GetAllUsersUseCase {
  IUserRepository userRepository;

  GetAllUsersUseCase({required this.userRepository});

  Future<Either<Failure, UserListModel>> call() async {
    return await userRepository.getAllUsers();
  }
}
