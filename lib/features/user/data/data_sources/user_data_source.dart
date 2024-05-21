import 'dart:convert';
import 'dart:developer';

import 'package:maids_task/core/api/api_endpoints.dart';
import 'package:maids_task/core/api/i_network_client.dart';
import 'package:maids_task/features/user/data/data_sources/i_user_data_source.dart';
import 'package:maids_task/features/user/data/models/user_list_model.dart';
import 'package:maids_task/features/user/data/models/user_model.dart';

class UserDataSource extends IUserDataSource {
  final INetworkClient networkClient;

  UserDataSource({required this.networkClient});

  @override
  Future<UserListModel> getAllUsers() async {
    String result = await networkClient.get(
        paramas: const NetworkParams(
      headers: {
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
      },
      endPoint: ApiEndpoints.getAllUsersEndPoint,
    ));

    UserListModel response = UserListModel.fromJson(json.decode(result));

    return response;
  }
}
