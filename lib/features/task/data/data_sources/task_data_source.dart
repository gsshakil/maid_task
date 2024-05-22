import 'dart:convert';
import 'dart:developer';

import 'package:maids_task/core/api/api_endpoints.dart';
import 'package:maids_task/core/api/i_network_client.dart';
import 'package:maids_task/features/task/data/data_sources/i_task_data_source.dart';
import 'package:maids_task/features/task/data/models/task_list_model.dart';

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
        paramas:  NetworkParams(
      headers:const  {
        "Accept": "application/vnd.github+json",
      },
      endPoint: '${ApiEndpoints.tasksEndPoint}/$userId?limit=$limit&skip=0',
    ));

    log('result: $result');

    TaskListModel response = TaskListModel.fromJson(json.decode(result));

    log('response: $response');

    return response;
  }
}
