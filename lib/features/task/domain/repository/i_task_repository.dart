import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/task/data/models/task_list_model.dart';
import 'package:maids_task/features/task/data/models/task_model.dart';

abstract class ITaskRepository {
  Future<Either<Failure, TaskListModel>> getAllTasks({
    required int limit,
    required int skip,
    required int userId,
  });

  Future<Either<Failure, TaskModel>> updateTask({
    required int id,
    required bool value,
  });

  Future<Either<Failure, TaskModel>> deleteTask({required int id});

  Future<Either<Failure, TaskModel>> addTask({
    required String task,
    required bool completed,
    required int userId,
  });
}
