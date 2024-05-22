import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  const TaskEntity({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, todo, completed, userId];
}
