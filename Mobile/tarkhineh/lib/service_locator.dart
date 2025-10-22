import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:tarkhineh/core/constants/api_endpoints.dart';
import 'package:tarkhineh/core/network/auth_interceptor.dart';
import 'package:tarkhineh/core/network/custom_api_interceptor.dart';
import 'package:tarkhineh/core/network/token_manager.dart';
import 'package:tarkhineh/core/storage/secure_storage_service.dart';
import 'package:tarkhineh/features/home/services/food_type_service.dart';
import 'package:tarkhineh/features/home/services/slider_service.dart';
import '../../features/auth/services/auth_service.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton(() => SecureStorageService());
  sl.registerLazySingleton<TokenManager>(() => TokenManager(storage: sl<SecureStorageService>()));
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(AuthInterceptor(dio: dio, storage: sl<SecureStorageService>(), tokenManager: sl<TokenManager>()));
    dio.interceptors.add(CustomApiInterceptor());
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });

  sl.registerLazySingleton<IAuthService>(() => AuthService(sl<Dio>()));
  sl.registerLazySingleton<ISliderService>(() => SliderService(sl<Dio>()));
  sl.registerLazySingleton<IFoodTypeService>(() => FoodTypeService(sl<Dio>()));
}
