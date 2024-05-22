import 'package:equatable/equatable.dart';
import 'package:maids_task/features/task/domain/entities/task_entity.dart';

class TaskListEntity extends Equatable {
  final List<TaskEntity> todos;
  final int total;
  final int skip;
  final int limit;

  const TaskListEntity({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [todos, total, skip, limit];
}
