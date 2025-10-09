class ApiResult<T> {
  final bool success;
  final String? message;
  final T? data;

  ApiResult({required this.success, this.message, this.data});

  factory ApiResult.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResult<T>(success: json['success'] ?? false, message: json['message'], data: json['data'] != null ? fromJsonT(json['data']) : null);
  }
}
