import 'package:dio/dio.dart';
import 'package:tarkhineh/core/exception/network_exception.dart';

class CustomApiInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionTimeout || err.type == DioExceptionType.connectionError) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          type: err.type,
          error: NetworkException('اتصال به سرور برقرار نشد، لطفاً اینترنت خود را بررسی کنید.'),
        ),
      );
    } else {
      handler.next(err);
    }
  }
}
