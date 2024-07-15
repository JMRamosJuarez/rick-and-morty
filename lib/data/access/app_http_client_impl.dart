import 'package:dio/dio.dart';
import 'package:rick_and_morty/domain/access/app_http_client.dart';
import 'package:rick_and_morty/domain/entities/app_error.dart';

final class AppHttpClientImpl extends AppHttpClient {
  final Dio dio;

  AppHttpClientImpl({required this.dio});

  @override
  Future<Response> get<Response>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw ServerError(message: e.message ?? '-');
    }
  }

  @override
  Future<Response> post<Request, Response>(String path,
      {Request? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await dio.post(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw ServerError(message: e.message ?? '-');
    }
  }

  @override
  Future<Response> put<Request, Response>(String path,
      {Request? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await dio.put(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw ServerError(message: e.message ?? '-');
    }
  }

  @override
  Future<Response> patch<Request, Response>(String path,
      {Request? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await dio.patch(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw ServerError(message: e.message ?? '-');
    }
  }

  @override
  Future<Response> delete<Request, Response>(String path,
      {Request? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await dio.delete(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw ServerError(message: e.message ?? '-');
    }
  }
}
