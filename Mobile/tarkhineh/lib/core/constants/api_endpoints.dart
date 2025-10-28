class ApiEndpoints {
  static const baseUrl = 'http://10.0.2.2:3000/api/v1';

  //auth
  static const sendOtp = '$baseUrl/Auth/send-otp';
  static const verifyOtp = '$baseUrl/Auth/verify-otp';
  static const refreshToken = '$baseUrl/Auth/refresh';

  // branch
  static const getBranches = '$baseUrl/Branch';

  // slider
  static const getSliders = '$baseUrl/Slider';

  // food type
  static const getFoodTypes = '$baseUrl/FoodType';

  // Food
  static const getSpecialFoods = '$baseUrl/Food/specials';
  static const getPopularFoods = '$baseUrl/Food/popular';
}
