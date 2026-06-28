import 'package:dio/dio.dart';
import '../utils/constants.dart';

/// Cliente HTTP configurado com Dio e interceptors.
///
/// Implementa o padrão Singleton para garantir uma única instância
/// do cliente HTTP em toda a aplicação.
class ApiService {
  static ApiService? _instance;
  late final Dio _dio;

  ApiService._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: AppConstants.connectTimeout),
        receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _setupInterceptors();
  }

  /// Retorna a instância única do serviço (Singleton Pattern).
  static ApiService get instance {
    _instance ??= ApiService._();
    return _instance!;
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Logging de requisições
          // ignore: avoid_print
          print('[API] ${options.method} ${options.path}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          // ignore: avoid_print
          print('[API] Response ${response.statusCode}: ${response.requestOptions.path}');
          handler.next(response);
        },
        onError: (DioException error, handler) {
          // ignore: avoid_print
          print('[API] Error: ${error.message}');
          handler.next(error);
        },
      ),
    );
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParams}) async {
    return _dio.get<T>(path, queryParameters: queryParams);
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) async {
    return _dio.post<T>(path, data: data);
  }

  Future<Response<T>> put<T>(String path, {dynamic data}) async {
    return _dio.put<T>(path, data: data);
  }

  Future<Response<T>> delete<T>(String path) async {
    return _dio.delete<T>(path);
  }
}
