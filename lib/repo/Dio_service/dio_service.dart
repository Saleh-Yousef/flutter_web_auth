import 'dart:async';
import 'package:dio/dio.dart';

enum RequestType { GET, POST }

abstract class Model<T> {
  Map<String, dynamic> toJson();
  Model();
}

class HttpRepository {
  Future<dynamic> callRequest(
      {required RequestType requestType,
      required String methodName,
      Map<String, dynamic> getQueryParam = const {},
      Map<String, dynamic> headers = const {},
      Model? postBody,
      String contentType = Headers.jsonContentType}) async {
    late Response response;
    String? baseUrl = '';

    final Dio dioClient = Dio()
      ..options = BaseOptions(
        headers: headers,
        baseUrl: baseUrl,
        followRedirects: false,
        validateStatus: (status) {
          return true;
        },
      );

    switch (requestType) {
      case RequestType.GET:
        response = await dioClient.get(
          methodName,
          queryParameters: getQueryParam,
          options: Options(contentType: contentType),
        );
        break;
      case RequestType.POST:
        response = await dioClient.post(
          methodName,
          queryParameters: getQueryParam,
          data: postBody?.toJson(),
          options: Options(
            contentType: contentType,
          ),
        );
        break;
    }
    return response.data;
  }
}
