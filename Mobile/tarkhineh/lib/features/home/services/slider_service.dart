import 'package:dio/dio.dart';
import 'package:tarkhineh/core/constants/api_endpoints.dart';
import 'package:tarkhineh/core/constants/error_message.dart';
import 'package:tarkhineh/core/exception/network_exception.dart';
import 'package:tarkhineh/core/models/api_result.dart';
import 'package:tarkhineh/features/home/models/slider_model.dart';

abstract class ISliderService {
  Future<ApiResult<List<SliderModel>>> getSliders();
}

class SliderService implements ISliderService {
  final Dio dio;

  SliderService(this.dio);

  @override
  Future<ApiResult<List<SliderModel>>> getSliders() async {
    try {
      final response = await dio.get(ApiEndpoints.getSliders);
      return ApiResult.fromJson(response.data, (_) => (response.data['data'] as List).map((e) => SliderModel.fromJson(e)).toList());
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        return ApiResult(success: false, message: (e.error as NetworkException).message);
      } else {
        return ApiResult(success: false, message: ErrorMessage.unknownError);
      }
    }
  }
}
