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
          error: NetworkException('مشکلی در ارتباط با سرور پیش آمده. کمی بعد دوباره امتحان کنید.'),
        ),
      );
    } else {
      handler.next(err);
    }
  }
}
