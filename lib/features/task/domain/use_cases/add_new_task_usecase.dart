import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/task/data/models/task_model.dart';
import 'package:maids_task/features/task/domain/repository/i_task_repository.dart';

class AddNewTaskUseCase {
  ITaskRepository taskRepository;

  AddNewTaskUseCase({required this.taskRepository});

  Future<Either<Failure, TaskModel>> call({
    required String task,
    required bool completed,
    required int userId,
  }) async {
    return await taskRepository.addTask(
      task: task,
      completed: completed,
      userId: userId,
    );
  }
}
