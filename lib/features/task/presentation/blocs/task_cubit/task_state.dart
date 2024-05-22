part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}
final class TaskMoreLoading extends TaskState {}

final class TaskError extends TaskState {
  final Failure failure;

  const TaskError({required this.failure});
}

final class TaskSuccess extends TaskState {
  final TaskListEntity tasks;

  const TaskSuccess({required this.tasks});
}
