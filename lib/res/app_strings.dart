

class AppStrings {
  static const String appName = 'Esalerz';
  
  static const String interSans = 'InterSans';
  static const String montserrat = 'Montserrat';
  static const String urbanist = 'Urbanist';

  static const String networkErrorMessage = "Network error, try again later";

  /// Base
  static const String mainBaseUrl = 'https://premiumesowp.com/esellers/api';
  
  
  /// User Endpoints
  static const String registerUrl = '$mainBaseUrl/register';
  static const String loginUrl = '$mainBaseUrl/login';
  static const String createKycUrl = '$mainBaseUrl/create_kyc';
  static   String getNotifyUrl(String token) => '$mainBaseUrl/get_notifications?bkey=$token';
  static   String getAllProductsUrl(String token) => '$mainBaseUrl/get_all_ads?bkey=$token'; 
  static   String getNotifyDetailsUrl(String token, String id) => '$mainBaseUrl/notification?id=$id&bkey=$token';
}