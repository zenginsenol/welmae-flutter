import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? profileImage;
  final String? phoneNumber;
  final DateTime createdAt;
  final DateTime lastLoginAt;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final List<String> preferences;
  final Map<String, dynamic> profile;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profileImage,
    this.phoneNumber,
    required this.createdAt,
    required this.lastLoginAt,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.preferences = const [],
    this.profile = const {},
  });

  String get fullName => '$firstName $lastName';
  String get name => fullName; // Alias for fullName
  String get displayName =>
      firstName.isNotEmpty ? firstName : email.split('@').first;
  String get initials =>
      '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
          .toUpperCase();

  // Security-related getters
  bool get isTwoFactorEnabled =>
      profile['isTwoFactorEnabled'] as bool? ?? false;
  bool get isBiometricEnabled =>
      profile['isBiometricEnabled'] as bool? ?? false;
  bool get isFaceIdEnabled => profile['isFaceIdEnabled'] as bool? ?? false;
  bool get isFingerprintEnabled =>
      profile['isFingerprintEnabled'] as bool? ?? false;
  bool get isLoginNotificationsEnabled =>
      profile['isLoginNotificationsEnabled'] as bool? ?? true;
  bool get isSessionTimeoutEnabled =>
      profile['isSessionTimeoutEnabled'] as bool? ?? true;
  int get sessionTimeoutMinutes =>
      profile['sessionTimeoutMinutes'] as int? ?? 30;

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? profileImage,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    List<String>? preferences,
    Map<String, dynamic>? profile,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      preferences: preferences ?? this.preferences,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt.toIso8601String(),
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'preferences': preferences,
      'profile': profile,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      profileImage: json['profileImage'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: DateTime.parse(json['lastLoginAt'] as String),
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      preferences: List<String>.from(json['preferences'] ?? []),
      profile: Map<String, dynamic>.from(json['profile'] ?? {}),
    );
  }
}

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;
  User? get user => _currentUser; // Alias for currentUser

  bool get isLoggedIn => _currentUser != null;
  bool get isGuest => _currentUser == null;

  // Kullanıcı profili
  Map<String, dynamic> get userProfile => _currentUser?.profile ?? {};

  // Kullanıcı tercihleri
  List<String> get userPreferences => _currentUser?.preferences ?? [];

  // Kullanıcı giriş yap
  Future<bool> login(String email, String password) async {
    try {
      // Simüle edilmiş giriş işlemi
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        firstName: 'Kullanıcı',
        lastName: 'Adı',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        lastLoginAt: DateTime.now(),
        isEmailVerified: true,
        preferences: ['travel', 'adventure', 'culture'],
        profile: {
          'bio': 'Seyahat tutkunu',
          'location': 'İstanbul, Türkiye',
          'birthDate': '1990-01-01',
          'interests': ['seyahat', 'fotoğrafçılık', 'yemek'],
          'socialLinks': {'instagram': '@user', 'twitter': '@user'},
        },
      );

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Kullanıcı kayıt ol
  Future<bool> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      // Simüle edilmiş kayıt işlemi
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        firstName: firstName,
        lastName: lastName,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
        isEmailVerified: false,
        preferences: [],
        profile: {
          'bio': '',
          'location': '',
          'birthDate': '',
          'interests': [],
          'socialLinks': {},
        },
      );

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Kullanıcı çıkış yap
  Future<void> logout() async {
    _currentUser = null;
    notifyListeners();
  }

  // Kullanıcı profilini güncelle
  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? profileImage,
    String? phoneNumber,
    Map<String, dynamic>? profile,
  }) async {
    if (_currentUser == null) return false;

    try {
      _currentUser = _currentUser!.copyWith(
        firstName: firstName,
        lastName: lastName,
        profileImage: profileImage,
        phoneNumber: phoneNumber,
        profile: profile ?? _currentUser!.profile,
      );

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Kullanıcı tercihlerini güncelle
  Future<bool> updatePreferences(List<String> preferences) async {
    if (_currentUser == null) return false;

    try {
      _currentUser = _currentUser!.copyWith(preferences: preferences);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Tercih ekle
  Future<bool> addPreference(String preference) async {
    if (_currentUser == null) return false;

    try {
      final newPreferences = List<String>.from(_currentUser!.preferences);
      if (!newPreferences.contains(preference)) {
        newPreferences.add(preference);
        _currentUser = _currentUser!.copyWith(preferences: newPreferences);
        notifyListeners();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // Tercih kaldır
  Future<bool> removePreference(String preference) async {
    if (_currentUser == null) return false;

    try {
      final newPreferences = List<String>.from(_currentUser!.preferences);
      newPreferences.remove(preference);
      _currentUser = _currentUser!.copyWith(preferences: newPreferences);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Profil bilgisi güncelle
  Future<bool> updateProfileInfo(String key, dynamic value) async {
    if (_currentUser == null) return false;

    try {
      final newProfile = Map<String, dynamic>.from(_currentUser!.profile);
      newProfile[key] = value;
      _currentUser = _currentUser!.copyWith(profile: newProfile);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Profil resmi güncelle
  Future<bool> updateProfileImage(String imageUrl) async {
    if (_currentUser == null) return false;

    try {
      _currentUser = _currentUser!.copyWith(profileImage: imageUrl);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Telefon numarası doğrula
  Future<bool> verifyPhoneNumber(String code) async {
    if (_currentUser == null) return false;

    try {
      // Simüle edilmiş doğrulama
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = _currentUser!.copyWith(isPhoneVerified: true);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // E-posta doğrula
  Future<bool> verifyEmail(String code) async {
    if (_currentUser == null) return false;

    try {
      // Simüle edilmiş doğrulama
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = _currentUser!.copyWith(isEmailVerified: true);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Şifre değiştir
  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    if (_currentUser == null) return false;

    try {
      // Simüle edilmiş şifre değiştirme
      await Future.delayed(const Duration(seconds: 1));

      // Şifre değişikliği başarılı
      return true;
    } catch (e) {
      return false;
    }
  }

  // Hesap sil
  Future<bool> deleteAccount() async {
    if (_currentUser == null) return false;

    try {
      // Simüle edilmiş hesap silme
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = null;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Kullanıcı verilerini yenile
  Future<void> refreshUserData() async {
    if (_currentUser == null) return;

    try {
      // Simüle edilmiş veri yenileme
      await Future.delayed(const Duration(seconds: 1));

      // Kullanıcı verilerini güncelle
      _currentUser = _currentUser!.copyWith(lastLoginAt: DateTime.now());

      notifyListeners();
    } catch (e) {
      // Hata durumunda bir şey yapma
    }
  }

  // Kullanıcı istatistikleri
  Map<String, int> getUserStatistics() {
    if (_currentUser == null) return {};

    return {
      'daysSinceRegistration': DateTime.now()
          .difference(_currentUser!.createdAt)
          .inDays,
      'daysSinceLastLogin': DateTime.now()
          .difference(_currentUser!.lastLoginAt)
          .inDays,
      'preferencesCount': _currentUser!.preferences.length,
      'profileCompleteness': _calculateProfileCompleteness(),
    };
  }

  int _calculateProfileCompleteness() {
    if (_currentUser == null) return 0;

    int completedFields = 0;
    int totalFields =
        6; // email, firstName, lastName, profileImage, phoneNumber, profile

    if (_currentUser!.email.isNotEmpty) completedFields++;
    if (_currentUser!.firstName.isNotEmpty) completedFields++;
    if (_currentUser!.lastName.isNotEmpty) completedFields++;
    if (_currentUser!.profileImage != null) completedFields++;
    if (_currentUser!.phoneNumber != null) completedFields++;
    if (_currentUser!.profile.isNotEmpty) completedFields++;

    return ((completedFields / totalFields) * 100).round();
  }

  // Kullanıcı verilerini güncelle
  Future<bool> updateUser(Map<String, dynamic> updates) async {
    if (_currentUser == null) return false;

    try {
      final newProfile = Map<String, dynamic>.from(_currentUser!.profile);
      newProfile.addAll(updates);

      _currentUser = _currentUser!.copyWith(profile: newProfile);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Kullanıcı verilerini dışa aktar
  Map<String, dynamic> exportUserData() {
    if (_currentUser == null) return {};

    return {
      'user': _currentUser!.toJson(),
      'statistics': getUserStatistics(),
      'exportedAt': DateTime.now().toIso8601String(),
    };
  }
}
