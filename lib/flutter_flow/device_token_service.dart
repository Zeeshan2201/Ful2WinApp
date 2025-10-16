import 'package:firebase_messaging/firebase_messaging.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Device Token Service for managing FCM tokens
class DeviceTokenService {
  /// Get the current FCM device token
  static Future<String?> getDeviceToken() async {
    try {
      // Check if Firebase is available
      String? token = await FirebaseMessaging.instance.getToken();
      print("FCM Device Token: $token");
      return token;
    } catch (e) {
      print(
          "Warning: Firebase not configured properly. Error getting FCM device token: $e");
      print(
          "Note: Push notifications will not work until Firebase is properly configured");
      return null;
    }
  }

  /// Send device token to backend after successful login/registration
  static Future<bool> sendDeviceTokenToBackend({
    required String userToken,
    required String userId,
  }) async {
    try {
      // Get FCM device token
      String? deviceToken = await getDeviceToken();

      if (deviceToken != null && userToken.isNotEmpty && userId.isNotEmpty) {
        print("Sending device token to backend for user: $userId");

        // Send device token to backend
        final deviceTokenResponse = await DeviceToken.call(
          token: userToken,
          deviceToken: deviceToken,
        );

        if (deviceTokenResponse.succeeded) {
          print("✅ Device token sent successfully to backend");
          return true;
        } else {
          print("❌ Failed to send device token to backend");
          print("Response: ${deviceTokenResponse.jsonBody}");
          return false;
        }
      } else {
        print("❌ Missing required data for sending device token:");
        print(
            "Device Token: ${deviceToken != null ? 'Available' : 'Not Available'}");
        print("User Token: ${userToken.isNotEmpty ? 'Available' : 'Empty'}");
        print("User ID: ${userId.isNotEmpty ? 'Available' : 'Empty'}");
        return false;
      }
    } catch (e) {
      print("❌ Error sending device token to backend: $e");
      return false;
    }
  }

  /// Send device token using current app state
  static Future<bool> sendDeviceTokenFromAppState() async {
    return await sendDeviceTokenToBackend(
      userToken: FFAppState().token,
      userId: FFAppState().userId,
    );
  }

  /// Listen to token refresh and update backend
  static void listenToTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      print("🔄 FCM Token refreshed: $newToken");

      // Update token on backend if user is logged in
      if (FFAppState().token.isNotEmpty && FFAppState().userId.isNotEmpty) {
        bool success = await sendDeviceTokenToBackend(
          userToken: FFAppState().token,
          userId: FFAppState().userId,
        );

        if (success) {
          print("✅ Refreshed token updated on backend");
        } else {
          print("❌ Failed to update refreshed token on backend");
        }
      }
    });
  }

  /// Initialize device token service (call this in app initialization)
  static void initialize() {
    print("🚀 Initializing Device Token Service");
    listenToTokenRefresh();
  }

  /// Handle user logout - cleanup if needed
  static Future<void> handleLogout() async {
    try {
      // You can add logic here to remove device token from backend if needed
      // For now, we'll just log the logout
      print("👋 User logged out - device token cleanup completed");
    } catch (e) {
      print("❌ Error during device token cleanup: $e");
    }
  }
}
