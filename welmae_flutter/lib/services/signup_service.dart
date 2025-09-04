import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignupService {
  static const String baseUrl = 'http://localhost:3000/api'; // Backend URL
  static const _storage = FlutterSecureStorage();

  // Complete signup process
  static Future<SignupResponse> completeSignup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String country,
    required String city,
    required String birthdate,
    String? bio,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'country': country,
          'city': city,
          'birthdate': birthdate,
          'bio': bio,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        
        // Save user data to secure storage
        await _storage.write(key: 'access_token', value: data['token']);
        await _storage.write(key: 'user_id', value: data['user']['id'].toString());
        await _storage.write(key: 'user_data', value: jsonEncode(data['user']));
        
        return SignupResponse.success(
          message: data['message'] ?? 'Hesap başarıyla oluşturuldu',
          user: UserData.fromJson(data['user']),
          token: data['token'],
        );
      } else {
        final error = jsonDecode(response.body);
        return SignupResponse.error(
          message: error['message'] ?? 'Hesap oluşturulurken bir hata oluştu',
        );
      }
    } catch (e) {
      return SignupResponse.error(
        message: 'Bağlantı hatası. Lütfen internet bağlantınızı kontrol edin.',
      );
    }
  }

  // Send OTP for phone verification
  static Future<OtpResponse> sendOtp(String phone) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/send-otp'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return OtpResponse.success(
          message: data['message'] ?? 'OTP gönderildi',
        );
      } else {
        final error = jsonDecode(response.body);
        return OtpResponse.error(
          message: error['message'] ?? 'OTP gönderilirken bir hata oluştu',
        );
      }
    } catch (e) {
      return OtpResponse.error(
        message: 'Bağlantı hatası. Lütfen internet bağlantınızı kontrol edin.',
      );
    }
  }

  // Verify OTP
  static Future<OtpResponse> verifyOtp(String phone, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/verify-otp'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'phone': phone,
          'otp': otp,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return OtpResponse.success(
          message: data['message'] ?? 'OTP doğrulandı',
        );
      } else {
        final error = jsonDecode(response.body);
        return OtpResponse.error(
          message: error['message'] ?? 'Geçersiz OTP',
        );
      }
    } catch (e) {
      return OtpResponse.error(
        message: 'Bağlantı hatası. Lütfen internet bağlantınızı kontrol edin.',
      );
    }
  }

  // Check if email exists
  static Future<bool> checkEmailExists(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/check-email?email=$email'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['exists'] ?? false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Check if phone exists
  static Future<bool> checkPhoneExists(String phone) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/check-phone?phone=$phone'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['exists'] ?? false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

// Response classes
class SignupResponse {
  final bool success;
  final String message;
  final UserData? user;
  final String? token;

  SignupResponse({
    required this.success,
    required this.message,
    this.user,
    this.token,
  });

  factory SignupResponse.success({
    required String message,
    required UserData user,
    required String token,
  }) {
    return SignupResponse(
      success: true,
      message: message,
      user: user,
      token: token,
    );
  }

  factory SignupResponse.error({
    required String message,
  }) {
    return SignupResponse(
      success: false,
      message: message,
    );
  }
}

class OtpResponse {
  final bool success;
  final String message;

  OtpResponse({
    required this.success,
    required this.message,
  });

  factory OtpResponse.success({
    required String message,
  }) {
    return OtpResponse(
      success: true,
      message: message,
    );
  }

  factory OtpResponse.error({
    required String message,
  }) {
    return OtpResponse(
      success: false,
      message: message,
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String country;
  final String city;
  final String birthdate;
  final String? bio;
  final DateTime createdAt;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.city,
    required this.birthdate,
    this.bio,
    required this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      country: json['country'],
      city: json['city'],
      birthdate: json['birthdate'],
      bio: json['bio'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'country': country,
      'city': city,
      'birthdate': birthdate,
      'bio': bio,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
