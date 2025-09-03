import 'package:flutter/foundation.dart';
import 'api_service.dart';

class TripService {
  final ApiService _apiService = ApiService();

  // Get all trips with optional filters
  Future<ApiResponse<List<Trip>>> getTrips({
    String? status,
    String? type,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final filters = <String, dynamic>{};

      if (status != null) filters['status'] = status;
      if (type != null) filters['type'] = type;
      if (destination != null) filters['destination'] = destination;
      if (startDate != null) filters['startDate'] = startDate.toIso8601String();
      if (endDate != null) filters['endDate'] = endDate.toIso8601String();

      return await _apiService.getTrips(filters: filters);
    } catch (e) {
      debugPrint('Error fetching trips: $e');
      return ApiResponse.error('Failed to fetch trips');
    }
  }

  // Get a specific trip by ID
  Future<ApiResponse<Trip>> getTrip(String tripId) async {
    try {
      // This would require a specific endpoint in the API
      // For now, we'll simulate by fetching all trips and filtering
      final result = await _apiService.getTrips();

      if (result.success && result.data != null) {
        final trip = result.data!.firstWhere(
          (t) => t.id == tripId,
          orElse: () => throw Exception('Trip not found'),
        );
        return ApiResponse.success(trip);
      } else {
        return ApiResponse.error(result.error ?? 'Failed to fetch trip');
      }
    } catch (e) {
      debugPrint('Error fetching trip: $e');
      return ApiResponse.error('Failed to fetch trip');
    }
  }

  // Create a new trip
  Future<ApiResponse<Trip>> createTrip({
    required String title,
    required String description,
    required String type, // 'sponsor' or 'guide'
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    List<String>? participantIds,
    List<Map<String, dynamic>>? photos,
  }) async {
    try {
      final tripData = {
        'title': title,
        'description': description,
        'type': type,
        'destination': destination,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'budget': budget,
        'participantIds': participantIds ?? [],
        'photos': photos ?? [],
      };

      return await _apiService.createTrip(tripData);
    } catch (e) {
      debugPrint('Error creating trip: $e');
      return ApiResponse.error('Failed to create trip');
    }
  }

  // Update an existing trip
  Future<ApiResponse<Trip>> updateTrip({
    required String tripId,
    String? title,
    String? description,
    String? type,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    double? budget,
    String? status,
    List<String>? participantIds,
    List<Map<String, dynamic>>? photos,
  }) async {
    try {
      final tripData = <String, dynamic>{};

      if (title != null) tripData['title'] = title;
      if (description != null) tripData['description'] = description;
      if (type != null) tripData['type'] = type;
      if (destination != null) tripData['destination'] = destination;
      if (startDate != null)
        tripData['startDate'] = startDate.toIso8601String();
      if (endDate != null) tripData['endDate'] = endDate.toIso8601String();
      if (budget != null) tripData['budget'] = budget;
      if (status != null) tripData['status'] = status;
      if (participantIds != null) tripData['participantIds'] = participantIds;
      if (photos != null) tripData['photos'] = photos;

      return await _apiService.updateTrip(tripId, tripData);
    } catch (e) {
      debugPrint('Error updating trip: $e');
      return ApiResponse.error('Failed to update trip');
    }
  }

  // Delete a trip
  Future<ApiResponse<void>> deleteTrip(String tripId) async {
    try {
      return await _apiService.deleteTrip(tripId);
    } catch (e) {
      debugPrint('Error deleting trip: $e');
      return ApiResponse.error('Failed to delete trip');
    }
  }

  // Add a participant to a trip
  Future<ApiResponse<Trip>> addParticipant(String tripId, String userId) async {
    try {
      // First get the current trip to get participant list
      final tripResult = await getTrip(tripId);

      if (tripResult.success && tripResult.data != null) {
        final currentParticipants = List<String>.from(
          tripResult.data!.participantIds,
        );

        // Add new participant if not already in list
        if (!currentParticipants.contains(userId)) {
          currentParticipants.add(userId);
        }

        // Update the trip with new participant list
        return await updateTrip(
          tripId: tripId,
          participantIds: currentParticipants,
        );
      } else {
        return ApiResponse.error(
          tripResult.error ?? 'Failed to add participant',
        );
      }
    } catch (e) {
      debugPrint('Error adding participant: $e');
      return ApiResponse.error('Failed to add participant');
    }
  }

  // Remove a participant from a trip
  Future<ApiResponse<Trip>> removeParticipant(
    String tripId,
    String userId,
  ) async {
    try {
      // First get the current trip to get participant list
      final tripResult = await getTrip(tripId);

      if (tripResult.success && tripResult.data != null) {
        final currentParticipants = List<String>.from(
          tripResult.data!.participantIds,
        );

        // Remove participant if in list
        currentParticipants.remove(userId);

        // Update the trip with new participant list
        return await updateTrip(
          tripId: tripId,
          participantIds: currentParticipants,
        );
      } else {
        return ApiResponse.error(
          tripResult.error ?? 'Failed to remove participant',
        );
      }
    } catch (e) {
      debugPrint('Error removing participant: $e');
      return ApiResponse.error('Failed to remove participant');
    }
  }
}
