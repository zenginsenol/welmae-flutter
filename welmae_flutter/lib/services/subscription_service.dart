import 'dart:io';
import 'package:dio/dio.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter/foundation.dart';
import 'api_service.dart';

class SubscriptionService {
  final ApiService _apiService = ApiService();

  // Get all available subscription plans
  Future<ApiResponse<List<SubscriptionPlan>>> getSubscriptionPlans() async {
    try {
      return await _apiService.getSubscriptionPlans();
    } catch (e) {
      debugPrint('Error fetching subscription plans: $e');
      return ApiResponse.error('Failed to fetch subscription plans');
    }
  }

  // Subscribe to a plan
  Future<ApiResponse<Subscription>> subscribeToPlan({
    required String planId,
    String? paymentMethodId,
    Map<String, dynamic>? paymentDetails,
  }) async {
    try {
      // In a real implementation, this would integrate with a payment provider
      // For now, we'll simulate the subscription process
      // In a real implementation, this would integrate with a payment provider
      // For now, we'll simulate the subscription process
      return await _apiService.subscribeToPlan(planId);
    } catch (e) {
      debugPrint('Error subscribing to plan: $e');
      return ApiResponse.error('Failed to subscribe to plan');
    }
  }

  // Get user's current subscription
  Future<ApiResponse<Subscription?>> getCurrentSubscription() async {
    try {
      // This would require a specific endpoint in the API
      // For now, we'll simulate by getting all subscriptions and finding the active one
      final plansResult = await getSubscriptionPlans();

      if (plansResult.success &&
          plansResult.data != null &&
          plansResult.data!.isNotEmpty) {
        // In a real implementation, we would fetch the user's actual subscription
        // For now, we'll return null to indicate no active subscription
        return ApiResponse.success(null, 'No active subscription');
      } else {
        return ApiResponse.error(
          plansResult.error ?? 'Failed to fetch current subscription',
        );
      }
    } catch (e) {
      debugPrint('Error fetching current subscription: $e');
      return ApiResponse.error('Failed to fetch current subscription');
    }
  }

  // Cancel subscription
  Future<ApiResponse<void>> cancelSubscription(String subscriptionId) async {
    try {
      // This would require a specific endpoint in the API
      // For now, we'll simulate the cancellation
      // This would require a specific endpoint in the API
      // For now, we'll simulate the cancellation
      debugPrint('Cancelling subscription $subscriptionId');
      return ApiResponse.success(null, 'Subscription cancelled');
    } catch (e) {
      debugPrint('Error cancelling subscription: $e');
      return ApiResponse.error('Failed to cancel subscription');
    }
  }

  // Get subscription history
  Future<ApiResponse<List<Subscription>>> getSubscriptionHistory() async {
    try {
      // This would require a specific endpoint in the API
      // For now, we'll return an empty list
      return ApiResponse.success([], 'Subscription history fetched');
    } catch (e) {
      debugPrint('Error fetching subscription history: $e');
      return ApiResponse.error('Failed to fetch subscription history');
    }
  }

  // Get payment methods
  Future<ApiResponse<List<Map<String, dynamic>>>> getPaymentMethods() async {
    try {
      // This would require a specific endpoint in the API
      // For now, we'll return some mock payment methods
      final mockPaymentMethods = [
        {
          'id': 'card_1',
          'type': 'credit_card',
          'last4': '1234',
          'brand': 'Visa',
          'expMonth': 12,
          'expYear': 2025,
          'isDefault': true,
        },
        {
          'id': 'card_2',
          'type': 'credit_card',
          'last4': '5678',
          'brand': 'Mastercard',
          'expMonth': 6,
          'expYear': 2024,
          'isDefault': false,
        },
      ];

      return ApiResponse.success(mockPaymentMethods, 'Payment methods fetched');
    } catch (e) {
      debugPrint('Error fetching payment methods: $e');
      return ApiResponse.error('Failed to fetch payment methods');
    }
  }

  // Add payment method
  Future<ApiResponse<Map<String, dynamic>>> addPaymentMethod(
    Map<String, dynamic> paymentMethod,
  ) async {
    try {
      // This would require a specific endpoint in the API
      // For now, we'll simulate adding a payment method
      debugPrint('Adding payment method: $paymentMethod');

      // Return the added payment method with an ID
      final addedMethod = Map<String, dynamic>.from(paymentMethod);
      addedMethod['id'] = 'card_${DateTime.now().millisecondsSinceEpoch}';

      return ApiResponse.success(addedMethod, 'Payment method added');
    } catch (e) {
      debugPrint('Error adding payment method: $e');
      return ApiResponse.error('Failed to add payment method');
    }
  }

  // Remove payment method
  Future<ApiResponse<void>> removePaymentMethod(String paymentMethodId) async {
    try {
      // This would require a specific endpoint in the API
      // For now, we'll simulate removing a payment method
      // This would require a specific endpoint in the API
      // For now, we'll simulate removing a payment method
      debugPrint('Removing payment method: $paymentMethodId');
      return ApiResponse.success(null, 'Payment method removed');
    } catch (e) {
      debugPrint('Error removing payment method: $e');
      return ApiResponse.error('Failed to remove payment method');
    }
  }

  // Set default payment method
  Future<ApiResponse<void>> setDefaultPaymentMethod(
    String paymentMethodId,
  ) async {
    try {
      // This would require a specific endpoint in the API
      // For now, we'll simulate setting a default payment method
      // This would require a specific endpoint in the API
      // For now, we'll simulate setting a default payment method
      debugPrint('Setting default payment method: $paymentMethodId');
      return ApiResponse.success(null, 'Default payment method set');
    } catch (e) {
      debugPrint('Error setting default payment method: $e');
      return ApiResponse.error('Failed to set default payment method');
    }
  }

  // Get subscription benefits for user's tier
  Future<ApiResponse<Map<String, dynamic>>> getTierBenefits(String tier) async {
    try {
      // Return benefits based on tier
      final benefits = <String, dynamic>{};

      switch (tier.toLowerCase()) {
        case 'bronze':
          benefits.addAll({
            'maxTripsPerMonth': 2,
            'maxParticipantsPerTrip': 5,
            'canCreateSponsoredTrips': false,
            'canBeGuide': false,
            'prioritySupport': false,
            'adFree': false,
          });
          break;

        case 'silver':
          benefits.addAll({
            'maxTripsPerMonth': 5,
            'maxParticipantsPerTrip': 10,
            'canCreateSponsoredTrips': true,
            'canBeGuide': true,
            'prioritySupport': true,
            'adFree': true,
          });
          break;

        case 'gold':
          benefits.addAll({
            'maxTripsPerMonth': -1, // Unlimited
            'maxParticipantsPerTrip': -1, // Unlimited
            'canCreateSponsoredTrips': true,
            'canBeGuide': true,
            'prioritySupport': true,
            'adFree': true,
            'exclusiveFeatures': true,
          });
          break;

        default:
          benefits.addAll({
            'maxTripsPerMonth': 2,
            'maxParticipantsPerTrip': 5,
            'canCreateSponsoredTrips': false,
            'canBeGuide': false,
            'prioritySupport': false,
            'adFree': false,
          });
      }

      return ApiResponse.success(benefits, 'Tier benefits fetched');
    } catch (e) {
      debugPrint('Error fetching tier benefits: $e');
      return ApiResponse.error('Failed to fetch tier benefits');
    }
  }

  // Check if user can perform an action based on their tier
  Future<ApiResponse<bool>> canPerformAction(String tier, String action) async {
    try {
      final benefitsResult = await getTierBenefits(tier);

      if (benefitsResult.success && benefitsResult.data != null) {
        final benefits = benefitsResult.data!;
        final canPerform = benefits[action] as bool? ?? false;
        return ApiResponse.success(canPerform, 'Permission check completed');
      } else {
        return ApiResponse.error(
          benefitsResult.error ?? 'Failed to check permissions',
        );
      }
    } catch (e) {
      debugPrint('Error checking permissions: $e');
      return ApiResponse.error('Failed to check permissions');
    }
  }
}

// Models
class TierModel {
  final String id;
  final String name;
  final double price;
  final TierFeatures features;
  final int? duration;

  TierModel({
    required this.id,
    required this.name,
    required this.price,
    required this.features,
    this.duration,
  });

  factory TierModel.fromJson(Map<String, dynamic> json) {
    return TierModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      features: TierFeatures.fromJson(json['features']),
      duration: json['duration'],
    );
  }
}

class TierFeatures {
  final int profileViews;
  final int messages;
  final String photoAccess;
  final bool premiumSupport;
  final double discountRate;

  TierFeatures({
    required this.profileViews,
    required this.messages,
    required this.photoAccess,
    required this.premiumSupport,
    required this.discountRate,
  });

  factory TierFeatures.fromJson(Map<String, dynamic> json) {
    return TierFeatures(
      profileViews: json['profileViews'],
      messages: json['messages'],
      photoAccess: json['photoAccess'],
      premiumSupport: json['premiumSupport'],
      discountRate: (json['discountRate'] as num).toDouble(),
    );
  }
}

class ProductModel {
  final String key;
  final String productId;
  final String tier;
  final int duration;
  final double price;
  final String currency;
  final String name;
  final String description;

  ProductModel({
    required this.key,
    required this.productId,
    required this.tier,
    required this.duration,
    required this.price,
    required this.currency,
    required this.name,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      key: json['key'],
      productId: json['productId'],
      tier: json['tier'],
      duration: json['duration'],
      price: (json['price'] as num).toDouble(),
      currency: json['currency'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class UserTierStatus {
  final String tier;
  final String tierName;
  final bool isExpired;
  final DateTime? expiresAt;
  final TierFeatures features;
  final UsageInfo currentUsage;
  final int trustScore;
  final int confirmedTrips;

  UserTierStatus({
    required this.tier,
    required this.tierName,
    required this.isExpired,
    this.expiresAt,
    required this.features,
    required this.currentUsage,
    required this.trustScore,
    required this.confirmedTrips,
  });

  factory UserTierStatus.fromJson(Map<String, dynamic> json) {
    return UserTierStatus(
      tier: json['tier'],
      tierName: json['tierName'],
      isExpired: json['isExpired'],
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'])
          : null,
      features: TierFeatures.fromJson(json['features']),
      currentUsage: UsageInfo.fromJson(json['currentUsage']),
      trustScore: json['trustScore'],
      confirmedTrips: json['confirmedTrips'],
    );
  }
}

class UsageInfo {
  final UsageDetail profileViews;
  final UsageDetail messages;

  UsageInfo({required this.profileViews, required this.messages});

  factory UsageInfo.fromJson(Map<String, dynamic> json) {
    return UsageInfo(
      profileViews: UsageDetail.fromJson(json['profileViews']),
      messages: UsageDetail.fromJson(json['messages']),
    );
  }
}

class UsageDetail {
  final int used;
  final int limit;
  final int remaining;

  UsageDetail({
    required this.used,
    required this.limit,
    required this.remaining,
  });

  factory UsageDetail.fromJson(Map<String, dynamic> json) {
    return UsageDetail(
      used: json['used'],
      limit: json['limit'],
      remaining: json['remaining'],
    );
  }
}

class PurchaseResult {
  final bool success;
  final String purchaseId;
  final String productId;

  PurchaseResult({
    required this.success,
    required this.purchaseId,
    required this.productId,
  });
}

class ValidationResult {
  final bool success;
  final Map<String, dynamic> purchase;
  final Map<String, dynamic> user;
  final String transactionId;

  ValidationResult({
    required this.success,
    required this.purchase,
    required this.user,
    required this.transactionId,
  });

  factory ValidationResult.fromJson(Map<String, dynamic> json) {
    return ValidationResult(
      success: json['success'],
      purchase: json['purchase'],
      user: json['user'],
      transactionId: json['transactionId'] ?? json['orderId'],
    );
  }
}

class DiscountInfo {
  final double rate;
  final int percentage;
  final int trips;
  final String message;

  DiscountInfo({
    required this.rate,
    required this.percentage,
    required this.trips,
    required this.message,
  });

  factory DiscountInfo.fromJson(Map<String, dynamic> json) {
    return DiscountInfo(
      rate: (json['rate'] as num).toDouble(),
      percentage: json['percentage'],
      trips: json['trips'],
      message: json['message'],
    );
  }
}

class SubscriptionModel {
  final String id;
  final String tier;
  final double price;
  final String status;
  final DateTime expiresAt;
  final DateTime createdAt;

  SubscriptionModel({
    required this.id,
    required this.tier,
    required this.price,
    required this.status,
    required this.expiresAt,
    required this.createdAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'],
      tier: json['tier'],
      price: (json['price'] as num).toDouble(),
      status: json['status'],
      expiresAt: DateTime.parse(json['expiresAt']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
