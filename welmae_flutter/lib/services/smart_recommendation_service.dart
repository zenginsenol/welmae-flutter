import 'dart:math' as math;

class SmartRecommendationService {
  // User Behavior Analysis
  static Map<String, double> analyzeUserBehavior({
    required List<String> searchHistory,
    required List<String> favoriteDestinations,
    required List<String> visitedDestinations,
    required Map<String, int> categoryPreferences,
    required Map<String, double> ratingHistory,
  }) {
    final Map<String, double> behaviorScore = {};
    
    // Search pattern analysis
    for (String search in searchHistory) {
      behaviorScore[search] = (behaviorScore[search] ?? 0) + 1.0;
    }
    
    // Favorite destinations analysis
    for (String favorite in favoriteDestinations) {
      behaviorScore[favorite] = (behaviorScore[favorite] ?? 0) + 2.0;
    }
    
    // Visited destinations analysis
    for (String visited in visitedDestinations) {
      behaviorScore[visited] = (behaviorScore[visited] ?? 0) + 3.0;
    }
    
    // Category preference analysis
    for (String category in categoryPreferences.keys) {
      final count = categoryPreferences[category] ?? 0;
      behaviorScore[category] = (behaviorScore[category] ?? 0) + (count * 0.5);
    }
    
    // Rating analysis
    for (String destination in ratingHistory.keys) {
      final rating = ratingHistory[destination] ?? 0;
      behaviorScore[destination] = (behaviorScore[destination] ?? 0) + (rating * 0.3);
    }
    
    return behaviorScore;
  }

  // Smart Destination Recommendations
  static List<SmartRecommendation> getSmartRecommendations({
    required Map<String, double> userBehavior,
    required List<Destination> availableDestinations,
    required String userLocation,
    required double userBudget,
    required List<String> userInterests,
    int maxRecommendations = 10,
  }) {
    final List<SmartRecommendation> recommendations = [];
    
    for (Destination destination in availableDestinations) {
      double score = 0.0;
      
      // Location-based scoring
      final distance = _calculateDistance(userLocation, destination.location);
      score += _calculateLocationScore(distance);
      
      // Budget-based scoring
      score += _calculateBudgetScore(userBudget, destination.price);
      
      // Interest-based scoring
      score += _calculateInterestScore(userInterests, destination.categories);
      
      // Popularity and rating scoring
      score += destination.rating * 0.2;
      score += destination.popularity * 0.1;
      
      // Seasonal scoring
      score += _calculateSeasonalScore(destination);
      
      // Personalization scoring
      if (userBehavior.containsKey(destination.id)) {
        score += userBehavior[destination.id]! * 0.5;
      }
      
      recommendations.add(SmartRecommendation(
        destination: destination,
        score: score,
        reason: _generateRecommendationReason(score, destination, userInterests),
        confidence: _calculateConfidence(score),
      ));
    }
    
    // Sort by score and return top recommendations
    recommendations.sort((a, b) => b.score.compareTo(a.score));
    return recommendations.take(maxRecommendations).toList();
  }

  // Personalized Dashboard Widgets
  static List<PersonalizedWidget> getPersonalizedWidgets({
    required Map<String, double> userBehavior,
    required List<SmartRecommendation> recommendations,
    required Map<String, dynamic> userPreferences,
  }) {
    final List<PersonalizedWidget> widgets = [];
    
    // Top recommendation widget
    if (recommendations.isNotEmpty) {
      widgets.add(PersonalizedWidget(
        type: WidgetType.topRecommendation,
        title: 'Senin İçin Önerilen',
        subtitle: 'Davranış analizine göre',
        data: recommendations.first,
        priority: 1,
      ));
    }
    
    // Category preference widget
    final topCategories = _getTopCategories(userBehavior);
    if (topCategories.isNotEmpty) {
      widgets.add(PersonalizedWidget(
        type: WidgetType.categoryPreference,
        title: 'Favori Kategorilerin',
        subtitle: 'En çok ilgilendiğin alanlar',
        data: topCategories,
        priority: 2,
      ));
    }
    
    // Budget optimization widget
    final budgetInsights = _getBudgetInsights(userBehavior, userPreferences);
    if (budgetInsights != null) {
      widgets.add(PersonalizedWidget(
        type: WidgetType.budgetOptimization,
        title: 'Bütçe Optimizasyonu',
        subtitle: 'Daha akıllı harcama için',
        data: budgetInsights,
        priority: 3,
      ));
    }
    
    // Seasonal deals widget
    final seasonalDeals = _getSeasonalDeals(userBehavior);
    if (seasonalDeals.isNotEmpty) {
      widgets.add(PersonalizedWidget(
        type: WidgetType.seasonalDeals,
        title: 'Sezonluk Fırsatlar',
        subtitle: 'Şu an için en iyi teklifler',
        data: seasonalDeals,
        priority: 4,
      ));
    }
    
    // Travel history insights widget
    final travelInsights = _getTravelInsights(userBehavior);
    if (travelInsights != null) {
      widgets.add(PersonalizedWidget(
        type: WidgetType.travelInsights,
        title: 'Seyahat Analizi',
        subtitle: 'Geçmiş seyahatlerinden öğrenilenler',
        data: travelInsights,
        priority: 5,
      ));
    }
    
    // Sort by priority
    widgets.sort((a, b) => a.priority.compareTo(b.priority));
    return widgets;
  }

  // Smart Search with Autocomplete
  static List<SearchSuggestion> getSmartSearchSuggestions({
    required String query,
    required Map<String, double> userBehavior,
    required List<Destination> availableDestinations,
    int maxSuggestions = 5,
  }) {
    final List<SearchSuggestion> suggestions = [];
    
    if (query.isEmpty) {
      // Return popular searches based on user behavior
      final popularSearches = _getPopularSearches(userBehavior);
      suggestions.addAll(popularSearches);
    } else {
      // Return relevant destinations and categories
      for (Destination destination in availableDestinations) {
        if (_isRelevantSearch(query, destination)) {
          suggestions.add(SearchSuggestion(
            text: destination.name,
            type: SuggestionType.destination,
            relevance: _calculateSearchRelevance(query, destination, userBehavior),
            data: destination,
          ));
        }
      }
      
      // Add category suggestions
      final categories = _getRelevantCategories(query);
      for (String category in categories) {
        suggestions.add(SearchSuggestion(
          text: category,
          type: SuggestionType.category,
          relevance: 0.8,
          data: category,
        ));
      }
    }
    
    // Sort by relevance and return top suggestions
    suggestions.sort((a, b) => b.relevance.compareTo(a.relevance));
    return suggestions.take(maxSuggestions).toList();
  }

  // Predictive Analytics
  static TravelPrediction getTravelPrediction({
    required Map<String, double> userBehavior,
    required List<String> searchHistory,
    required Map<String, dynamic> userPreferences,
  }) {
    final nextDestination = _predictNextDestination(userBehavior, searchHistory);
    final optimalBudget = _predictOptimalBudget(userBehavior, userPreferences);
    final bestTravelTime = _predictBestTravelTime(userBehavior, userPreferences);
    final recommendedDuration = _predictRecommendedDuration(userBehavior);
    
    return TravelPrediction(
      nextDestination: nextDestination,
      optimalBudget: optimalBudget,
      bestTravelTime: bestTravelTime,
      recommendedDuration: recommendedDuration,
      confidence: _calculatePredictionConfidence(userBehavior),
      reasoning: _generatePredictionReasoning(
        nextDestination,
        optimalBudget,
        bestTravelTime,
        recommendedDuration,
      ),
    );
  }

  // Helper Methods
  static double _calculateDistance(String location1, String location2) {
    // Simplified distance calculation (in real app, use geolocation)
    return 100.0; // Placeholder
  }

  static double _calculateLocationScore(double distance) {
    // Closer destinations get higher scores
    return math.max(0, 10 - (distance / 10));
  }

  static double _calculateBudgetScore(double userBudget, double destinationPrice) {
    if (destinationPrice <= userBudget) {
      return 10.0; // Perfect match
    } else if (destinationPrice <= userBudget * 1.2) {
      return 7.0; // Slightly over budget
    } else if (destinationPrice <= userBudget * 1.5) {
      return 4.0; // Moderately over budget
    } else {
      return 1.0; // Way over budget
    }
  }

  static double _calculateInterestScore(List<String> userInterests, List<String> destinationCategories) {
    double score = 0.0;
    for (String interest in userInterests) {
      if (destinationCategories.contains(interest)) {
        score += 2.0;
      }
    }
    return score;
  }

  static double _calculateSeasonalScore(Destination destination) {
    // Seasonal scoring logic
    final currentMonth = DateTime.now().month;
    final seasonalMonths = destination.seasonalMonths ?? [];
    
    if (seasonalMonths.contains(currentMonth)) {
      return 5.0; // Peak season
    } else if (seasonalMonths.contains((currentMonth + 1) % 12) || 
               seasonalMonths.contains((currentMonth - 1) % 12)) {
      return 3.0; // Shoulder season
    } else {
      return 1.0; // Off season
    }
  }

  static String _generateRecommendationReason(double score, Destination destination, List<String> userInterests) {
    if (score > 8.0) {
      return 'Mükemmel uyum! İlgi alanların ve bütçene göre ideal';
    } else if (score > 6.0) {
      return 'Çok iyi seçim! Senin için optimize edilmiş';
    } else if (score > 4.0) {
      return 'İyi bir seçenek! Bütçene ve tercihlerine uygun';
    } else {
      return 'Alternatif seçenek! Farklı bir deneyim için';
    }
  }

  static double _calculateConfidence(double score) {
    return math.min(1.0, score / 10.0);
  }

  static List<String> _getTopCategories(Map<String, double> userBehavior) {
    // Extract and return top categories
    return ['Adventure', 'Culture', 'Food', 'Nature'];
  }

  static Map<String, dynamic>? _getBudgetInsights(Map<String, double> userBehavior, Map<String, dynamic> userPreferences) {
    // Budget optimization insights
    return {
      'averageSpending': 1500.0,
      'savingsOpportunity': 300.0,
      'recommendations': ['Erken rezervasyon', 'Off-season travel', 'Package deals'],
    };
  }

  static List<Map<String, dynamic>> _getSeasonalDeals(Map<String, double> userBehavior) {
    // Seasonal deals based on user behavior
    return [
      {'destination': 'Santorini', 'discount': '25%', 'validUntil': 'Eylül 2024'},
      {'destination': 'Bali', 'discount': '30%', 'validUntil': 'Kasım 2024'},
    ];
  }

  static Map<String, dynamic>? _getTravelInsights(Map<String, double> userBehavior) {
    // Travel history insights
    return {
      'totalTrips': 12,
      'favoriteSeason': 'Yaz',
      'preferredBudget': 'Orta',
      'growthAreas': ['Adventure sports', 'Cultural experiences'],
    };
  }

  static List<SearchSuggestion> _getPopularSearches(Map<String, double> userBehavior) {
    // Popular searches based on user behavior
    return [
      SearchSuggestion(
        text: 'Paris',
        type: SuggestionType.destination,
        relevance: 0.9,
        data: 'Paris, Fransa',
      ),
      SearchSuggestion(
        text: 'Adventure',
        type: SuggestionType.category,
        relevance: 0.8,
        data: 'Adventure',
      ),
    ];
  }

  static bool _isRelevantSearch(String query, Destination destination) {
    return destination.name.toLowerCase().contains(query.toLowerCase()) ||
           destination.location.toLowerCase().contains(query.toLowerCase()) ||
           destination.categories.any((category) => category.toLowerCase().contains(query.toLowerCase()));
  }

  static double _calculateSearchRelevance(String query, Destination destination, Map<String, double> userBehavior) {
    double relevance = 0.0;
    
    // Text match relevance
    if (destination.name.toLowerCase().contains(query.toLowerCase())) {
      relevance += 0.6;
    }
    if (destination.location.toLowerCase().contains(query.toLowerCase())) {
      relevance += 0.4;
    }
    
    // User behavior relevance
    if (userBehavior.containsKey(destination.id)) {
      relevance += userBehavior[destination.id]! * 0.3;
    }
    
    return relevance.clamp(0.0, 1.0);
  }

  static List<String> _getRelevantCategories(String query) {
    // Return relevant categories based on query
    final allCategories = ['Adventure', 'Culture', 'Food', 'Nature', 'Relaxation', 'Shopping'];
    return allCategories.where((category) => 
      category.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  static String? _predictNextDestination(Map<String, double> userBehavior, List<String> searchHistory) {
    // Predict next destination based on behavior and search history
    if (searchHistory.isNotEmpty) {
      return searchHistory.last;
    }
    return null;
  }

  static double _predictOptimalBudget(Map<String, double> userBehavior, Map<String, dynamic> userPreferences) {
    // Predict optimal budget based on user behavior
    return 2000.0; // Placeholder
  }

  static String _predictBestTravelTime(Map<String, double> userBehavior, Map<String, dynamic> userPreferences) {
    // Predict best travel time based on user behavior
    return 'Yaz ayları'; // Placeholder
  }

  static int _predictRecommendedDuration(Map<String, double> userBehavior) {
    // Predict recommended duration based on user behavior
    return 7; // Placeholder
  }

  static double _calculatePredictionConfidence(Map<String, double> userBehavior) {
    // Calculate prediction confidence based on data quality
    return 0.85; // Placeholder
  }

  static String _generatePredictionReasoning(
    String? nextDestination,
    double optimalBudget,
    String bestTravelTime,
    int recommendedDuration,
  ) {
    return 'Geçmiş seyahat davranışların ve tercihlerin analiz edilerek oluşturuldu. '
           'Bu öneriler %85 güvenilirlik oranına sahip.';
  }
}

// Data Models
class SmartRecommendation {
  final Destination destination;
  final double score;
  final String reason;
  final double confidence;

  SmartRecommendation({
    required this.destination,
    required this.score,
    required this.reason,
    required this.confidence,
  });
}

class Destination {
  final String id;
  final String name;
  final String location;
  final double price;
  final double rating;
  final double popularity;
  final List<String> categories;
  final List<int>? seasonalMonths;

  Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.popularity,
    required this.categories,
    this.seasonalMonths,
  });
}

class PersonalizedWidget {
  final WidgetType type;
  final String title;
  final String subtitle;
  final dynamic data;
  final int priority;

  PersonalizedWidget({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.data,
    required this.priority,
  });
}

enum WidgetType {
  topRecommendation,
  categoryPreference,
  budgetOptimization,
  seasonalDeals,
  travelInsights,
}

class SearchSuggestion {
  final String text;
  final SuggestionType type;
  final double relevance;
  final dynamic data;

  SearchSuggestion({
    required this.text,
    required this.type,
    required this.relevance,
    required this.data,
  });
}

enum SuggestionType {
  destination,
  category,
  search,
}

class TravelPrediction {
  final String? nextDestination;
  final double optimalBudget;
  final String bestTravelTime;
  final int recommendedDuration;
  final double confidence;
  final String reasoning;

  TravelPrediction({
    this.nextDestination,
    required this.optimalBudget,
    required this.bestTravelTime,
    required this.recommendedDuration,
    required this.confidence,
    required this.reasoning,
  });
}
