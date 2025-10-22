import 'package:tarkhineh/core/storage/secure_storage_service.dart';
import 'package:tarkhineh/service_locator.dart';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  final _storage = sl<SecureStorageService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _storage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }
}
