import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = 'YOUR_OPENWEATHER_API_KEY'; // OpenWeatherMap API key
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  // Get current weather for a location
  static Future<WeatherData> getCurrentWeather({
    required double latitude,
    required double longitude,
    String units = 'metric',
    String lang = 'tr',
  }) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/weather?lat=$latitude&lon=$longitude&units=$units&lang=$lang&appid=$_apiKey'
      );

      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherData.fromJson(data);
      } else {
        throw Exception('Hava durumu verisi alınamadı: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to mock data if API fails
      return _getMockWeatherData();
    }
  }

  // Get weather forecast for a location
  static Future<List<WeatherData>> getWeatherForecast({
    required double latitude,
    required double longitude,
    String units = 'metric',
    String lang = 'tr',
  }) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/forecast?lat=$latitude&lon=$longitude&units=$units&lang=$lang&appid=$_apiKey'
      );

      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> list = data['list'];
        return list.map((item) => WeatherData.fromJson(item)).toList();
      } else {
        throw Exception('Hava durumu tahmini alınamadı: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to mock data if API fails
      return _getMockForecastData();
    }
  }

  // Get weather by city name
  static Future<WeatherData> getWeatherByCity({
    required String cityName,
    String units = 'metric',
    String lang = 'tr',
  }) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/weather?q=$cityName&units=$units&lang=$lang&appid=$_apiKey'
      );

      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherData.fromJson(data);
      } else {
        throw Exception('Şehir bulunamadı: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to mock data if API fails
      return _getMockWeatherData();
    }
  }

  // Get weather alerts for a location
  static Future<List<WeatherAlert>> getWeatherAlerts({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/onecall?lat=$latitude&lon=$longitude&exclude=current,minutely,hourly,daily&appid=$_apiKey'
      );

      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> alerts = data['alerts'] ?? [];
        return alerts.map((alert) => WeatherAlert.fromJson(alert)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // Mock data for development/testing
  static WeatherData _getMockWeatherData() {
    return WeatherData(
      temperature: 24.0,
      feelsLike: 26.0,
      humidity: 65,
      pressure: 1013,
      windSpeed: 12.0,
      windDirection: 180,
      description: 'Güneşli',
      icon: '01d',
      visibility: 10000,
      uvIndex: 6.0,
      timestamp: DateTime.now(),
      location: 'İstanbul, Türkiye',
      coordinates: const Coordinates(latitude: 41.0082, longitude: 28.9784),
    );
  }

  static List<WeatherData> _getMockForecastData() {
    return List.generate(5, (index) {
      return WeatherData(
        temperature: 20.0 + index * 2,
        feelsLike: 22.0 + index * 2,
        humidity: 60 + index * 5,
        pressure: 1013,
        windSpeed: 10.0 + index,
        windDirection: 180,
        description: index % 2 == 0 ? 'Güneşli' : 'Bulutlu',
        icon: index % 2 == 0 ? '01d' : '02d',
        visibility: 10000,
        uvIndex: 5.0 + index,
        timestamp: DateTime.now().add(Duration(days: index)),
        location: 'İstanbul, Türkiye',
        coordinates: const Coordinates(latitude: 41.0082, longitude: 28.9784),
      );
    });
  }

  // Get weather icon based on OpenWeatherMap icon code
  static IconData getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case '01d':
        return Icons.wb_sunny;
      case '01n':
        return Icons.nightlight_round;
      case '02d':
      case '02n':
        return Icons.cloud;
      case '03d':
      case '03n':
        return Icons.cloud_queue;
      case '04d':
      case '04n':
        return Icons.cloud_done;
      case '09d':
      case '09n':
        return Icons.grain;
      case '10d':
        return Icons.wb_sunny;
      case '10n':
        return Icons.nightlight_round;
      case '11d':
      case '11n':
        return Icons.flash_on;
      case '13d':
      case '13n':
        return Icons.ac_unit;
      case '50d':
      case '50n':
        return Icons.waves;
      default:
        return Icons.wb_sunny;
    }
  }

  // Get weather color based on temperature
  static Color getWeatherColor(double temperature) {
    if (temperature < 0) {
      return Colors.blue[400]!;
    } else if (temperature < 15) {
      return Colors.blue[300]!;
    } else if (temperature < 25) {
      return Colors.orange[400]!;
    } else if (temperature < 35) {
      return Colors.orange[600]!;
    } else {
      return Colors.red[600]!;
    }
  }

  // Get weather description in Turkish
  static String getWeatherDescription(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return 'Açık';
      case 'few clouds':
        return 'Az Bulutlu';
      case 'scattered clouds':
        return 'Parçalı Bulutlu';
      case 'broken clouds':
        return 'Çok Bulutlu';
      case 'overcast clouds':
        return 'Kapalı';
      case 'light rain':
        return 'Hafif Yağmurlu';
      case 'moderate rain':
        return 'Orta Şiddetli Yağmurlu';
      case 'heavy rain':
        return 'Şiddetli Yağmurlu';
      case 'light snow':
        return 'Hafif Karlı';
      case 'moderate snow':
        return 'Orta Şiddetli Karlı';
      case 'heavy snow':
        return 'Şiddetli Karlı';
      case 'thunderstorm':
        return 'Gök Gürültülü';
      case 'mist':
        return 'Sisli';
      case 'fog':
        return 'Puslu';
      case 'haze':
        return 'Dumanlı';
      default:
        return description;
    }
  }
}

// Data Models
class WeatherData {
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDirection;
  final String description;
  final String icon;
  final int visibility;
  final double uvIndex;
  final DateTime timestamp;
  final String location;
  final Coordinates coordinates;

  WeatherData({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDirection,
    required this.description,
    required this.icon,
    required this.visibility,
    required this.uvIndex,
    required this.timestamp,
    required this.location,
    required this.coordinates,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: (json['main']?['temp'] ?? 0.0).toDouble(),
      feelsLike: (json['main']?['feels_like'] ?? 0.0).toDouble(),
      humidity: json['main']?['humidity'] ?? 0,
      pressure: json['main']?['pressure'] ?? 0,
      windSpeed: (json['wind']?['speed'] ?? 0.0).toDouble(),
      windDirection: json['wind']?['deg'] ?? 0,
      description: json['weather']?[0]?['description'] ?? '',
      icon: json['weather']?[0]?['icon'] ?? '',
      visibility: json['visibility'] ?? 0,
      uvIndex: (json['uvi'] ?? 0.0).toDouble(),
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        (json['dt'] ?? 0) * 1000,
      ),
      location: json['name'] ?? '',
      coordinates: Coordinates(
        latitude: (json['coord']?['lat'] ?? 0.0).toDouble(),
        longitude: (json['coord']?['lon'] ?? 0.0).toDouble(),
      ),
    );
  }
}

class Coordinates {
  final double latitude;
  final double longitude;

  const Coordinates({
    required this.latitude,
    required this.longitude,
  });
}

class WeatherAlert {
  final String sender;
  final String event;
  final DateTime start;
  final DateTime end;
  final String description;
  final List<String> tags;

  WeatherAlert({
    required this.sender,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      sender: json['sender_name'] ?? '',
      event: json['event'] ?? '',
      start: DateTime.fromMillisecondsSinceEpoch(
        (json['start'] ?? 0) * 1000,
      ),
      end: DateTime.fromMillisecondsSinceEpoch(
        (json['end'] ?? 0) * 1000,
      ),
      description: json['description'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}
