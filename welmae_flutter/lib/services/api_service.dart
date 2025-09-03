import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';
  static const _storage = FlutterSecureStorage();

  late Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for authentication and error handling
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token to requests if available
          final token = await _getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (DioException error, handler) {
          print('API Error: ${error.response?.data}');
          handler.next(error);
        },
      ),
    );
  }

  // Auth endpoints
  Future<ApiResponse<AuthResponse>> requestOtp(String phone) async {
    try {
      final response = await _dio.post(
        '/auth/request-otp',
        data: {'phone': phone},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(
          AuthResponse.fromJson(response.data['data']),
          response.data['message'],
        );
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to send OTP',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  Future<ApiResponse<AuthResponse>> verifyOtp({
    required String phone,
    required String code,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/verify-otp',
        data: {'phone': phone, 'code': code},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResponse = AuthResponse.fromJson(response.data['data']);

        // Store tokens securely
        await _storage.write(key: 'auth_token', value: authResponse.token);
        await _storage.write(
          key: 'refresh_token',
          value: authResponse.refreshToken,
        );
        await _storage.write(key: 'user_id', value: authResponse.user.id);

        return ApiResponse.success(authResponse, response.data['message']);
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to verify OTP',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  // Signup endpoint
  Future<ApiResponse<AuthResponse>> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String birthDate,
    required String bio,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/signup',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'birthDate': birthDate,
          'bio': bio,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResponse = AuthResponse.fromJson(response.data['data']);

        // Store tokens securely
        await _storage.write(key: 'auth_token', value: authResponse.token);
        await _storage.write(
          key: 'refresh_token',
          value: authResponse.refreshToken,
        );
        await _storage.write(key: 'user_id', value: authResponse.user.id);

        return ApiResponse.success(authResponse, response.data['message']);
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to signup',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  Future<ApiResponse<UserProfile>> updateUserProfile(
    Map<String, dynamic> profileData,
  ) async {
    try {
      final response = await _dio.put('/users/profile', data: profileData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(
          UserProfile.fromJson(response.data['data']),
          response.data['message'],
        );
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to update profile',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  // Trip endpoints
  Future<ApiResponse<List<Trip>>> getTrips({
    Map<String, dynamic>? filters,
  }) async {
    try {
      final response = await _dio.get('/trips', queryParameters: filters);

      if (response.statusCode == 200) {
        final List<Trip> trips = (response.data['data'] as List)
            .map((item) => Trip.fromJson(item))
            .toList();

        return ApiResponse.success(trips, response.data['message']);
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to fetch trips',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  Future<ApiResponse<Trip>> createTrip(Map<String, dynamic> tripData) async {
    try {
      final response = await _dio.post('/trips', data: tripData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(
          Trip.fromJson(response.data['data']),
          response.data['message'],
        );
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to create trip',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  Future<ApiResponse<Trip>> updateTrip(
    String tripId,
    Map<String, dynamic> tripData,
  ) async {
    try {
      final response = await _dio.put('/trips/$tripId', data: tripData);

      if (response.statusCode == 200) {
        return ApiResponse.success(
          Trip.fromJson(response.data['data']),
          response.data['message'],
        );
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to update trip',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  Future<ApiResponse<void>> deleteTrip(String tripId) async {
    try {
      final response = await _dio.delete('/trips/$tripId');

      if (response.statusCode == 200) {
        return ApiResponse.success(null, response.data['message']);
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to delete trip',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  // Messaging endpoints
  Future<ApiResponse<List<Message>>> getMessages(String tripId) async {
    try {
      final response = await _dio.get('/messages/trip/$tripId');

      if (response.statusCode == 200) {
        final List<Message> messages = (response.data['data'] as List)
            .map((item) => Message.fromJson(item))
            .toList();

        return ApiResponse.success(messages, response.data['message']);
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to fetch messages',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  Future<ApiResponse<Message>> sendMessage(
    Map<String, dynamic> messageData,
  ) async {
    try {
      final response = await _dio.post('/messages', data: messageData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(
          Message.fromJson(response.data['data']),
          response.data['message'],
        );
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to send message',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  // Profile endpoints
  Future<ApiResponse<UserProfile>> getProfile() async {
    try {
      final response = await _dio.get('/users/profile');

      if (response.statusCode == 200) {
        return ApiResponse.success(
          UserProfile.fromJson(response.data['data']),
          response.data['message'],
        );
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to fetch profile',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  // Subscription endpoints
  Future<ApiResponse<List<SubscriptionPlan>>> getSubscriptionPlans() async {
    try {
      final response = await _dio.get('/subscriptions/plans');

      if (response.statusCode == 200) {
        final List<SubscriptionPlan> plans = (response.data['data'] as List)
            .map((item) => SubscriptionPlan.fromJson(item))
            .toList();

        return ApiResponse.success(plans, response.data['message']);
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to fetch subscription plans',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  Future<ApiResponse<Subscription>> subscribeToPlan(String planId) async {
    try {
      final response = await _dio.post(
        '/subscriptions',
        data: {'planId': planId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(
          Subscription.fromJson(response.data['data']),
          response.data['message'],
        );
      } else {
        return ApiResponse.error(
          response.data['error'] ?? 'Failed to subscribe to plan',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Network error occurred');
    }
  }

  // Helper methods
  Future<String?> _getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }

  bool isNetworkError(Object error) {
    return error is SocketException ||
        (error is DioException &&
            (error.type == DioExceptionType.connectionTimeout ||
                error.type == DioExceptionType.receiveTimeout ||
                error.type == DioExceptionType.connectionError));
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Server is taking too long to respond.';
      case DioExceptionType.badResponse:
        if (e.response?.data != null && e.response?.data is Map) {
          final data = e.response!.data as Map<String, dynamic>;
          return data['error']?['message'] ?? 'Server error occurred.';
        }
        return 'Server error occurred.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.badCertificate:
        return 'SSL certificate error.';
      case DioExceptionType.unknown:
        return 'An unexpected error occurred.';
    }
  }
}

// Response wrapper
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final String? error;

  ApiResponse._({required this.success, this.data, this.message, this.error});

  factory ApiResponse.success(T data, [String? message]) {
    return ApiResponse._(success: true, data: data, message: message);
  }

  factory ApiResponse.error(String error) {
    return ApiResponse._(success: false, error: error);
  }
}

// Data models
class AuthResponse {
  final User user;
  final String token;
  final String refreshToken;
  final bool isNewUser;
  final bool requiresOnboarding;

  AuthResponse({
    required this.user,
    required this.token,
    required this.refreshToken,
    required this.isNewUser,
    required this.requiresOnboarding,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
      refreshToken: json['refreshToken'],
      isNewUser: json['isNewUser'] ?? false,
      requiresOnboarding: json['requiresOnboarding'] ?? false,
    );
  }
}

class User {
  final String id;
  final String phone;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String tier;
  final int trustScore;
  final bool isPhoneVerified;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime lastLoginAt;

  User({
    required this.id,
    required this.phone,
    this.firstName,
    this.lastName,
    this.email,
    required this.tier,
    required this.trustScore,
    required this.isPhoneVerified,
    this.profileImage,
    required this.createdAt,
    required this.lastLoginAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phone: json['phone'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      tier: json['tier'] ?? 'bronze',
      trustScore: json['trustScore'] ?? 0,
      isPhoneVerified: json['isPhoneVerified'] ?? false,
      profileImage: json['profileImage'],
      createdAt: DateTime.parse(json['createdAt']),
      lastLoginAt: DateTime.parse(json['lastLoginAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'tier': tier,
      'trustScore': trustScore,
      'isPhoneVerified': isPhoneVerified,
      'profileImage': profileImage,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt.toIso8601String(),
    };
  }
}

class UserProfile {
  final String id;
  final String userId;
  final String? bio;
  final String? location;
  final String? gender;
  final DateTime? birthDate;
  final List<String> interests;
  final Map<String, dynamic> socialLinks;
  final List<UserPhoto> photos;
  final List<UserTrip> trips;

  UserProfile({
    required this.id,
    required this.userId,
    this.bio,
    this.location,
    this.gender,
    this.birthDate,
    required this.interests,
    required this.socialLinks,
    required this.photos,
    required this.trips,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      userId: json['userId'],
      bio: json['bio'],
      location: json['location'],
      gender: json['gender'],
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'])
          : null,
      interests: List<String>.from(json['interests'] ?? []),
      socialLinks: Map<String, dynamic>.from(json['socialLinks'] ?? {}),
      photos:
          (json['photos'] as List?)
              ?.map((p) => UserPhoto.fromJson(p))
              .toList() ??
          [],
      trips:
          (json['trips'] as List?)?.map((t) => UserTrip.fromJson(t)).toList() ??
          [],
    );
  }
}

class UserPhoto {
  final String id;
  final String url;
  final String? caption;
  final DateTime createdAt;
  final List<String> tags;

  UserPhoto({
    required this.id,
    required this.url,
    this.caption,
    required this.createdAt,
    required this.tags,
  });

  factory UserPhoto.fromJson(Map<String, dynamic> json) {
    return UserPhoto(
      id: json['id'],
      url: json['url'],
      caption: json['caption'],
      createdAt: DateTime.parse(json['createdAt']),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}

class UserTrip {
  final String id;
  final String title;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  UserTrip({
    required this.id,
    required this.title,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory UserTrip.fromJson(Map<String, dynamic> json) {
    return UserTrip(
      id: json['id'],
      title: json['title'],
      destination: json['destination'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
    );
  }
}

class Trip {
  final String id;
  final String title;
  final String description;
  final String type; // 'sponsor' or 'guide'
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final double budget;
  final String status;
  final String ownerId;
  final List<String> participantIds;
  final List<TripPhoto> photos;
  final DateTime createdAt;

  Trip({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.budget,
    required this.status,
    required this.ownerId,
    required this.participantIds,
    required this.photos,
    required this.createdAt,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      destination: json['destination'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      budget: (json['budget'] as num).toDouble(),
      status: json['status'],
      ownerId: json['ownerId'],
      participantIds: List<String>.from(json['participantIds'] ?? []),
      photos:
          (json['photos'] as List?)
              ?.map((p) => TripPhoto.fromJson(p))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class TripPhoto {
  final String id;
  final String url;
  final String? caption;
  final DateTime uploadedAt;

  TripPhoto({
    required this.id,
    required this.url,
    this.caption,
    required this.uploadedAt,
  });

  factory TripPhoto.fromJson(Map<String, dynamic> json) {
    return TripPhoto(
      id: json['id'],
      url: json['url'],
      caption: json['caption'],
      uploadedAt: DateTime.parse(json['uploadedAt']),
    );
  }
}

class Message {
  final String id;
  final String tripId;
  final String senderId;
  final String content;
  final DateTime sentAt;
  final bool isRead;

  Message({
    required this.id,
    required this.tripId,
    required this.senderId,
    required this.content,
    required this.sentAt,
    required this.isRead,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      tripId: json['tripId'],
      senderId: json['senderId'],
      content: json['content'],
      sentAt: DateTime.parse(json['sentAt']),
      isRead: json['isRead'] ?? false,
    );
  }
}

class SubscriptionPlan {
  final String id;
  final String name;
  final String description;
  final double price;
  final String currency;
  final int durationDays;
  final List<String> features;
  final List<String> limitations;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.durationDays,
    required this.features,
    required this.limitations,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      currency: json['currency'],
      durationDays: json['durationDays'],
      features: List<String>.from(json['features'] ?? []),
      limitations: List<String>.from(json['limitations'] ?? []),
    );
  }
}

class Subscription {
  final String id;
  final String userId;
  final String planId;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final String status;

  Subscription({
    required this.id,
    required this.userId,
    required this.planId,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.status,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      userId: json['userId'],
      planId: json['planId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      isActive: json['isActive'] ?? false,
      status: json['status'],
    );
  }
}
