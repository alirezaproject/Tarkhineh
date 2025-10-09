class ApiEndpoints {
  static const baseUrl = 'http://10.0.2.2:3000/api/v1';
  static const sendOtp = '$baseUrl/Auth/send-otp';
  static const verifyOtp = '$baseUrl/Auth/verify-otp';
  static const login = '$baseUrl/auth/login';
  static const register = '$baseUrl/auth/register';
  static const foods = '$baseUrl/foods';
}
