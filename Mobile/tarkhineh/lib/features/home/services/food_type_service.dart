import 'package:dio/dio.dart';
import 'package:tarkhineh/core/constants/api_endpoints.dart';
import 'package:tarkhineh/core/constants/error_message.dart';
import 'package:tarkhineh/core/exception/network_exception.dart';
import 'package:tarkhineh/core/models/api_result.dart';
import 'package:tarkhineh/features/home/models/food_type_model.dart';

abstract class IFoodTypeService {
  Future<ApiResult<List<FoodTypeModel>>> getFoodTypes();
}

class FoodTypeService implements IFoodTypeService {
  final Dio dio;

  FoodTypeService(this.dio);

  @override
  Future<ApiResult<List<FoodTypeModel>>> getFoodTypes() async {
    try {
      final response = await dio.get(ApiEndpoints.getFoodTypes);
      return ApiResult.fromJson(response.data, (_) => (response.data['data'] as List).map((e) => FoodTypeModel.fromJson(e)).toList());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return ApiResult(success: false, message: (e.error as NetworkException).message);
      } else {
        return ApiResult(success: false, message: ErrorMessage.unknownError);
      }
    }
  }
}
