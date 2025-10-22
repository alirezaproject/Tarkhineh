class ApiEndpoints {
  static const baseUrl = 'http://10.0.2.2:3000/api/v1';

  static const healthCheck = 'http://10.0.2.2:3000/health';

  //auth
  static const sendOtp = '$baseUrl/Auth/send-otp';
  static const verifyOtp = '$baseUrl/Auth/verify-otp';
  static const refreshToken = '$baseUrl/Auth/refresh';

  // slider
  static const getSliders = '$baseUrl/Slider';

  // food type
  static const getFoodTypes = '$baseUrl/FoodType';
}
