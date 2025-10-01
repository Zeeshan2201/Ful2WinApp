import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/firebase_messaging_service.dart';
import 'flutter_flow/device_token_service.dart';

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with error handling
  try {
    await Firebase.initializeApp();
    print("✅ Firebase initialized successfully");

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Initialize device token service
    DeviceTokenService.initialize();
  } catch (e) {
    print("❌ Firebase initialization failed: $e");
    print("📝 Note: App will continue without Firebase features");
    // App continues without Firebase features
  }

  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);

    // Initialize Firebase Messaging
    _initializeFirebaseMessaging();
  }

  void _initializeFirebaseMessaging() async {
    // Initialize Firebase Messaging Service
    await FirebaseMessagingService.initialize();

    // Get and save FCM token
    String? fcmToken = await FirebaseMessagingService.getToken();
    if (fcmToken != null) {
      // Save to app state if you have an FCM token field
      // FFAppState().fcmToken = fcmToken;
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        // Show custom notification banner instead of dialog
        final context = _router.routerDelegate.navigatorKey.currentContext;
        if (context != null) {
          FirebaseMessagingService.showNotificationBanner(
            context,
            title: message.notification?.title ?? 'Notification',
            body: message.notification?.body ?? 'You have a new message',
            onTap: () => _handleNotificationTap(message),
          );
        }
      }
    });

    // Handle notification taps when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      _handleNotificationTap(message);
    });

    // Handle notification tap when app is terminated
    messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App launched from notification!');
        print('Message data: ${message.data}');
        _handleNotificationTap(message);
      }
    });

    // Listen to token refresh
    FirebaseMessagingService.listenToTokenRefresh((newToken) {
      print('FCM Token refreshed: $newToken');
      // Update token in app state and backend
      // FFAppState().fcmToken = newToken;
      // Call API to update token on server
    });
  }

  void _handleNotificationTap(RemoteMessage message) {
    // Use the service to handle notification data
    FirebaseMessagingService.handleNotificationData(message.data);

    // Handle navigation based on notification data
    final data = message.data;

    if (data['route'] != null) {
      // Navigate to specific route
      _router.go(data['route']);
    } else if (data['gameId'] != null) {
      // Navigate to game page
      _router.go('/gamePage?gameId=${data['gameId']}');
    }
    // Add more navigation logic based on your app's requirements
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ful2Win',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
