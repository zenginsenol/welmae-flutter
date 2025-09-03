import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> initialize() async {
    // Basit bildirim servisi - gerçek implementasyon için flutter_local_notifications paketi gerekli
    debugPrint('Bildirim servisi başlatıldı');
  }

  // Genel bildirim
  Future<void> showGeneralNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    // Basit bildirim - gerçek implementasyon için paket gerekli
    debugPrint('Bildirim: $title - $body');
  }

  // Seyahat bildirimi
  Future<void> showTravelNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    debugPrint('Seyahat Bildirimi: $title - $body');
  }

  // Teklif bildirimi
  Future<void> showOfferNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    debugPrint('Teklif Bildirimi: $title - $body');
  }

  // Zamanlanmış bildirim
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    debugPrint('Zamanlanmış Bildirim: $title - $body (${scheduledDate.toString()})');
  }

  // Bildirimleri temizle
  Future<void> cancelAllNotifications() async {
    debugPrint('Tüm bildirimler temizlendi');
  }

  // Belirli bildirimi iptal et
  Future<void> cancelNotification(int id) async {
    debugPrint('Bildirim iptal edildi: $id');
  }

  // Bildirim izinlerini kontrol et
  Future<bool> requestPermissions() async {
    return true; // Simüle edilmiş
  }

  // Bildirim izinlerini kontrol et
  Future<bool> areNotificationsEnabled() async {
    return true; // Simüle edilmiş
  }
}

// Bildirim türleri
enum NotificationType {
  general,
  travel,
  offer,
}

// Bildirim verisi
class NotificationData {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final DateTime timestamp;
  final String? payload;
  final bool isRead;

  const NotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.timestamp,
    this.payload,
    this.isRead = false,
  });

  NotificationData copyWith({
    String? id,
    String? title,
    String? body,
    NotificationType? type,
    DateTime? timestamp,
    String? payload,
    bool? isRead,
  }) {
    return NotificationData(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      payload: payload ?? this.payload,
      isRead: isRead ?? this.isRead,
    );
  }
}

// Bildirim yöneticisi
class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal();

  final NotificationService _notificationService = NotificationService();
  final List<NotificationData> _notifications = [];

  Future<void> initialize() async {
    await _notificationService.initialize();
  }

  // Bildirim gönder
  Future<void> sendNotification(NotificationData notification) async {
    _notifications.add(notification);

    switch (notification.type) {
      case NotificationType.general:
        await _notificationService.showGeneralNotification(
          title: notification.title,
          body: notification.body,
          payload: notification.payload,
        );
        break;
      case NotificationType.travel:
        await _notificationService.showTravelNotification(
          title: notification.title,
          body: notification.body,
          payload: notification.payload,
        );
        break;
      case NotificationType.offer:
        await _notificationService.showOfferNotification(
          title: notification.title,
          body: notification.body,
          payload: notification.payload,
        );
        break;
    }
  }

  // Zamanlanmış bildirim gönder
  Future<void> scheduleNotification(NotificationData notification, DateTime scheduledDate) async {
    await _notificationService.scheduleNotification(
      title: notification.title,
      body: notification.body,
      scheduledDate: scheduledDate,
      payload: notification.payload,
    );
  }

  // Tüm bildirimleri getir
  List<NotificationData> getAllNotifications() {
    return List.unmodifiable(_notifications);
  }

  // Okunmamış bildirimleri getir
  List<NotificationData> getUnreadNotifications() {
    return _notifications.where((n) => !n.isRead).toList();
  }

  // Bildirimi okundu olarak işaretle
  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  // Tüm bildirimleri okundu olarak işaretle
  void markAllAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }

  // Bildirim sayısını getir
  int get notificationCount => _notifications.length;

  // Okunmamış bildirim sayısını getir
  int get unreadNotificationCount => _notifications.where((n) => !n.isRead).length;
}
