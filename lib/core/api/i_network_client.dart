import 'package:equatable/equatable.dart';

abstract class INetworkClient {
  Future<dynamic> post({
    required PostParams paramas,
  });

  Future<dynamic> get({
    required NetworkParams paramas,
  });
}

class NetworkParams extends Equatable {
  final String endPoint;
  final String? contentType;
  final Map<String, dynamic>? headers;

  const NetworkParams({
    required this.endPoint,
    this.headers,
    this.contentType,
  });

  @override
  List<Object?> get props => [
        endPoint,
        contentType,
        headers,
      ];
}

class PostParams extends NetworkParams {
  final dynamic body;
  final String? contentType;
  final bool isJsonBody;

  const PostParams({
    required super.endPoint,
    super.headers,
    this.isJsonBody = false,
    this.body,
    this.contentType,
  });
}
