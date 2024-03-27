import 'package:dio/dio.dart';

class DioHelper {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.43.245:8080/api/v1/',
    receiveDataWhenStatusError: true,
    // connectTimeout: ,
    // receiveTimeout: ,
  ));

  static Future<Response> getAPI({
    required String endpoint,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
      );
      return response;
    } on Exception catch (error) {
      print('Error during GET request: $error');
      rethrow;
    }
  }

  static Future<Response> getAPIwithParam({
    required String endpoint,
    required Map<String, dynamic> params,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: params,
      );
      return response;
    } on Exception catch (error) {
      print('Error during GET request with parameters: $error');
      rethrow;
    }
  }

  static Future<Response> postAPI({
    required String endpoint,
    required dynamic data, // Must be send in json format.
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
      );
      return response;
    } on Exception catch (error) {
      print('Error during Post request: $error');
      rethrow;
    }
  }
  static Future<Response> deleteAPI({
    required String endpoint,
  }) async {
    try {
      final response = await dio.delete(
        endpoint,
      );
      return response;
    } on Exception catch (error) {
      print('Error during Post request: $error');
      rethrow;
    }
  }
}
