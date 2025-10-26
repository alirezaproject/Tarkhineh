// core/network/auth_interceptor.dart
import 'package:dio/dio.dart';

import 'token_manager.dart';
import '../storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final TokenManager tokenManager;
  final Dio dio; // ← جدید، جدا از dio اصلی
  final SecureStorageService storage;

  AuthInterceptor({required this.tokenManager, required this.dio, required this.storage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await storage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // اگر توکن expire شده
    if (err.response?.statusCode == 401) {
      final newToken = await tokenManager.refreshAccessToken(dio);
      if (newToken != null) {
        final retryReq = err.requestOptions;
        retryReq.headers['Authorization'] = 'Bearer $newToken';
        final cloneResponse = await dio.fetch(retryReq);
        return handler.resolve(cloneResponse);
      }
    }
    return handler.next(err);
  }
}
