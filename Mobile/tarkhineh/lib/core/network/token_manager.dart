// core/network/token_manager.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tarkhineh/core/constants/api_endpoints.dart';

import '../storage/secure_storage_service.dart';

class TokenManager {
  final SecureStorageService storage;

  TokenManager({required this.storage});

  Future<String?> refreshAccessToken(Dio dio) async {
    final refreshToken = await storage.getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final response = await dio.post(ApiEndpoints.refreshToken, data: {'refreshToken': refreshToken});

      final newAccess = response.data['accessToken'];
      final newRefresh = response.data['refreshToken'];
      await storage.saveJwt(newAccess, newRefresh);

      return newAccess;
    } on DioException catch (e) {
      // اگر refresh fail شد، پاک و logout کن
      log('Failed to refresh token: ${e.message}');
      await storage.clearTokens();
      return null;
    }
  }
}
