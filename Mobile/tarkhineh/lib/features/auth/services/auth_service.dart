import 'package:dio/dio.dart';
import 'package:tarkhineh/core/constants/api_endpoints.dart';
import 'package:tarkhineh/core/constants/error_message.dart';
import 'package:tarkhineh/core/exception/network_exception.dart';
import 'package:tarkhineh/core/models/api_result.dart';

abstract class IAuthService {
  Future<ApiResult<void>> sendOtp(String phone);
  Future<ApiResult> verifyOtp(String phoneNumber, String otpCode);
}

class AuthService implements IAuthService {
  final Dio dio;
  AuthService(this.dio);

  @override
  Future<ApiResult<void>> sendOtp(String phone) async {
    try {
      final response = await dio.post(ApiEndpoints.sendOtp, data: {'phone': phone});
      return ApiResult.fromJson(response.data, (_) {});
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return ApiResult(success: false, message: (e.error as NetworkException).message);
      } else {
        return ApiResult(success: false, message: ErrorMessage.unknownError);
      }
    }
  }

  @override
  Future<ApiResult> verifyOtp(String phoneNumber, String otpCode) async {
    try {
      final response = await dio.post(ApiEndpoints.verifyOtp, data: {'mobile': phoneNumber, 'code': otpCode});
      return ApiResult.fromJson(response.data, (_) {});
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return ApiResult(success: false, message: (e.error as NetworkException).message);
      } else {
        return ApiResult(success: false, message: ErrorMessage.unknownError);
      }
    }
  }
}
