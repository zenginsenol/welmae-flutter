import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  UserModel? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  // Initialize auth state
  Future<void> initializeAuth() async {
    _setLoading(true);
    
    try {
      _isAuthenticated = await _authService.isAuthenticated();
      
      if (_isAuthenticated) {
        // TODO: Fetch current user data from API or storage
        // For now, we'll load it when needed
      }
    } catch (e) {
      debugPrint('Auth initialization error: $e');
      _isAuthenticated = false;
    } finally {
      _setLoading(false);
    }
  }

  // Request OTP for phone number
  Future<ApiResponse<OtpRequestResult>> requestOtp(String phone) async {
    _setLoading(true);
    
    try {
      final result = await _authService.requestOtp(phone);
      return result;
    } finally {
      _setLoading(false);
    }
  }

  // Verify OTP and authenticate
  Future<ApiResponse<AuthResult>> verifyOtpAndAuth({
    required String phone,
    required String code,
    Map<String, dynamic>? userDetails,
  }) async {
    _setLoading(true);
    
    try {
      final result = await _authService.verifyOtpAndAuth(
        phone: phone,
        code: code,
        userDetails: userDetails,
      );
      
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

  // Update user details (for onboarding)
  Future<ApiResponse<UserModel>> updateUserDetails({
    required String firstName,
    required String lastName,
    String? gender,
    String? location,
  }) async {
    _setLoading(true);
    
    try {
      // Re-authenticate with user details
      if (_currentUser != null) {
        final result = await _authService.verifyOtpAndAuth(
          phone: _currentUser!.phone,
          code: '', // This might need to be handled differently
          userDetails: {
            'firstName': firstName,
            'lastName': lastName,
            if (gender != null) 'gender': gender,
            if (location != null) 'location': location,
          },
        );
        
        if (result.success && result.data != null) {
          _currentUser = result.data!.user;
          notifyListeners();
          return ApiResponse.success(_currentUser!);
        } else {
          return ApiResponse.error(result.error ?? 'Failed to update user details');
        }
      } else {
        return ApiResponse.error('No authenticated user');
      }
    } catch (e) {
      return ApiResponse.error('Failed to update user details: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Logout
  Future<void> logout() async {
    _setLoading(true);
    
    try {
      await _authService.logout();
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
      _isAuthenticated = await _authService.isAuthenticated();
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