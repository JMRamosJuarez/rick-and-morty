abstract class AppHttpClient {
  Future<Response> get<Response>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> post<Request, Response>(
    String path, {
    Request? data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> put<Request, Response>(
    String path, {
    Request? data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> patch<Request, Response>(
    String path, {
    Request? data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> delete<Request, Response>(
    String path, {
    Request? data,
    Map<String, dynamic>? queryParameters,
  });
}
