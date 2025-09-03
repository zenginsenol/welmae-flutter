import 'package:flutter/foundation.dart';
import 'api_service.dart';

class ProfileService {
  final ApiService _apiService = ApiService();

  // Get user profile
  Future<ApiResponse<UserProfile>> getProfile() async {
    try {
      return await _apiService.getProfile();
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      return ApiResponse.error('Failed to fetch profile');
    }
  }

  // Update user profile
  Future<ApiResponse<UserProfile>> updateProfile({
    String? firstName,
    String? lastName,
    String? bio,
    String? location,
    String? gender,
    DateTime? birthDate,
    List<String>? interests,
    Map<String, dynamic>? socialLinks,
  }) async {
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

      return await _apiService.updateUserProfile(profileData);
    } catch (e) {
      debugPrint('Error updating profile: $e');
      return ApiResponse.error('Failed to update profile');
    }
  }

  // Update profile photo
  Future<ApiResponse<UserProfile>> updateProfilePhoto(String photoUrl) async {
    try {
      final profileData = {'profileImage': photoUrl};

      return await _apiService.updateUserProfile(profileData);
    } catch (e) {
      debugPrint('Error updating profile photo: $e');
      return ApiResponse.error('Failed to update profile photo');
    }
  }

  // Add a photo to user's photo gallery
  Future<ApiResponse<UserProfile>> addPhotoToGallery({
    required String photoUrl,
    String? caption,
    List<String>? tags,
  }) async {
    try {
      // First get current profile
      final profileResult = await getProfile();

      if (profileResult.success && profileResult.data != null) {
        // Create new photo object
        final newPhoto = {
          'url': photoUrl,
          if (caption != null) 'caption': caption,
          if (tags != null) 'tags': tags,
          'createdAt': DateTime.now().toIso8601String(),
        };

        // Add to existing photos
        final currentPhotos = profileResult.data!.photos
            .map(
              (p) => {
                'url': p.url,
                'caption': p.caption,
                'tags': p.tags,
                'createdAt': p.createdAt.toIso8601String(),
              },
            )
            .toList();

        currentPhotos.add(newPhoto);

        // Update profile with new photos list
        final profileData = {'photos': currentPhotos};

        return await _apiService.updateUserProfile(profileData);
      } else {
        return ApiResponse.error(
          profileResult.error ?? 'Failed to add photo to gallery',
        );
      }
    } catch (e) {
      debugPrint('Error adding photo to gallery: $e');
      return ApiResponse.error('Failed to add photo to gallery');
    }
  }

  // Remove a photo from user's photo gallery
  Future<ApiResponse<UserProfile>> removePhotoFromGallery(
    String photoId,
  ) async {
    try {
      // First get current profile
      final profileResult = await getProfile();

      if (profileResult.success && profileResult.data != null) {
        // Filter out the photo to remove
        final updatedPhotos = profileResult.data!.photos
            .where((photo) => photo.id != photoId)
            .map(
              (p) => {
                'url': p.url,
                'caption': p.caption,
                'tags': p.tags,
                'createdAt': p.createdAt.toIso8601String(),
              },
            )
            .toList();

        // Update profile with new photos list
        final profileData = {'photos': updatedPhotos};

        return await _apiService.updateUserProfile(profileData);
      } else {
        return ApiResponse.error(
          profileResult.error ?? 'Failed to remove photo from gallery',
        );
      }
    } catch (e) {
      debugPrint('Error removing photo from gallery: $e');
      return ApiResponse.error('Failed to remove photo from gallery');
    }
  }

  // Update user's travel history
  Future<ApiResponse<UserProfile>> updateTravelHistory(
    List<Map<String, dynamic>> trips,
  ) async {
    try {
      final profileData = {'trips': trips};

      return await _apiService.updateUserProfile(profileData);
    } catch (e) {
      debugPrint('Error updating travel history: $e');
      return ApiResponse.error('Failed to update travel history');
    }
  }

  // Get user's travel statistics
  Future<ApiResponse<Map<String, dynamic>>> getTravelStats() async {
    try {
      final profileResult = await getProfile();

      if (profileResult.success && profileResult.data != null) {
        final profile = profileResult.data!;

        // Calculate statistics
        final totalTrips = profile.trips.length;
        final completedTrips = profile.trips
            .where((trip) => trip.status.toLowerCase() == 'completed')
            .length;
        final upcomingTrips = profile.trips
            .where((trip) => trip.status.toLowerCase() == 'upcoming')
            .length;

        // Get unique destinations
        final destinations = profile.trips
            .map((trip) => trip.destination)
            .toSet()
            .toList();

        final stats = {
          'totalTrips': totalTrips,
          'completedTrips': completedTrips,
          'upcomingTrips': upcomingTrips,
          'destinations': destinations,
          'countriesVisited': destinations.length, // Simplified for now
        };

        return ApiResponse.success(stats);
      } else {
        return ApiResponse.error(
          profileResult.error ?? 'Failed to fetch travel stats',
        );
      }
    } catch (e) {
      debugPrint('Error fetching travel stats: $e');
      return ApiResponse.error('Failed to fetch travel stats');
    }
  }

  // Get user's guide information (if user is a guide)
  Future<ApiResponse<Map<String, dynamic>?>> getGuideInfo() async {
    try {
      final profileResult = await getProfile();

      if (profileResult.success && profileResult.data != null) {
        // In a real implementation, this would come from a separate guide profile
        // For now, we'll return null to indicate the user is not a guide
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(
          profileResult.error ?? 'Failed to fetch guide info',
        );
      }
    } catch (e) {
      debugPrint('Error fetching guide info: $e');
      return ApiResponse.error('Failed to fetch guide info');
    }
  }

  // Update user's guide information
  Future<ApiResponse<UserProfile>> updateGuideInfo({
    String? specialties,
    String? certifications,
    double? hourlyRate,
    String? bio,
  }) async {
    try {
      // In a real implementation, this would update a separate guide profile
      // For now, we'll update the main profile with guide-related fields
      final profileData = <String, dynamic>{};

      if (specialties != null) profileData['guideSpecialties'] = specialties;
      if (certifications != null)
        profileData['guideCertifications'] = certifications;
      if (hourlyRate != null) profileData['guideHourlyRate'] = hourlyRate;
      if (bio != null) profileData['guideBio'] = bio;

      return await _apiService.updateUserProfile(profileData);
    } catch (e) {
      debugPrint('Error updating guide info: $e');
      return ApiResponse.error('Failed to update guide info');
    }
  }
}
