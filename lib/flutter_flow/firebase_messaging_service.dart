import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  // Stream controller for notifications
  static final StreamController<RemoteMessage> _notificationStreamController =
      StreamController<RemoteMessage>.broadcast();

  // Expose the stream for listeners
  static Stream<RemoteMessage> get notificationStream =>
      _notificationStreamController.stream;

  // List to store recent notifications (in-memory cache)
  static final List<RemoteMessage> _recentNotifications = [];

  // Get recent notifications
  static List<RemoteMessage> get recentNotifications => _recentNotifications;

  // Initialize Firebase Messaging
  static Future<void> initialize() async {
    // Request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  // Get FCM token
  static Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print('FCM Token: $token');
      return token;
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  // Subscribe to topic
  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic $topic: $e');
    }
  }

  // Unsubscribe from topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Error unsubscribing from topic $topic: $e');
    }
  }

  // Handle notification data and navigation
  static void handleNotificationData(Map<String, dynamic> data) {
    print('Handling notification data: $data');

    // Example: Handle different notification types
    switch (data['type']) {
      case 'game_invite':
        // Navigate to game page
        print('Navigate to game: ${data['gameId']}');
        break;
      case 'tournament_update':
        // Navigate to tournament page
        print('Navigate to tournament: ${data['tournamentId']}');
        break;
      case 'challenge_received':
        // Navigate to challenge page
        print('Navigate to challenge page');
        break;
      case 'follow':
        // Navigate to profile page
        print('Navigate to profile page');
        break;
      case 'like':
        // Navigate to post/community page
        print('Navigate to community page');
        break;
      case 'comment':
        // Navigate to post page
        print('Navigate to post page');
        break;
      default:
        print('Unknown notification type: ${data['type']}');
    }
  }

  // Add notification to recent list and broadcast to stream
  static void addNotification(RemoteMessage message) {
    _recentNotifications.insert(0, message);

    // Keep only last 50 notifications
    if (_recentNotifications.length > 50) {
      _recentNotifications.removeLast();
    }

    // Broadcast to stream
    _notificationStreamController.add(message);

    print('✅ Notification added to stream: ${message.notification?.title}');
  }

  // Clear all notifications
  static void clearNotifications() {
    _recentNotifications.clear();
    print('🗑️ All notifications cleared');
  }

  // Dispose stream controller
  static void dispose() {
    _notificationStreamController.close();
  }

  // Show custom notification banner
  static void showNotificationBanner(
    BuildContext context, {
    required String title,
    required String body,
    VoidCallback? onTap,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 16,
        right: 16,
        child: Material(
          borderRadius: BorderRadius.circular(12),
          elevation: 6,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF0A2A66), Color(0xFF0033CC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        body,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => overlayEntry.remove(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Auto remove after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });

    // Handle tap
    if (onTap != null) {
      // You can add tap handling here if needed
    }
  }

  // Listen to token refresh
  static void listenToTokenRefresh(Function(String) onTokenRefresh) {
    _firebaseMessaging.onTokenRefresh.listen(onTokenRefresh);
  }
}

// Notification types enum for better type safety
enum NotificationType {
  gameInvite,
  tournamentUpdate,
  challengeReceived,
  generalUpdate,
}

// Extension to convert string to NotificationType
extension NotificationTypeExtension on String {
  NotificationType get toNotificationType {
    switch (this) {
      case 'game_invite':
        return NotificationType.gameInvite;
      case 'tournament_update':
        return NotificationType.tournamentUpdate;
      case 'challenge_received':
        return NotificationType.challengeReceived;
      default:
        return NotificationType.generalUpdate;
    }
  }
}
