import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:maids_task/core/api/api_endpoints.dart';
import 'package:maids_task/core/api/i_network_client.dart';
import 'package:maids_task/features/task/data/data_sources/i_task_data_source.dart';
import 'package:maids_task/features/task/data/models/task_list_model.dart';
import 'package:maids_task/features/task/data/models/task_model.dart';

class TaskDataSource extends ITaskDataSource {
  final INetworkClient networkClient;

  TaskDataSource({required this.networkClient});

  @override
  Future<TaskListModel> getAllTasks({
    required int limit,
    required int skip,
    required int userId,
  }) async {
    var result = await networkClient.get(
        paramas: NetworkParams(
      headers: const {
        "Accept": "application/vnd.github+json",
      },
      endPoint: '${ApiEndpoints.tasksEndPoint}/$userId?limit=$limit&skip=0',
    ));

    TaskListModel response = TaskListModel.fromJson(json.decode(result));

    return response;
  }

  @override
  Future<TaskModel> updateTask({required int id, required bool value}) async {
    var result = await Dio().put(
      '${ApiEndpoints.singleTaskEndPoint}/$id',
      data: {
        'completed': value,
      },
    );

    TaskModel response = TaskModel.fromJson(result.data);

    log('update response: $response');

    return response;
  }

  @override
  Future<TaskModel> deleteTask({required int id}) async {
    var result = await Dio().delete(
      '${ApiEndpoints.singleTaskEndPoint}/$id',
    );

    TaskModel response = TaskModel.fromJson(result.data);

    log('delete response: $response');

    return response;
  }

  @override
  Future<TaskModel> addTask(
      {required String task,
      required bool completed,
      required int userId}) async {
    var result = await networkClient.post(
      paramas: PostParams(
        headers: const {
          "Accept": "application/vnd.github+json",
        },
        endPoint: ApiEndpoints.addTaskEndPoint,
        body: {
          'todo': task,
          'completed': completed,
          userId: userId,
        },
      ),
    );

    TaskModel response = TaskModel.fromJson(result);

    log('add task: $response');

    return response;
  }
}
