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
  static const String createFeedbackUrl = '$mainBaseUrl/create_feedback';
  static const String likePost = '$mainBaseUrl/like_product';
  static const String reportAd = '$mainBaseUrl/report_ad';
  static const String saveProduct = '$mainBaseUrl/save_product';
  static const String removeSavedProduct = '$mainBaseUrl/remove_saved_products';

  static String unLikePost(String token, String tokenId) =>
      '$mainBaseUrl/remove_like?ad_id=$tokenId';
  static String getNotifyUrl(String token) =>
      '$mainBaseUrl/get_notifications?';
  static String getAllProductsUrl(String token) =>
      '$mainBaseUrl/get_all_ads?';
  static String getProductDetailsUrl(String token, String adId) =>
      '$mainBaseUrl/get_ad?ad_id=$adId';
  static String getNotifyDetailsUrl(String token, String id) =>
      '$mainBaseUrl/notification?id=$id';
  static String getFeedbackUrl(String token, String id) =>
      '$mainBaseUrl/get_feedbacks?ad_id=$id';
  static String getAllCategories(
    String token,
  ) =>
      '$mainBaseUrl/get_categories?';
  static String getSubCategories(String token, String catId) =>
      '$mainBaseUrl/get_sub_category?parent_id=$catId';
  static const String sendResetToken = '$mainBaseUrl/send_verify_token';
  static const String confirmToken = '$mainBaseUrl/verify_email_token';
  static const String resetPassword = '$mainBaseUrl/reset_password';
  static const String sendChatUrl = '$mainBaseUrl/send_message';
  static String getChatMessages(String bkey, String receiver) =>
      '$mainBaseUrl/get_chat?receiver=$receiver';
  static String getChatConversations(String bkey) =>
      '$mainBaseUrl/get_conversations?';
 static String getAllServices(String bkey) =>
      '$mainBaseUrl/get_services?';

  static String getServicesSubCat(String bkey, String serviceId) =>
      '$mainBaseUrl/sub_service?service_parent=$serviceId';

      static String getAdsOptions(String bkey, String catId) =>
      '$mainBaseUrl/get_param_options?categ_id=$catId';
     static String createPostAds =
      '$mainBaseUrl/create_ad';
    
}
