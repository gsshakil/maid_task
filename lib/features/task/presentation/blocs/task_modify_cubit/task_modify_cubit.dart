import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/task/domain/entities/task_entity.dart';
import 'package:maids_task/features/task/domain/use_cases/add_new_task_usecase.dart';
import 'package:maids_task/features/task/domain/use_cases/delete_task_usecase.dart';
import 'package:maids_task/features/task/domain/use_cases/update_task_usecase.dart';

part 'task_modify_state.dart';

class TaskModifyCubit extends Cubit<TaskModifyState> {
  final AddNewTaskUseCase addNewTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  TaskModifyCubit({
    required this.addNewTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(TaskModifyInitial());

  addNewTask({
    required String task,
    required bool completed,
    required int userId,
  }) async {
    emit(TaskModifyLoading());
    Either<Failure, TaskEntity> result = await addNewTaskUseCase(
      task: task,
      completed: completed,
      userId: userId,
    );

    result.fold(
      (l) => emit(TaskModifyError(failure: l)),
      (r) => emit(TaskModifySuccess(tasks: r)),
    );
  }

  updateTask({
    required int id,
    required bool value,
  }) async {
    emit(TaskModifyLoading());
    Either<Failure, TaskEntity> result = await updateTaskUseCase(
      id: id,
      value: value,
    );

    result.fold(
      (l) => emit(TaskModifyError(failure: l)),
      (r) => emit(TaskModifySuccess(tasks: r)),
    );
  }

  deleteTask({
    required int id,
  }) async {
    emit(TaskModifyLoading());
    Either<Failure, TaskEntity> result = await deleteTaskUseCase(id: id);

    result.fold(
      (l) => emit(TaskModifyError(failure: l)),
      (r) => emit(TaskModifySuccess(tasks: r)),
    );
  }
}
