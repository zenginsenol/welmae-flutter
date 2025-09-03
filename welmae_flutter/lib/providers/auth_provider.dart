import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

// Re-export the models for convenience
export '../services/api_service.dart' show ApiResponse, User, UserProfile;

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  User? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  // Getters
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  // Initialize auth state
  Future<void> initializeAuth() async {
    _setLoading(true);

    try {
      // Check if we have a stored token
      final token = await _getToken();
      _isAuthenticated = token != null;

      if (_isAuthenticated) {
        // Try to fetch current user profile
        await fetchCurrentUser();
      }
    } catch (e) {
      debugPrint('Auth initialization error: $e');
      _isAuthenticated = false;
    } finally {
      _setLoading(false);
    }
  }

  // Request OTP for phone number
  Future<ApiResponse<AuthResponse>> requestOtp(String phone) async {
    _setLoading(true);

    try {
      final result = await _apiService.requestOtp(phone);
      return result;
    } finally {
      _setLoading(false);
    }
  }

  // Verify OTP and authenticate
  Future<ApiResponse<AuthResponse>> verifyOtp({
    required String phone,
    required String code,
  }) async {
    _setLoading(true);

    try {
      final result = await _apiService.verifyOtp(phone: phone, code: code);

      if (result.success && result.data != null) {
        _currentUser = result.data!.user;
        _isAuthenticated = true;
        notifyListeners();
      }

      return result;
    } finally {
      _setLoading(false);
    }
  }

  // Fetch current user profile
  Future<ApiResponse<UserProfile>> fetchCurrentUser() async {
    _setLoading(true);

    try {
      final result = await _apiService.getProfile();

      if (result.success && result.data != null) {
        // Update current user with profile data if needed
        // For now, we'll just return the profile data
        return result;
      } else {
        return ApiResponse.error(result.error ?? 'Failed to fetch profile');
      }
    } finally {
      _setLoading(false);
    }
  }

  // Update user profile
  Future<ApiResponse<UserProfile>> updateUserProfile({
    String? firstName,
    String? lastName,
    String? bio,
    String? location,
    String? gender,
    DateTime? birthDate,
    List<String>? interests,
    Map<String, dynamic>? socialLinks,
  }) async {
    _setLoading(true);

    try {
      final profileData = <String, dynamic>{};

      if (firstName != null) profileData['firstName'] = firstName;
      if (lastName != null) profileData['lastName'] = lastName;
      if (bio != null) profileData['bio'] = bio;
      if (location != null) profileData['location'] = location;
      if (gender != null) profileData['gender'] = gender;
      if (birthDate != null)
        profileData['birthDate'] = birthDate.toIso8601String();
      if (interests != null) profileData['interests'] = interests;
      if (socialLinks != null) profileData['socialLinks'] = socialLinks;

      final result = await _apiService.updateUserProfile(profileData);

      if (result.success && result.data != null) {
        // Update current user with new profile data
        notifyListeners();
        return result;
      } else {
        return ApiResponse.error(result.error ?? 'Failed to update profile');
      }
    } finally {
      _setLoading(false);
    }
  }

  // Logout
  Future<void> logout() async {
    _setLoading(true);

    try {
      await _apiService.logout();
      _currentUser = null;
      _isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Check authentication status
  Future<bool> checkAuthStatus() async {
    try {
      final token = await _getToken();
      _isAuthenticated = token != null;
      return _isAuthenticated;
    } catch (e) {
      debugPrint('Check auth status error: $e');
      return false;
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  Future<String?> _getToken() async {
    // This would typically use the same storage mechanism as ApiService
    // For now, we'll simulate it
    return 'mock_token'; // In real implementation, this would come from secure storage
  }

  // Get user tier display name
  String getUserTierDisplayName() {
    if (_currentUser == null) return 'Bronze';

    switch (_currentUser!.tier.toLowerCase()) {
      case 'bronze':
        return 'Bronze';
      case 'silver':
        return 'Silver';
      case 'gold':
        return 'Gold';
      default:
        return 'Bronze';
    }
  }

  // Get user trust level description
  String getUserTrustDescription() {
    if (_currentUser == null) return 'Yeni Üye';

    final score = _currentUser!.trustScore;
    if (score >= 50) {
      return 'Güvenilir Seyyah';
    } else if (score >= 20) {
      return 'Deneyimli Üye';
    } else if (score >= 5) {
      return 'Aktif Üye';
    } else {
      return 'Yeni Üye';
    }
  }
}
