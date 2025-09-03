class ApiConfig {
  // Environment Configuration
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  // Base URLs for different environments
  static const Map<String, String> _baseUrls = {
    'development': 'http://localhost:3000',
    'staging': 'https://staging-api.welmae.com',
    'production': 'https://api.welmae.com',
  };

  // WebSocket URLs for different environments
  static const Map<String, String> _wsUrls = {
    'development': 'ws://localhost:3000',
    'staging': 'wss://staging-api.welmae.com',
    'production': 'wss://api.welmae.com',
  };

  // Get base URL for current environment
  static String get baseUrl =>
      _baseUrls[environment] ?? _baseUrls['development']!;

  // Get WebSocket URL for current environment
  static String get wsUrl => _wsUrls[environment] ?? _wsUrls['development']!;

  // API Version
  static const String apiVersion = 'v1';
  static const String apiPath = '/api';

  // Complete API base URL
  static String get apiBaseUrl => '$baseUrl$apiPath';

  // Authentication Endpoints
  static String get loginUrl => '$apiBaseUrl/auth/login';
  static String get registerUrl => '$apiBaseUrl/auth/register';
  static String get logoutUrl => '$apiBaseUrl/auth/logout';
  static String get refreshTokenUrl => '$apiBaseUrl/auth/refresh';
  static String get forgotPasswordUrl => '$apiBaseUrl/auth/forgot-password';
  static String get resetPasswordUrl => '$apiBaseUrl/auth/reset-password';
  static String get verifyOtpUrl => '$apiBaseUrl/auth/verify-otp';
  static String get sendOtpUrl => '$apiBaseUrl/auth/send-otp';

  // User Endpoints
  static String get usersUrl => '$apiBaseUrl/users';
  static String get profileUrl => '$apiBaseUrl/users/profile';
  static String get updateProfileUrl => '$apiBaseUrl/users/profile';
  static String get uploadAvatarUrl => '$apiBaseUrl/users/avatar';

  // Travel Endpoints
  static String get travelsUrl => '$apiBaseUrl/travels';
  static String get createTravelUrl => '$apiBaseUrl/travels';

  // Posts Endpoints
  static String get postsUrl => '$apiBaseUrl/posts';
  static String get createPostUrl => '$apiBaseUrl/posts';

  // Messaging Endpoints
  static String get messagesUrl => '$apiBaseUrl/messages';
  static String get sendMessageUrl => '$apiBaseUrl/messages';

  // Notifications Endpoints
  static String get notificationsUrl => '$apiBaseUrl/notifications';

  // Destinations Endpoints
  static String get destinationsUrl => '$apiBaseUrl/destinations';

  // Tiers and Purchases
  static String get tiersUrl => '$apiBaseUrl/tiers';
  static String get purchasesUrl => '$apiBaseUrl/purchases';

  // Confirmations
  static String get confirmationsUrl => '$apiBaseUrl/confirmations';

  // Health Check
  static String get healthUrl => '$baseUrl/health';

  // Request Configuration
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // File Upload Configuration
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
  ];
  static const List<String> allowedVideoTypes = ['mp4', 'avi', 'mov', 'wmv'];

  // Pagination Configuration
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache Configuration
  static const int cacheMaxAge = 300; // 5 minutes
  static const int offlineMaxAge = 86400; // 24 hours

  // Helper methods for building URLs with parameters
  static String getUserUrl(String userId) => '$usersUrl/$userId';
  static String getTravelUrl(String travelId) => '$travelsUrl/$travelId';
  static String getPostUrl(String postId) => '$postsUrl/$postId';
  static String getTravelMessagesUrl(String travelId) =>
      '$messagesUrl/travel/$travelId';

  // Headers
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': 'Welmae-Flutter-App/1.0.0',
  };

  static Map<String, String> getAuthHeaders(String token) => {
    ...defaultHeaders,
    'Authorization': 'Bearer $token',
  };

  static Map<String, String> get multipartHeaders => {
    'Content-Type': 'multipart/form-data',
    'Accept': 'application/json',
    'User-Agent': 'Welmae-Flutter-App/1.0.0',
  };

  // Environment checks
  static bool get isDevelopment => environment == 'development';
  static bool get isStaging => environment == 'staging';
  static bool get isProduction => environment == 'production';

  // Debug configuration
  static bool get enableLogging => isDevelopment || isStaging;
  static bool get enableDetailedErrors => isDevelopment;
}
