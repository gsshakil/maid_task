import 'package:maids_task/features/task/data/models/task_model.dart';
import 'package:maids_task/features/task/domain/entities/task_list_entity.dart';

class TaskListModel extends TaskListEntity {
  const TaskListModel({
    required super.todos,
    required super.total,
    required super.skip,
    required super.limit,
  });

  TaskListModel copyWith({
    final List<TaskModel>? todos,
    final int? total,
    final int? skip,
    final int? limit,
  }) {
    return TaskListModel(
      todos: todos ?? this.todos,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }

  factory TaskListModel.init() => const TaskListModel(
        todos: [],
        total: 0,
        skip: 0,
        limit: 0,
      );

  factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
        todos: List<TaskModel>.from(
            json["todos"].map((x) => TaskModel.fromJson(x))),
        total: json["total"] ?? 0,
        skip: json["skip"] ?? 0,
        limit: json["limit"] ?? 0,
      );
}
