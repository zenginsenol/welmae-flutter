import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  // Tema yönetimi
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setDarkMode(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  // Dil yönetimi
  String _language = 'tr';
  String get language => _language;
  String get selectedLanguage => _language;

  void setLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }

  void setSelectedLanguage(String lang) {
    setLanguage(lang);
  }

  // Para birimi yönetimi
  String _currency = 'TRY';
  String get currency => _currency;
  String get selectedCurrency => _currency;

  void setCurrency(String curr) {
    _currency = curr;
    notifyListeners();
  }

  void setSelectedCurrency(String curr) {
    setCurrency(curr);
  }

  // Bildirim ayarları
  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  void setNotificationsEnabled(bool enabled) {
    _notificationsEnabled = enabled;
    notifyListeners();
  }

  // Konum servisleri
  bool _locationServicesEnabled = true;
  bool get locationServicesEnabled => _locationServicesEnabled;

  void setLocationServicesEnabled(bool enabled) {
    _locationServicesEnabled = enabled;
    notifyListeners();
  }

  // Kullanıcı durumu
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void setLoggedIn(bool loggedIn) {
    _isLoggedIn = loggedIn;
    notifyListeners();
  }

  // Loading durumu
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Hata yönetimi
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Başarı mesajı
  String? _successMessage;
  String? get successMessage => _successMessage;

  void setSuccess(String? message) {
    _successMessage = message;
    notifyListeners();
  }

  void clearSuccess() {
    _successMessage = null;
    notifyListeners();
  }

  // Navigasyon durumu
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // Arama geçmişi
  final List<String> _searchHistory = [];
  List<String> get searchHistory => List.unmodifiable(_searchHistory);

  void addToSearchHistory(String query) {
    if (query.isNotEmpty && !_searchHistory.contains(query)) {
      _searchHistory.insert(0, query);
      if (_searchHistory.length > 10) {
        _searchHistory.removeLast();
      }
      notifyListeners();
    }
  }

  void clearSearchHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  // Favori destinasyonlar
  final Set<String> _favoriteDestinations = {};
  Set<String> get favoriteDestinations =>
      Set.unmodifiable(_favoriteDestinations);

  void toggleFavorite(String destinationId) {
    if (_favoriteDestinations.contains(destinationId)) {
      _favoriteDestinations.remove(destinationId);
    } else {
      _favoriteDestinations.add(destinationId);
    }
    notifyListeners();
  }

  bool isFavorite(String destinationId) {
    return _favoriteDestinations.contains(destinationId);
  }

  // Son görüntülenen destinasyonlar
  final List<String> _recentDestinations = [];
  List<String> get recentDestinations => List.unmodifiable(_recentDestinations);

  void addToRecentDestinations(String destinationId) {
    if (!_recentDestinations.contains(destinationId)) {
      _recentDestinations.insert(0, destinationId);
      if (_recentDestinations.length > 20) {
        _recentDestinations.removeLast();
      }
      notifyListeners();
    }
  }

  void clearRecentDestinations() {
    _recentDestinations.clear();
    notifyListeners();
  }

  // Uygulama ayarları
  Map<String, dynamic> _settings = {
    'autoSave': true,
    'syncEnabled': true,
    'offlineMode': false,
    'dataUsage': 'medium',
    'privacyLevel': 'standard',
  };

  Map<String, dynamic> get settings => Map.unmodifiable(_settings);

  void updateSetting(String key, dynamic value) {
    _settings[key] = value;
    notifyListeners();
  }

  void resetSettings() {
    _settings = {
      'autoSave': true,
      'syncEnabled': true,
      'offlineMode': false,
      'dataUsage': 'medium',
      'privacyLevel': 'standard',
    };
    notifyListeners();
  }

  // Uygulama istatistikleri
  Map<String, int> _statistics = {
    'destinationsViewed': 0,
    'searchesPerformed': 0,
    'favoritesAdded': 0,
    'tripsPlanned': 0,
    'notificationsReceived': 0,
  };

  Map<String, int> get statistics => Map.unmodifiable(_statistics);

  void incrementStatistic(String key) {
    _statistics[key] = (_statistics[key] ?? 0) + 1;
    notifyListeners();
  }

  void resetStatistics() {
    _statistics = {
      'destinationsViewed': 0,
      'searchesPerformed': 0,
      'favoritesAdded': 0,
      'tripsPlanned': 0,
      'notificationsReceived': 0,
    };
    notifyListeners();
  }

  // Cache yönetimi
  final Map<String, dynamic> _cache = {};
  Map<String, dynamic> get cache => Map.unmodifiable(_cache);

  void setCache(String key, dynamic value) {
    _cache[key] = value;
    notifyListeners();
  }

  dynamic getCache(String key) {
    return _cache[key];
  }

  void clearCache() {
    _cache.clear();
    notifyListeners();
  }

  void removeFromCache(String key) {
    _cache.remove(key);
    notifyListeners();
  }

  // Uygulama durumunu sıfırla
  void resetApp() {
    _themeMode = ThemeMode.system;
    _language = 'tr';
    _currency = 'TRY';
    _notificationsEnabled = true;
    _locationServicesEnabled = true;
    _isLoggedIn = false;
    _isLoading = false;
    _errorMessage = null;
    _successMessage = null;
    _currentIndex = 0;
    _searchHistory.clear();
    _favoriteDestinations.clear();
    _recentDestinations.clear();
    resetSettings();
    resetStatistics();
    clearCache();
    notifyListeners();
  }
}
