import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/task/data/models/task_list_model.dart';
import 'package:maids_task/features/task/domain/repository/i_task_repository.dart';

class GetAllTasksUseCase {
  ITaskRepository taskRepository;

  GetAllTasksUseCase({required this.taskRepository});

  Future<Either<Failure, TaskListModel>> call({
    required int limit,
    required int skip,
    required int userId,
  }) async {
    return await taskRepository.getAllTasks(
      limit: limit,
      skip: skip,
      userId: userId,
    );
  }
}
