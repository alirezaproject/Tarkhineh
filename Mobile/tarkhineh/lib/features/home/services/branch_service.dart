import 'package:dio/dio.dart';
import 'package:tarkhineh/core/constants/api_endpoints.dart';
import 'package:tarkhineh/core/constants/error_message.dart';
import 'package:tarkhineh/core/exception/network_exception.dart';
import 'package:tarkhineh/core/models/api_result.dart';
import 'package:tarkhineh/features/home/models/branch_model.dart';

abstract class IBranchService {
  Future<ApiResult<List<BranchModel>>> getBranches();
}

class BranchService implements IBranchService {
  final Dio dio;

  BranchService(this.dio);

  

  @override
  Future<ApiResult<List<BranchModel>>> getBranches() async{
   try {
      final response = await dio.get(ApiEndpoints.getBranches);
      return ApiResult.fromJson(
        response.data,
        (_) => (response.data['data'] as List)
            .map((e) => BranchModel.fromJson(e))
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
