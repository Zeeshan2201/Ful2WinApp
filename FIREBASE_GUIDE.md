# Firebase Implementation Guide

## 🔥 Firebase Setup Complete!

Your Flutter app now has Firebase Core and Firebase Messaging properly integrated. Here's what has been implemented and how to use it:

## ✅ What's Implemented

### 1. **Firebase Initialization**
- Firebase Core is initialized in `main.dart`
- Firebase Messaging is set up with background and foreground handlers
- FCM token generation and management

### 2. **Push Notification Handling**
- **Background notifications**: Handled automatically
- **Foreground notifications**: Shows custom notification banner
- **Notification taps**: Handles navigation based on notification data
- **App terminated**: Handles notifications when app is launched from terminated state

### 3. **Firebase Messaging Service**
- Custom service class for easy Firebase operations
- Token management and refresh handling
- Topic subscription/unsubscription
- Custom notification banner UI

## 🚀 How to Use

### **1. Getting FCM Token**
```dart
String? token = await FirebaseMessagingService.getToken();
if (token != null) {
  // Send token to your backend server
  // Save to app state
  FFAppState().fcmToken = token;
}
```

### **2. Subscribe to Topics**
```dart
// Subscribe to general updates
await FirebaseMessagingService.subscribeToTopic('general_updates');

// Subscribe to user-specific topics
await FirebaseMessagingService.subscribeToTopic('user_${FFAppState().userId}');

// Subscribe to game-specific topics
await FirebaseMessagingService.subscribeToTopic('game_updates');
```

### **3. Handle Custom Notification Data**
Notifications should include data payload like this:
```json
{
  "notification": {
    "title": "New Challenge!",
    "body": "You have received a new game challenge"
  },
  "data": {
    "type": "challenge_received",
    "challengeId": "12345",
    "route": "/challengePage"
  }
}
```

### **4. Show Custom Notifications**
```dart
FirebaseMessagingService.showNotificationBanner(
  context,
  title: "Game Invitation",
  body: "Join the tournament now!",
  onTap: () {
    // Handle tap action
    context.pushNamed('/tournamentPage');
  },
);
```

## 📱 Notification Types Supported

### **Game Invitations**
```json
{
  "data": {
    "type": "game_invite",
    "gameId": "12345",
    "route": "/gamePage"
  }
}
```

### **Tournament Updates**
```json
{
  "data": {
    "type": "tournament_update",
    "tournamentId": "67890",
    "route": "/tournamentPage"
  }
}
```

### **Challenge Notifications**
```json
{
  "data": {
    "type": "challenge_received",
    "challengeId": "11111",
    "route": "/challengePage"
  }
}
```

## 🔧 Backend Integration

### **1. Save FCM Token**
When user registers or logs in, save their FCM token:
```dart
// After successful login/signup
String? fcmToken = await FirebaseMessagingService.getToken();
if (fcmToken != null) {
  // Call your API to save token
  await SaveFCMTokenCall.call(
    userId: FFAppState().userId,
    token: fcmToken,
  );
}
```

### **2. Update Token on Refresh**
```dart
FirebaseMessagingService.listenToTokenRefresh((newToken) {
  // Update token on server
  SaveFCMTokenCall.call(
    userId: FFAppState().userId,
    token: newToken,
  );
});
```

## 🛠️ Additional Configuration Needed

### **1. Add FCM Token Field to App State**
Add this to your `app_state.dart`:
```dart
String _fcmToken = '';
String get fcmToken => _fcmToken;
set fcmToken(String value) {
  _fcmToken = value;
  prefs.setString('ff_fcmToken', value);
}
```

### **2. Create Save FCM Token API Call**
Add this to your `api_calls.dart`:
```dart
class SaveFCMTokenCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? token = '',
  }) async {
    final apiRequestBody = '''
{
  "userId": "$userId",
  "fcmToken": "$token"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'Save FCM Token',
      apiUrl: 'https://api.fulboost.fun/api/users/fcm-token',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${FFAppState().token}',
      },
      params: {},
      body: apiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}
```

### **3. Platform-Specific Setup**

#### **Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<!-- Add these permissions -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.VIBRATE" />
```

#### **iOS** (`ios/Runner/Info.plist`):
```xml
<!-- Add notification permissions -->
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

## 🎯 Usage Examples

### **In HomePage Widget**
```dart
@override
void initState() {
  super.initState();
  
  // Subscribe to topics after user login
  _subscribeToNotifications();
}

void _subscribeToNotifications() async {
  if (FFAppState().token.isNotEmpty) {
    // Subscribe to user-specific notifications
    await FirebaseMessagingService.subscribeToTopic('user_${FFAppState().userId}');
    
    // Subscribe to general game updates
    await FirebaseMessagingService.subscribeToTopic('game_updates');
  }
}
```

### **In Logout Process**
```dart
void logout() async {
  // Unsubscribe from topics
  await FirebaseMessagingService.unsubscribeFromTopic('user_${FFAppState().userId}');
  await FirebaseMessagingService.unsubscribeFromTopic('game_updates');
  
  // Clear app state and navigate to login
  FFAppState().token = '';
  FFAppState().userId = '';
  context.pushNamed('/loginPage');
}
```

## 🔔 Testing Notifications

Use Firebase Console or your backend to send test notifications:

1. **Firebase Console**: Go to Cloud Messaging and send test messages
2. **Backend**: Use Firebase Admin SDK to send notifications
3. **Testing Tool**: Use FCM HTTP API with the token

Your Firebase implementation is now complete and ready for production use! 🎉