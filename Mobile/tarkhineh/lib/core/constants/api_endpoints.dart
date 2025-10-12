class ApiEndpoints {
  static const baseUrl = 'http://10.0.2.2:3000/api/v1';

  //auth
  static const sendOtp = '$baseUrl/Auth/send-otp';
  static const verifyOtp = '$baseUrl/Auth/verify-otp';

  // slider
  static const getSliders = '$baseUrl/Slider';
}
