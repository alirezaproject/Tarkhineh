import 'package:dio/dio.dart';
import 'package:tarkhineh/core/exception/network_exception.dart';

class CustomApiInterceptor extends Interceptor {
  final Dio dio;
  final int retries;
  final Duration retryDelay;

  CustomApiInterceptor({
    required this.dio,
    this.retries = 1,
    this.retryDelay = const Duration(seconds: 10),
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // فقط اگر retry مجاز باشه
    if (_shouldRetry(err)) {
      try {
        final response = await _retryRequest(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (_) {
        // اگر بعد از retry هنوز شکست خورد، فقط یک بار reject
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: NetworkException(
              'خطا در ارتباط با سرور، لطفاً بعداً دوباره تلاش کنید.',
            ),
            type: err.type,
          ),
        );
        return;
      }
    }

    // اگر retry مجاز نیست، ارور استاندارد بده
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: NetworkException(
          'مشکلی در ارتباط با سرور پیش آمده. کمی بعد دوباره امتحان کنید.',
        ),
        type: err.type,
        message: err.message,
      ),
    );
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.unknown;
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    for (var attempt = 0; attempt < retries; attempt++) {
      await Future.delayed(Duration(seconds: 5 * (attempt + 1)));
      try {
        final options = Options(
          method: requestOptions.method,
          headers: requestOptions.headers,
          responseType: requestOptions.responseType,
          contentType: requestOptions.contentType,
          followRedirects: requestOptions.followRedirects,
          validateStatus: requestOptions.validateStatus,
        );

        return await dio.request(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: options,
        );
      } catch (e) {
        if (attempt == retries - 1) rethrow;
      }
    }
    throw Exception('Retry failed');
  }
}
