import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:maids_task/core/api/api_endpoints.dart';
import 'package:maids_task/core/api/i_network_client.dart';
import 'package:maids_task/features/auth/data/data_sources/i_auth_data_source.dart';
import 'package:maids_task/features/user/data/models/user_model.dart';

class AuthDataSource extends IAuthDataSource {
  final INetworkClient networkClient;

  AuthDataSource({required this.networkClient});

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;

    try {
      var result = await Dio().post(ApiEndpoints.loginEndPoint,
          data: map,
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ));

      UserModel response = UserModel.fromJson(result.data);

      return response;
    } catch (e) {
      UserModel response = UserModel.init()
          .copyWith(message: 'Invalid Credentials or Something went wrong!');

      return response;
    }
  }
}
