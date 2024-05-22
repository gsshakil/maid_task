import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/task/data/models/task_model.dart';
import 'package:maids_task/features/task/domain/repository/i_task_repository.dart';

class DeleteTaskUseCase {
  ITaskRepository taskRepository;

  DeleteTaskUseCase({required this.taskRepository});

  Future<Either<Failure, TaskModel>> call({required int id}) async {
    return await taskRepository.deleteTask(id: id);
  }
}
