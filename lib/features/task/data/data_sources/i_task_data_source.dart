import 'package:maids_task/features/task/data/models/task_list_model.dart';
import 'package:maids_task/features/task/data/models/task_model.dart';

abstract class ITaskDataSource {
  Future<TaskListModel> getAllTasks({
    required int limit,
    required int skip,
    required int userId,
  });

  Future<TaskModel> addTask({
    required String task,
    required bool completed,
    required int userId,
  });
  
  Future<TaskModel> updateTask({required int id, required bool value});
  Future<TaskModel> deleteTask({required int id});
}
