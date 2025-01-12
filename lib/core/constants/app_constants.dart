class AppConstants {
  static const String appName = 'Ezy Course';
  static const String loginAppBaseUrl = 'https://ezycourse.com';
  static const String appBaseUrl = 'https://iap.ezycourse.com';
  static const String loginUri = "/api/app/student/auth/login";
  static const String newsfeedUri = "/api/app/teacher/community/getFeed";
  static const String createPostUri = "/api/app/teacher/community/createFeedWithUpload?";
  static const String getCommentUri = "/api/app/student/comment/getComment/";
  static const String createCommentUri = "/api/app/student/comment/createComment";
  static const String createReactionUri = "/api/app/teacher/community/createLike";
  static const String getReeactionUri = "/api/app/teacher/community/getAllReactionType?feed_id=";
  static const String fetchReplyUri = "/api/app/student/comment/getReply/";


  // Shared Preferences
  static String token = 'token';
  static String email = 'email';
  static String password = 'password';

}