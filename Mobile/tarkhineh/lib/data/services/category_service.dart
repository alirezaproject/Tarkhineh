import 'package:dio/dio.dart';
import 'package:tarkhineh/core/constants/api_endpoints.dart';
import 'package:tarkhineh/core/constants/error_message.dart';
import 'package:tarkhineh/core/exception/network_exception.dart';
import 'package:tarkhineh/core/models/api_result.dart';
import 'package:tarkhineh/core/models/category_model.dart';

abstract class ICategoryService {
  Future<ApiResult<List<CategoryModel>>> fetchCategories(String foodTypeId);
}

class CategoryService implements ICategoryService {
  final Dio dio;

  CategoryService(this.dio);

  @override
  Future<ApiResult<List<CategoryModel>>> fetchCategories(
    String foodTypeId,
  ) async {
    try {
      final response = await dio.get(
        "${ApiEndpoints.getCategoriesByFoodTypeId}/$foodTypeId",
      );
      return ApiResult.fromJson(
        response.data,
        (_) => (response.data['data'] as List)
            .map((e) => CategoryModel.fromJson(e))
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
