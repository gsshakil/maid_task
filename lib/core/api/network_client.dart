import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:maids_task/core/api/server_exception.dart';

import 'i_network_client.dart';

class NetworkClient implements INetworkClient {
  final Dio dio;

  NetworkClient({required this.dio});

  @override
  Future<dynamic> get({required NetworkParams paramas}) async {
    Response response;

    try {
      response = await dio.get(
        paramas.endPoint,
        options: Options(
          contentType: paramas.contentType,
          headers: paramas.headers,
        ),
      );

      return jsonEncode(response.data);
    } on DioException catch (e) {
      throw ServerException(
        errorMessage: e.message ?? '',
        errorData:
            e.response != null ? e.response!.data : e.requestOptions.data,
      );
    }
  }

  @override
  Future<dynamic> post({required PostParams paramas}) async {
    Response response;
    try {
      response = await dio.post(
        paramas.endPoint,
        data: paramas.body,
        options: Options(
          contentType: paramas.contentType,
          headers: paramas.headers,
        ),
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      } else {
        throw ServerException(
          errorMessage: e.message ?? '',
          errorData:
              e.response != null ? e.response!.data : e.requestOptions.data,
        );
      }
    }
  }
}
