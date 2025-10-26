import 'package:dio/dio.dart';
import 'package:tarkhineh/core/constants/api_endpoints.dart';
import 'package:tarkhineh/core/constants/error_message.dart';
import 'package:tarkhineh/core/exception/network_exception.dart';
import 'package:tarkhineh/core/models/api_result.dart';
import 'package:tarkhineh/core/models/food_model.dart';

abstract class IFoodService {
  Future<ApiResult<List<FoodModel>>> getSpecialFoods();
  Future<ApiResult<List<FoodModel>>> getPopularFoods();
}

class FoodService implements IFoodService {
  final Dio dio;

  FoodService(this.dio);
  @override
  Future<ApiResult<List<FoodModel>>> getSpecialFoods() async {
    try {
      final response = await dio.get(ApiEndpoints.getSpecialFoods);
      return ApiResult.fromJson(
        response.data,
        (_) => (response.data['data'] as List)
            .map((e) => FoodModel.fromJson(e))
            .toList(),
      );
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return ApiResult(
          success: false,
          message: (e.error as NetworkException).message,
        );
      } else {
        return ApiResult(success: false, message: ErrorMessage.unknownError);
      }
    }
  }

  @override
  Future<ApiResult<List<FoodModel>>> getPopularFoods() async {
    try {
      final response = await dio.get(ApiEndpoints.getPopularFoods);
      return ApiResult.fromJson(
        response.data,
        (_) => (response.data['data'] as List)
            .map((e) => FoodModel.fromJson(e))
            .toList(),
      );
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return ApiResult(
          success: false,
          message: (e.error as NetworkException).message,
        );
      } else {
        return ApiResult(success: false, message: ErrorMessage.unknownError);
      }
    }
  }
}
