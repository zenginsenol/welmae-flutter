import 'package:flutter/foundation.dart';
import 'api_service.dart';
import 'subscription_service.dart';

class TierRestrictionService {
  final SubscriptionService _subscriptionService = SubscriptionService();

  // Tier definitions with their feature limits
  static const Map<String, Map<String, dynamic>> tierLimits = {
    'bronze': {
      'maxTripsPerMonth': 2,
      'maxParticipantsPerTrip': 5,
      'canCreateSponsoredTrips': false,
      'canBeGuide': false,
      'maxPhotoUploadsPerDay': 10,
      'maxMessagesPerDay': 50,
      'canUseAdvancedFilters': false,
      'canCreatePrivateTrips': false,
      'canHostEvents': false,
      'prioritySupport': false,
      'adFree': false,
      'analyticsAccess': false,
      'customBadges': false,
    },
    'silver': {
      'maxTripsPerMonth': 5,
      'maxParticipantsPerTrip': 10,
      'canCreateSponsoredTrips': true,
      'canBeGuide': true,
      'maxPhotoUploadsPerDay': 50,
      'maxMessagesPerDay': 200,
      'canUseAdvancedFilters': true,
      'canCreatePrivateTrips': true,
      'canHostEvents': false,
      'prioritySupport': true,
      'adFree': true,
      'analyticsAccess': true,
      'customBadges': true,
    },
    'gold': {
      'maxTripsPerMonth': -1, // Unlimited
      'maxParticipantsPerTrip': -1, // Unlimited
      'canCreateSponsoredTrips': true,
      'canBeGuide': true,
      'maxPhotoUploadsPerDay': -1, // Unlimited
      'maxMessagesPerDay': -1, // Unlimited
      'canUseAdvancedFilters': true,
      'canCreatePrivateTrips': true,
      'canHostEvents': true,
      'prioritySupport': true,
      'adFree': true,
      'analyticsAccess': true,
      'customBadges': true,
    },
  };

  // Check if user can create a trip based on their tier
  Future<ApiResponse<bool>> canCreateTrip(
    String userTier,
    int currentTripCount,
  ) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final maxTrips = limits['maxTripsPerMonth'] as int;

      // If maxTrips is -1, it means unlimited
      if (maxTrips == -1) {
        return ApiResponse.success(true);
      }

      return ApiResponse.success(currentTripCount < maxTrips);
    } catch (e) {
      debugPrint('Error checking trip creation permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user can add more participants to a trip based on their tier
  Future<ApiResponse<bool>> canAddParticipants(
    String userTier,
    int currentParticipantCount,
  ) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final maxParticipants = limits['maxParticipantsPerTrip'] as int;

      // If maxParticipants is -1, it means unlimited
      if (maxParticipants == -1) {
        return ApiResponse.success(true);
      }

      return ApiResponse.success(currentParticipantCount < maxParticipants);
    } catch (e) {
      debugPrint('Error checking participant addition permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user can create a sponsored trip based on their tier
  Future<ApiResponse<bool>> canCreateSponsoredTrip(String userTier) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final canCreate = limits['canCreateSponsoredTrips'] as bool;
      return ApiResponse.success(canCreate);
    } catch (e) {
      debugPrint('Error checking sponsored trip permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user can be a guide based on their tier
  Future<ApiResponse<bool>> canBeGuide(String userTier) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final canGuide = limits['canBeGuide'] as bool;
      return ApiResponse.success(canGuide);
    } catch (e) {
      debugPrint('Error checking guide permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user can upload more photos today based on their tier
  Future<ApiResponse<bool>> canUploadPhoto(
    String userTier,
    int photosUploadedToday,
  ) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final maxUploads = limits['maxPhotoUploadsPerDay'] as int;

      // If maxUploads is -1, it means unlimited
      if (maxUploads == -1) {
        return ApiResponse.success(true);
      }

      return ApiResponse.success(photosUploadedToday < maxUploads);
    } catch (e) {
      debugPrint('Error checking photo upload permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user can send more messages today based on their tier
  Future<ApiResponse<bool>> canSendMessage(
    String userTier,
    int messagesSentToday,
  ) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final maxMessages = limits['maxMessagesPerDay'] as int;

      // If maxMessages is -1, it means unlimited
      if (maxMessages == -1) {
        return ApiResponse.success(true);
      }

      return ApiResponse.success(messagesSentToday < maxMessages);
    } catch (e) {
      debugPrint('Error checking message permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user can use advanced filters based on their tier
  Future<ApiResponse<bool>> canUseAdvancedFilters(String userTier) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final canUse = limits['canUseAdvancedFilters'] as bool;
      return ApiResponse.success(canUse);
    } catch (e) {
      debugPrint('Error checking advanced filters permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user can create private trips based on their tier
  Future<ApiResponse<bool>> canCreatePrivateTrips(String userTier) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final canCreate = limits['canCreatePrivateTrips'] as bool;
      return ApiResponse.success(canCreate);
    } catch (e) {
      debugPrint('Error checking private trip permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user can host events based on their tier
  Future<ApiResponse<bool>> canHostEvents(String userTier) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final canHost = limits['canHostEvents'] as bool;
      return ApiResponse.success(canHost);
    } catch (e) {
      debugPrint('Error checking event hosting permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user has priority support based on their tier
  Future<ApiResponse<bool>> hasPrioritySupport(String userTier) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final hasPriority = limits['prioritySupport'] as bool;
      return ApiResponse.success(hasPriority);
    } catch (e) {
      debugPrint('Error checking priority support permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user has ad-free experience based on their tier
  Future<ApiResponse<bool>> hasAdFreeExperience(String userTier) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final adFree = limits['adFree'] as bool;
      return ApiResponse.success(adFree);
    } catch (e) {
      debugPrint('Error checking ad-free permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user has analytics access based on their tier
  Future<ApiResponse<bool>> hasAnalyticsAccess(String userTier) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final hasAccess = limits['analyticsAccess'] as bool;
      return ApiResponse.success(hasAccess);
    } catch (e) {
      debugPrint('Error checking analytics access permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Check if user can use custom badges based on their tier
  Future<ApiResponse<bool>> canUseCustomBadges(String userTier) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      final canUse = limits['customBadges'] as bool;
      return ApiResponse.success(canUse);
    } catch (e) {
      debugPrint('Error checking custom badges permission: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }

  // Get user's tier limits
  Future<ApiResponse<Map<String, dynamic>>> getTierLimits(
    String userTier,
  ) async {
    try {
      final limits =
          tierLimits[userTier.toLowerCase()] ?? tierLimits['bronze']!;
      return ApiResponse.success(Map<String, dynamic>.from(limits));
    } catch (e) {
      debugPrint('Error fetching tier limits: $e');
      return ApiResponse.error('Failed to fetch tier limits');
    }
  }

  // Get user's current usage statistics
  Future<ApiResponse<Map<String, int>>> getCurrentUsage(String userTier) async {
    try {
      // In a real implementation, this would fetch actual usage data from the backend
      // For now, we'll return mock data
      final mockUsage = {
        'tripsCreatedThisMonth': 1,
        'participantsInTrips': 3,
        'photosUploadedToday': 5,
        'messagesSentToday': 25,
      };

      return ApiResponse.success(mockUsage);
    } catch (e) {
      debugPrint('Error fetching current usage: $e');
      return ApiResponse.error('Failed to fetch current usage');
    }
  }

  // Get remaining usage for a specific feature
  Future<ApiResponse<Map<String, dynamic>>> getRemainingUsage(
    String userTier,
    String feature,
  ) async {
    try {
      final limitsResult = await getTierLimits(userTier);
      final usageResult = await getCurrentUsage(userTier);

      if (limitsResult.success &&
          usageResult.success &&
          limitsResult.data != null &&
          usageResult.data != null) {
        final limits = limitsResult.data!;
        final usage = usageResult.data!;

        final limit = limits[feature] as int?;
        final current = usage['${feature}Today'] ?? usage[feature] ?? 0;

        if (limit == null) {
          return ApiResponse.success({
            'remaining': -1, // Unlimited
            'used': current,
            'limit': -1,
          });
        }

        if (limit == -1) {
          return ApiResponse.success({
            'remaining': -1, // Unlimited
            'used': current,
            'limit': -1,
          });
        }

        final remaining = limit - current;
        return ApiResponse.success({
          'remaining': remaining > 0 ? remaining : 0,
          'used': current,
          'limit': limit,
        });
      } else {
        return ApiResponse.error('Failed to calculate remaining usage');
      }
    } catch (e) {
      debugPrint('Error calculating remaining usage: $e');
      return ApiResponse.error('Failed to calculate remaining usage');
    }
  }
}
