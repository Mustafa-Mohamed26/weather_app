import 'package:dio/dio.dart';

class ApiRepository {
  final String? url;
  final Map<String, dynamic>? payload;

  ApiRepository({this.url, this.payload});

  // dio instance
  Dio _dio = Dio();

  /// Performs a GET request to the specified [url] with [payload] as query
  /// parameters. The request is sent asynchronously and the response is handled
  /// by the provided callbacks.
  ///
  /// [beforeSend] is called just before the request is sent. If it returns a
  /// Future, it is awaited until the request is sent.
  ///
  /// [onSuccess] is called if the request is successful. The response data
  /// is passed as an argument.
  ///
  /// [onError] is called if the request fails. The error is passed as an
  /// argument.
  void getData({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    _dio.get(url!, queryParameters: payload).then((response) {
      if (onSuccess != null) {
        onSuccess(response.data);
      }
    }).catchError((error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}
