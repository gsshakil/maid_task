import 'package:maids_task/features/task/data/models/task_list_model.dart';

abstract class ITaskDataSource {
  Future<TaskListModel> getAllTasks({
    required int limit,
    required int skip,
    required int userId,
  });
}
