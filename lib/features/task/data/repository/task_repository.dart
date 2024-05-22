import 'package:dartz/dartz.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/core/api/server_exception.dart';
import 'package:maids_task/features/task/data/data_sources/i_task_data_source.dart';
import 'package:maids_task/features/task/data/models/task_list_model.dart';
import 'package:maids_task/features/task/data/models/task_model.dart';
import 'package:maids_task/features/task/domain/repository/i_task_repository.dart';

class TaskRepository extends ITaskRepository {
  final ITaskDataSource taskDataSource;

  TaskRepository({required this.taskDataSource});

  @override
  Future<Either<Failure, TaskListModel>> getAllTasks({
    required int limit,
    required int skip,
    required int userId,
  }) async {
    try {
      TaskListModel result = await taskDataSource.getAllTasks(
        limit: limit,
        skip: skip,
        userId: userId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> deleteTask({required int id}) async {
    try {
      TaskModel result = await taskDataSource.deleteTask(
        id: id,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> updateTask({
    required int id,
    required bool value,
  }) async {
    try {
      TaskModel result = await taskDataSource.updateTask(
        id: id,
        value: value,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> addTask({
    required String task,
    required bool completed,
    required int userId,
  }) async {
    try {
      TaskModel result = await taskDataSource.addTask(
        task: task,
        completed: completed,
        userId: userId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }
}
