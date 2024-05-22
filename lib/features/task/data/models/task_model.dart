import 'package:maids_task/features/task/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.todo,
    required super.completed,
    required super.userId,
  });

  TaskModel copyWith({
    final int? id,
    final String? todo,
    final bool? completed,
    final int? userId,
  }) {
    return TaskModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }

  factory TaskModel.init() => const TaskModel(
        id: 0,
        todo: '',
        completed: false,
        userId: 0,
      );

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"] ?? 0,
        todo: json["todo"] ?? '',
        completed: json["completed"] ?? false,
        userId: json["userId"] ?? 0,
      );
}
