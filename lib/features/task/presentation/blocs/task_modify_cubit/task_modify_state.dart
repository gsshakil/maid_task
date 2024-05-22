part of 'task_modify_cubit.dart';

sealed class TaskModifyState extends Equatable {
  const TaskModifyState();

  @override
  List<Object> get props => [];
}

final class TaskModifyInitial extends TaskModifyState {}


final class TaskModifyLoading extends TaskModifyState {}

final class TaskModifyError extends TaskModifyState {
  final Failure failure;

  const TaskModifyError({required this.failure});
}

final class TaskModifySuccess extends TaskModifyState {
  final TaskEntity tasks;

  const TaskModifySuccess({required this.tasks});
}