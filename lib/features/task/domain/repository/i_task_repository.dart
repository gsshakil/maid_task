import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/task/data/models/task_list_model.dart';

abstract class ITaskRepository {
  Future<Either<Failure, TaskListModel>> getAllTasks({
    required int limit,
    required int skip,
    required int userId,
  });
}
