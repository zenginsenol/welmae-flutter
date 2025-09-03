import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  // Current location stream controller
  final StreamController<LocationData> _locationController = StreamController<LocationData>.broadcast();
  Stream<LocationData> get locationStream => _locationController.stream;

  // Current location data
  LocationData? _currentLocation;
  LocationData? get currentLocation => _currentLocation;

  // Location permission status
  bool _hasPermission = false;
  bool get hasPermission => _hasPermission;

  // Initialize location service
  Future<bool> initialize() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Konum servisleri devre dışı');
        return false;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Konum izni reddedildi');
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint('Konum izni kalıcı olarak reddedildi');
        return false;
      }

      _hasPermission = true;
      return true;
    } catch (e) {
      debugPrint('Konum servisi başlatılamadı: $e');
      return false;
    }
  }

  // Get current location
  Future<LocationData?> getCurrentLocation() async {
    try {
      if (!_hasPermission) {
        bool initialized = await initialize();
        if (!initialized) return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      _currentLocation = LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        altitude: position.altitude,
        speed: position.speed,
        speedAccuracy: position.speedAccuracy,
        heading: position.heading,
        timestamp: position.timestamp,
      );

      _locationController.add(_currentLocation!);
      return _currentLocation;
    } catch (e) {
      debugPrint('Mevcut konum alınamadı: $e');
      return null;
    }
  }

  // Get last known location
  Future<LocationData?> getLastKnownLocation() async {
    try {
      Position? position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        _currentLocation = LocationData(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracy: position.accuracy,
          altitude: position.altitude,
          speed: position.speed,
          speedAccuracy: position.speedAccuracy,
          heading: position.heading,
          timestamp: position.timestamp,
        );
        return _currentLocation;
      }
      return null;
    } catch (e) {
      debugPrint('Son bilinen konum alınamadı: $e');
      return null;
    }
  }

  // Start location updates
  StreamSubscription<Position>? _locationSubscription;
  
  Future<void> startLocationUpdates({
    Duration interval = const Duration(seconds: 10),
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) async {
    try {
      if (!_hasPermission) {
        bool initialized = await initialize();
        if (!initialized) return;
      }

      _locationSubscription?.cancel();
      
      _locationSubscription = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: accuracy,
          distanceFilter: 10, // 10 meters
          timeLimit: interval,
        ),
      ).listen(
        (Position position) {
          _currentLocation = LocationData(
            latitude: position.latitude,
            longitude: position.longitude,
            accuracy: position.accuracy,
            altitude: position.altitude,
            speed: position.speed,
            speedAccuracy: position.speedAccuracy,
            heading: position.heading,
            timestamp: position.timestamp,
          );
          _locationController.add(_currentLocation!);
        },
        onError: (error) {
          debugPrint('Konum güncellemesi hatası: $error');
        },
      );
    } catch (e) {
      debugPrint('Konum güncellemeleri başlatılamadı: $e');
    }
  }

  // Stop location updates
  void stopLocationUpdates() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  // Get address from coordinates
  Future<String?> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.locality ?? ''}, ${place.country ?? ''}'.trim();
      }
      return null;
    } catch (e) {
      debugPrint('Adres alınamadı: $e');
      return null;
    }
  }

  // Get coordinates from address
  Future<LocationData?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations[0];
        return LocationData(
          latitude: location.latitude,
          longitude: location.longitude,
          accuracy: 0, // geocoding.Location doesn't have accuracy
          altitude: 0, // geocoding.Location doesn't have altitude
          speed: 0,
          speedAccuracy: 0,
          heading: 0,
          timestamp: DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      debugPrint('Koordinat alınamadı: $e');
      return null;
    }
  }

  // Calculate distance between two points
  double calculateDistance({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  // Calculate bearing between two points
  double calculateBearing({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    return Geolocator.bearingBetween(lat1, lon1, lat2, lon2);
  }

  // Check if location is within radius
  bool isLocationWithinRadius({
    required double centerLat,
    required double centerLon,
    required double targetLat,
    required double targetLon,
    required double radiusInMeters,
  }) {
    double distance = calculateDistance(
      lat1: centerLat,
      lon1: centerLon,
      lat2: targetLat,
      lon2: targetLon,
    );
    return distance <= radiusInMeters;
  }

  // Get nearby places (mock implementation)
  Future<List<NearbyPlace>> getNearbyPlaces({
    required double latitude,
    required double longitude,
    required double radiusInMeters,
    String? type,
  }) async {
    // Mock data for development
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      NearbyPlace(
        id: '1',
        name: 'İstanbul Havalimanı',
        type: 'airport',
        latitude: 41.2622,
        longitude: 28.7278,
        distance: calculateDistance(
          lat1: latitude,
          lon1: longitude,
          lat2: 41.2622,
          lon2: 28.7278,
        ),
        rating: 4.5,
        address: 'Tayakadın, 34283 Arnavutköy/İstanbul',
      ),
      NearbyPlace(
        id: '2',
        name: 'Sultanahmet Camii',
        type: 'attraction',
        latitude: 41.0054,
        longitude: 28.9768,
        distance: calculateDistance(
          lat1: latitude,
          lon1: longitude,
          lat2: 41.0054,
          lon2: 28.9768,
        ),
        rating: 4.8,
        address: 'Sultan Ahmet, Atmeydanı Cd. No:7, 34122 Fatih/İstanbul',
      ),
      NearbyPlace(
        id: '3',
        name: 'Topkapı Sarayı',
        type: 'attraction',
        latitude: 41.0115,
        longitude: 28.9834,
        distance: calculateDistance(
          lat1: latitude,
          lon1: longitude,
          lat2: 41.0115,
          lon2: 28.9834,
        ),
        rating: 4.6,
        address: 'Cankurtaran, 34122 Fatih/İstanbul',
      ),
    ];
  }

  // Dispose resources
  void dispose() {
    stopLocationUpdates();
    _locationController.close();
  }
}

// Data Models
class LocationData {
  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double speed;
  final double speedAccuracy;
  final double heading;
  final DateTime timestamp;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.altitude,
    required this.speed,
    required this.speedAccuracy,
    required this.heading,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'LocationData(lat: $latitude, lon: $longitude, accuracy: $accuracy)';
  }
}

class NearbyPlace {
  final String id;
  final String name;
  final String type;
  final double latitude;
  final double longitude;
  final double distance;
  final double rating;
  final String address;

  NearbyPlace({
    required this.id,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.rating,
    required this.address,
  });

  String get distanceText {
    if (distance < 1000) {
      return '${distance.round()} m';
    } else {
      return '${(distance / 1000).toStringAsFixed(1)} km';
    }
  }

  String get typeText {
    switch (type) {
      case 'airport':
        return 'Havalimanı';
      case 'attraction':
        return 'Turistik Yer';
      case 'restaurant':
        return 'Restoran';
      case 'hotel':
        return 'Otel';
      case 'shopping':
        return 'Alışveriş';
      default:
        return 'Diğer';
    }
  }
}
