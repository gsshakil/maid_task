import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/core/data/secure_storage.dart';
import 'package:maids_task/features/task/data/models/task_list_model.dart';
import 'package:maids_task/features/task/domain/entities/task_entity.dart';
import 'package:maids_task/features/task/domain/entities/task_list_entity.dart';
import 'package:maids_task/features/task/domain/use_cases/get_all_tasks_usecase.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;

  ScrollController scrollController = ScrollController();

  int? userId;

  int page = 1; //Page Number
  final int perPage = 10; //GET POSTS PER API CALL

  //Search result object to get the total count or error message
  TaskListEntity _taskListEntity = TaskListModel.init();
  TaskListEntity get taskListEntity => _taskListEntity;

  //Store posts here
  final List<TaskEntity> _items = [];
  List<TaskEntity> get items => _items;
  TaskCubit({required this.getAllTasksUseCase}) : super(TaskInitial()) {
    scrollController.addListener(
      () async {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          String userIdFromStorage = await SecureStorage().getUserId();
          getMoreTasks(userId: int.parse(userIdFromStorage));
        }
      },
    );
  }

  void getTasks({required int userId}) async {
    String userIdFromStorage = await SecureStorage().getUserId();
    userId = int.parse(userIdFromStorage);

    page = 1; //re-initialize the page
    _items.clear(); //Empty the items array

    emit(TaskLoading());
    Either<Failure, TaskListEntity> result = await getAllTasksUseCase(
      limit: perPage,
      skip: perPage,
      userId: userId,
    );

    // increase the page number
    page++;

    result.fold((l) => emit(TaskError(failure: l)), (r) {
      // store search result
      _taskListEntity = r;
      // store items/post from search result
      _items.addAll(r.todos);
      emit(TaskSuccess(tasks: r));
    });
  }

  void getMoreTasks({required int userId}) async {
    // Check if page is inital or is lower or equal to total page
    if (page == 1 || page <= (_taskListEntity.total / perPage).ceil()) {
      emit(TaskMoreLoading());
      Either<Failure, TaskListEntity> result = await getAllTasksUseCase(
        limit: perPage,
        skip: perPage,
        userId: userId,
      );

      // increase the page number
      page++;

      result.fold((l) => emit(TaskError(failure: l)), (r) {
        // store search result
        _taskListEntity = r;
        // store items/post from search result
        _items.addAll(r.todos);
        emit(TaskSuccess(tasks: r));
      });
    }
  }

  addNewTask() {}

  deleteTask() {}

  updateTask() {}
}
