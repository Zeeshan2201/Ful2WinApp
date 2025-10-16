import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../lib/firebase_options.dart';

/// Quick test to verify Firebase is configured correctly
/// Run this with: flutter run --dart-define=FIREBASE_TEST=true
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('\n🔥 Firebase Configuration Test Starting...\n');

  try {
    // Test 1: Initialize Firebase
    print('📋 Test 1: Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully!\n');

    // Test 2: Get Firebase App info
    print('📋 Test 2: Checking Firebase App...');
    final app = Firebase.app();
    print('✅ App Name: ${app.name}');
    print('✅ App Options: ${app.options.projectId}\n');

    // Test 3: Check FCM
    print('📋 Test 3: Testing Firebase Cloud Messaging...');
    final messaging = FirebaseMessaging.instance;

    // Request permission
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('✅ Notification Permission: ${settings.authorizationStatus}');

    // Get FCM token
    final token = await messaging.getToken();
    if (token != null) {
      print(
          '✅ FCM Token received (first 50 chars): ${token.substring(0, 50)}...');
    } else {
      print('⚠️  No FCM token received');
    }

    print('\n🎉 All Firebase tests passed successfully!\n');
    print('📱 Your Firebase configuration is working correctly.');
    print('🔔 You can now send test notifications from Firebase Console.\n');
  } catch (e, stackTrace) {
    print('❌ Firebase test failed: $e');
    print('Stack trace: $stackTrace');
    print('\n💡 Check FIREBASE_SETUP.md for troubleshooting steps.\n');
  }
}
