# Ful2Win Gaming App - Developer Manual

**Version:** 1.0.1+2  
**Last Updated:** October 28, 2025  
**Platform:** Flutter (SDK >=3.0.0 <4.0.0)  
**Backend API:** https://api.fulboost.fun/api/

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Architecture](#2-architecture)
3. [Project Structure](#3-project-structure)
4. [API Documentation](#4-api-documentation)
5. [Authentication & Authorization](#5-authentication--authorization)
6. [Core Features](#6-core-features)
7. [State Management](#7-state-management)
8. [Firebase Integration](#8-firebase-integration)
9. [UI Components](#9-ui-components)
10. [Workflows](#10-workflows)
11. [Database & Storage](#11-database--storage)
12. [Third-Party Integrations](#12-third-party-integrations)
13. [Build & Deployment](#13-build--deployment)
14. [Testing](#14-testing)
15. [Troubleshooting](#15-troubleshooting)

---

## 1. Project Overview

### 1.1 About Ful2Win

Ful2Win is a mobile gaming application built with Flutter that allows users to:
- Play casual games with real money stakes
- Participate in tournaments
- Challenge other players
- Manage their wallet (deposit, withdraw)
- Spin wheel for rewards
- Build community through posts and following
- Earn through referral system

### 1.2 Technology Stack

| Technology | Version | Purpose |
|------------|---------|---------|
| Flutter | 3.0.0+ | Mobile app framework |
| Dart | 3.0.0+ | Programming language |
| Firebase Core | 3.0.0 | Firebase foundation |
| Firebase Auth | 5.0.0 | OTP authentication |
| Firebase Messaging | 15.0.0 | Push notifications |
| Go Router | 12.1.3 | Navigation & routing |
| Provider | 6.1.5 | State management |
| Shared Preferences | 2.5.3 | Local storage |
| SQLite | 2.3.3 | Local database |
| HTTP | 1.4.0 | API calls |
| Just Audio | 0.9.36 | Audio playback |
| WebView Flutter | 4.4.2 | In-app web pages |

---

## 2. Architecture

### 2.1 Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                      Presentation Layer                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Widgets    │  │  Pop-ups     │  │  Components  │      │
│  │  (Screens)   │  │  (Dialogs)   │  │   (Reusable) │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                       Business Logic                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │    Models    │  │   Services   │  │  Controllers │      │
│  │  (State)     │  │  (Firebase)  │  │  (FlutterFlow)│     │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                         Data Layer                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  API Client  │  │  Local DB    │  │  SharedPrefs │      │
│  │  (HTTP)      │  │  (SQLite)    │  │  (Cache)     │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                    External Services                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  Backend API │  │   Firebase   │  │  Payment GW  │      │
│  │ (REST)       │  │ (Auth, FCM)  │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 Design Patterns

- **MVVM (Model-View-ViewModel)**: Each page has a widget (View) and model (ViewModel)
- **Provider Pattern**: Used for state management via FlutterFlow
- **Repository Pattern**: API calls centralized in `api_calls.dart`
- **Factory Pattern**: Widget creation via `createModel()`
- **Singleton Pattern**: API Manager, Firebase services

---

## 3. Project Structure

### 3.1 Directory Structure

```
lib/
├── backend/
│   └── api_requests/
│       ├── api_calls.dart          # All API endpoints
│       └── api_manager.dart        # HTTP client wrapper
├── components/
│   └── pages/                      # Main app pages
│       ├── accountpage/
│       ├── add_money_page/
│       ├── challenge_page/
│       ├── community_page/
│       ├── games_page/
│       ├── home_page_copy/
│       ├── loginpage/
│       ├── notification/
│       ├── profilepage/
│       ├── signuppage/
│       ├── tournament_lobby/
│       ├── walletpage/
│       └── withdraw_page/
├── custom_code/
│   ├── actions/                    # Custom actions
│   └── widgets/                    # Custom widgets (game_on, etc.)
├── examples/                       # Code examples & reference
│   ├── firebase_otp_signup_example.dart
│   └── firebase_otp_dialog_example.dart
├── flutter_flow/                   # FlutterFlow utilities
│   ├── flutter_flow_theme.dart
│   ├── flutter_flow_util.dart
│   ├── flutter_flow_widgets.dart
│   └── device_token_service.dart
├── pop_ups/                        # Dialog widgets
│   ├── confirm_otp/
│   ├── game_page/
│   ├── registration_tournament_pop_up/
│   └── transactiondetails/
├── services/
│   └── firebase_auth_service.dart  # Firebase OTP service
├── app_state.dart                  # Global app state
├── firebase_options.dart           # Firebase config
├── index.dart                      # Export aggregator
└── main.dart                       # App entry point

android/                            # Android project
ios/                               # iOS project
web/                               # Web support
assets/                            # Static assets
├── audios/
├── fonts/
├── images/
├── jsons/
├── pdfs/
├── rive_animations/
└── videos/
```

### 3.2 Key Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | App initialization, Firebase setup, routing |
| `lib/app_state.dart` | Global state (user data, token, wallet) |
| `lib/backend/api_requests/api_calls.dart` | All API endpoint definitions |
| `lib/services/firebase_auth_service.dart` | Firebase OTP authentication |
| `lib/flutter_flow/device_token_service.dart` | FCM token management |
| `lib/index.dart` | Exports all widgets/models |
| `pubspec.yaml` | Dependencies & assets |

---

## 4. API Documentation

### 4.1 Base Configuration

**Base URL:** `https://api.fulboost.fun/api/`  
**Authentication:** Bearer Token (JWT)  
**Content-Type:** `application/json`

### 4.2 Authentication APIs

#### 4.2.1 Register User

```dart
RegisterCall.call({
  String? name,
  String? phone,
  String? email,
  String? password,
})
```

**Endpoint:** `POST /user/register`

**Request Body:**
```json
{
  "name": "John Doe",
  "phone": "1234567890",
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "User registered successfully",
  "token": "eyJhbGci...",
  "user": {
    "id": "user_id",
    "name": "John Doe",
    "phone": "1234567890",
    "email": "john@example.com"
  }
}
```

#### 4.2.2 Login

```dart
LogInCall.call({
  String? phone,
  String? password,
})
```

**Endpoint:** `POST /user/login`

**Request Body:**
```json
{
  "phone": "1234567890",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "token": "eyJhbGci...",
  "user": { /* user object */ }
}
```

#### 4.2.3 Logout

```dart
LogOutCall.call({
  String? token,
})
```

**Endpoint:** `POST /user/logout`

**Headers:** `Authorization: Bearer {token}`

#### 4.2.4 Send OTP (DEPRECATED - Use Firebase)

```dart
// DEPRECATED: Now using Firebase Authentication
// See: lib/services/firebase_auth_service.dart
```

**Note:** OTP authentication now uses Firebase Phone Authentication instead of backend API.

### 4.3 User Profile APIs

#### 4.3.1 Get Profile

```dart
ProfileCall.call({
  String? token,
})
```

**Endpoint:** `GET /user/profile`

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "success": true,
  "user": {
    "id": "user_id",
    "name": "John Doe",
    "phone": "1234567890",
    "email": "john@example.com",
    "profilePicture": "url",
    "wallet": {
      "balance": 1000,
      "depositAmount": 500,
      "winningAmount": 500
    },
    "stats": {
      "gamesPlayed": 50,
      "gamesWon": 30,
      "winRate": 60
    }
  }
}
```

#### 4.3.2 Update Profile Picture

```dart
ProfilePictureCall.call({
  String? token,
  FFUploadedFile? profilePicture,
})
```

**Endpoint:** `POST /user/profile-picture`

**Headers:** `Authorization: Bearer {token}`

**Content-Type:** `multipart/form-data`

### 4.4 Game APIs

#### 4.4.1 Get All Games

```dart
GamesCall.call({
  String? token,
})
```

**Endpoint:** `GET /games`

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "success": true,
  "games": [
    {
      "id": "game_id",
      "name": "Ludo",
      "image": "url",
      "minBet": 20,
      "maxBet": 10000,
      "isActive": true
    }
  ]
}
```

#### 4.4.2 Get Game Details

```dart
GameCall.call({
  String? gameId,
})
```

**Endpoint:** `GET /games/{gameId}`

**Response:**
```json
{
  "success": true,
  "game": {
    "id": "game_id",
    "name": "Ludo",
    "description": "Classic board game",
    "rules": "...",
    "betRanges": [
      { "min": 20, "max": 100 },
      { "min": 100, "max": 600 }
    ]
  }
}
```

### 4.5 Challenge APIs

#### 4.5.1 Create Challenge

```dart
ChallengesCall.call({
  String? token,
  String? gameId,
  double? entryFee,
  int? numberOfPlayers,
})
```

**Endpoint:** `POST /challenges`

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
```json
{
  "gameId": "game_id",
  "entryFee": 100,
  "numberOfPlayers": 2
}
```

#### 4.5.2 Get Challenges

```dart
GetChallengesCall.call({
  String? token,
  String? status,  // 'pending', 'active', 'completed'
})
```

**Endpoint:** `GET /challenges?status={status}`

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "success": true,
  "challenges": [
    {
      "id": "challenge_id",
      "gameId": "game_id",
      "gameName": "Ludo",
      "entryFee": 100,
      "prizePool": 180,
      "status": "pending",
      "creator": {
        "id": "user_id",
        "name": "John Doe"
      },
      "players": [/* player objects */],
      "createdAt": "2025-10-28T10:00:00Z"
    }
  ]
}
```

#### 4.5.3 Accept Challenge

```dart
AcceptChallengeCall.call({
  String? token,
  String? challengeId,
})
```

**Endpoint:** `POST /challenges/{challengeId}/accept`

**Headers:** `Authorization: Bearer {token}`

#### 4.5.4 Reject Challenge

```dart
RejectChallengeCall.call({
  String? token,
  String? challengeId,
})
```

**Endpoint:** `POST /challenges/{challengeId}/reject`

#### 4.5.5 Update Challenge Status

```dart
UpdateStatusCall.call({
  String? token,
  String? challengeId,
  String? status,  // 'started', 'completed', 'cancelled'
  String? winnerId,
})
```

**Endpoint:** `PUT /challenges/{challengeId}/status`

**Request Body:**
```json
{
  "status": "completed",
  "winnerId": "user_id"
}
```

### 4.6 Tournament APIs

#### 4.6.1 Get Tournaments

```dart
TournamentsCall.call({
  String? token,
})
```

**Endpoint:** `GET /tournaments`

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "success": true,
  "tournaments": [
    {
      "id": "tournament_id",
      "name": "Daily Ludo Championship",
      "gameId": "game_id",
      "gameName": "Ludo",
      "entryFee": 50,
      "prizePool": 10000,
      "maxPlayers": 100,
      "registeredPlayers": 45,
      "startTime": "2025-10-28T18:00:00Z",
      "status": "registering",
      "prizes": [
        { "rank": 1, "amount": 5000 },
        { "rank": 2, "amount": 3000 }
      ]
    }
  ]
}
```

#### 4.6.2 Register for Tournament

```dart
TournamentRegisterCall.call({
  String? token,
  String? tournamentId,
})
```

**Endpoint:** `POST /tournaments/{tournamentId}/register`

**Headers:** `Authorization: Bearer {token}`

#### 4.6.3 Update Tournament Status

```dart
StatusCall.call({
  String? token,
  String? tournamentId,
})
```

**Endpoint:** `PUT /tournaments/{tournamentId}/status`

### 4.7 Wallet APIs

#### 4.7.1 Get Wallet Balance

Included in profile API response.

#### 4.7.2 Add Money

(Handled through payment gateway - no direct API)

#### 4.7.3 Withdraw Money

```dart
// Implementation in withdraw_page_widget.dart
// Uses backend withdrawal API
```

**Endpoint:** `POST /wallet/withdraw`

**Request Body:**
```json
{
  "amount": 500,
  "method": "upi",
  "upiId": "user@upi"
}
```

#### 4.7.4 Transaction History

```dart
// Implementation in transaction_history page
```

**Endpoint:** `GET /wallet/transactions`

**Query Params:** `?page=1&limit=20&type=all`

### 4.8 Spin Wheel API

```dart
SpinWheelCall.call({
  String? token,
})
```

**Endpoint:** `POST /spin-wheel`

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "success": true,
  "reward": {
    "type": "coins",
    "amount": 50
  },
  "remainingSpins": 2
}
```

### 4.9 Social APIs

#### 4.9.1 Get Posts

```dart
PostsCall.call({
  String? token,
})
```

**Endpoint:** `GET /posts`

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "success": true,
  "posts": [
    {
      "id": "post_id",
      "userId": "user_id",
      "userName": "John Doe",
      "userProfilePic": "url",
      "content": "Just won my first tournament!",
      "image": "url",
      "likes": 45,
      "isLiked": true,
      "comments": 12,
      "createdAt": "2025-10-28T10:00:00Z"
    }
  ]
}
```

#### 4.9.2 Create Post

```dart
CreatePostCall.call({
  String? token,
  String? content,
  FFUploadedFile? image,
})
```

**Endpoint:** `POST /posts`

**Content-Type:** `multipart/form-data`

#### 4.9.3 Like/Unlike Post

```dart
LikeAndUnlikeCall.call({
  String? token,
  String? postId,
})
```

**Endpoint:** `POST /posts/{postId}/like`

#### 4.9.4 Follow User

```dart
Follow.call({
  String? token,
  String? userId,
})
```

**Endpoint:** `POST /follow/{userId}/follow`

#### 4.9.5 Unfollow User

```dart
UnFollow.call({
  String? token,
  String? userId,
})
```

**Endpoint:** `POST /follow/{userId}/unfollow`

### 4.10 Chat APIs

#### 4.10.1 Get Chats

```dart
ChatsCall.call({
  String? token,
  String? challengeId,
})
```

**Endpoint:** `GET /chats/{challengeId}`

**Headers:** `Authorization: Bearer {token}`

#### 4.10.2 Send Message

```dart
SendChatCall.call({
  String? token,
  String? challengeId,
  String? message,
})
```

**Endpoint:** `POST /chats/{challengeId}`

**Request Body:**
```json
{
  "message": "Good game!"
}
```

### 4.11 Notification APIs

#### 4.11.1 Get Notifications

```dart
NotificationCall.call({
  String? token,
})
```

**Endpoint:** `GET /notifications`

**Headers:** `Authorization: Bearer {token}`

**Response:**
```json
{
  "success": true,
  "notifications": [
    {
      "id": "notification_id",
      "title": "Challenge Accepted",
      "body": "John accepted your challenge",
      "type": "challenge",
      "isRead": false,
      "data": { /* additional data */ },
      "createdAt": "2025-10-28T10:00:00Z"
    }
  ]
}
```

#### 4.11.2 Register Device Token

```dart
DeviceToken.call({
  String? token,
  String? deviceToken,
})
```

**Endpoint:** `POST /device/register-device`

**Headers:** `Authorization: Bearer {token}`

**Request Body:**
```json
{
  "deviceToken": "fcm_token_here"
}
```

### 4.12 Referral APIs

#### 4.12.1 Get My Referral Code

```dart
ReferralCode().call({
  String? token,
})
```

**Endpoint:** `GET /referrals/my-code`

#### 4.12.2 Get My Referrals

```dart
MyReferrals.call({
  String? token,
})
```

**Endpoint:** `GET /referrals/my-referrals`

**Response:**
```json
{
  "success": true,
  "referralCode": "ABC123",
  "totalReferrals": 15,
  "totalEarnings": 750,
  "referrals": [
    {
      "userId": "user_id",
      "userName": "Jane Doe",
      "joinedAt": "2025-10-20T10:00:00Z",
      "earnings": 50
    }
  ]
}
```

---

## 5. Authentication & Authorization

### 5.1 Firebase OTP Authentication

**Implementation:** `lib/services/firebase_auth_service.dart`

#### Flow:
1. User enters phone number
2. App calls `FirebaseAuthService.sendOTP()`
3. Firebase sends SMS with 6-digit OTP
4. User enters OTP in dialog
5. App calls `FirebaseAuthService.verifyOTP()`
6. Firebase returns `UserCredential`
7. App gets Firebase ID token via `getIdToken()`
8. App registers/logs in user with backend using Firebase token
9. Backend verifies Firebase token and returns JWT
10. App stores JWT in `FFAppState().token`

#### Code Example:

```dart
// Send OTP
bool success = await FirebaseAuthService.sendOTP(
  phoneNumber: '1234567890',
  context: context,
  onCodeSent: (message) => print(message),
  onError: (error) => print(error),
);

// Verify OTP
UserCredential? credential = await FirebaseAuthService.verifyOTP(
  otpCode: '123456',
  onError: (error) => print(error),
);

// Get Firebase token
String? firebaseToken = await FirebaseAuthService.getIdToken();
```

### 5.2 JWT Token Management

**Storage:** `SharedPreferences` via `FFAppState`

```dart
// Save token
FFAppState().update(() {
  FFAppState().token = 'jwt_token_here';
});

// Use token in API calls
ProfileCall.call(token: FFAppState().token);
```

**Token Lifecycle:**
- Obtained during login/registration
- Stored in `FFAppState().token`
- Sent in `Authorization: Bearer {token}` header
- Expires after ~30 days
- Refreshed on app restart if valid

### 5.3 Protected Routes

Routes requiring authentication check `FFAppState().token`:

```dart
if (FFAppState().token.isEmpty) {
  context.goNamed('loginpage');
  return;
}
```

---

## 6. Core Features

### 6.1 Home Page

**File:** `lib/components/pages/home_page_copy/home_page_copy_widget.dart`

**Features:**
- Game listings with bet ranges
- Quick access to tournaments
- Wallet balance display
- Navigation to all sections

**Key Methods:**
```dart
// Fetch games
final gamesResponse = await GamesCall.call(token: FFAppState().token);

// Navigate to game
context.pushNamed('gamePage', extra: {'gameId': gameId});
```

### 6.2 Challenge System

**File:** `lib/components/pages/challenge_page/challenge_page_widget.dart`

**Flow:**
1. Select game and entry fee
2. Create challenge via `ChallengesCall`
3. Wait for opponent to accept
4. Game starts when both players ready
5. Players submit results
6. Winner gets prize money

**States:**
- `pending`: Waiting for opponent
- `active`: Game in progress
- `completed`: Game finished
- `disputed`: Results disputed
- `cancelled`: Challenge cancelled

### 6.3 Tournament System

**File:** `lib/components/pages/tournament_lobby/tournament_lobby_widget.dart`

**Features:**
- Browse available tournaments
- Register with entry fee
- View prize distribution
- Track player rankings
- Live tournament status

**Tournament Lifecycle:**
1. `registering`: Open for registration
2. `starting`: About to start
3. `active`: Tournament running
4. `completed`: Finished

### 6.4 Wallet Management

**Files:**
- `lib/components/pages/walletpage/walletpage_widget.dart`
- `lib/components/pages/add_money_page/add_money_page_widget.dart`
- `lib/components/pages/withdraw_page/withdraw_page_widget.dart`

**Wallet Structure:**
```dart
{
  "balance": 1000,           // Total available
  "depositAmount": 500,      // Added by user
  "winningAmount": 500,      // Won from games
  "bonusAmount": 0          // Promotional bonus
}
```

**Rules:**
- Withdrawal only from winning amount
- Minimum deposit: ₹50
- Minimum withdrawal: ₹100
- KYC required for withdrawals

### 6.5 Spin Wheel

**File:** `lib/components/spin_wheel/spin_wheel_widget.dart`

**Features:**
- Daily free spins
- Win coins/bonus
- Animated wheel with segments
- Reward distribution

**Implementation:**
```dart
// Spin wheel
final result = await SpinWheelCall.call(token: FFAppState().token);
int reward = getJsonField(result.jsonBody, r'''$.reward.amount''');
```

### 6.6 Community/Social Feed

**File:** `lib/components/pages/community_page/community_page_widget.dart`

**Features:**
- Create posts with images
- Like/comment on posts
- Follow/unfollow users
- View user profiles
- Share achievements

### 6.7 Notifications

**File:** `lib/components/pages/notification/notification_widget.dart`

**Notification Types:**
- Challenge invites
- Tournament updates
- Game results
- Wallet transactions
- System announcements

**Implementation:**
- Firebase Cloud Messaging (FCM)
- Local notifications
- Badge count updates

---

## 7. State Management

### 7.1 Global State (FFAppState)

**File:** `lib/app_state.dart`

**Stored Data:**
```dart
class FFAppState extends ChangeNotifier {
  String token = '';           // JWT token
  String userId = '';          // Current user ID
  int walletBalance = 0;       // Wallet balance
  bool isLoggedIn = false;     // Login status
  // ... more fields
}
```

**Usage:**
```dart
// Read
String token = FFAppState().token;

// Update
FFAppState().update(() {
  FFAppState().token = newToken;
});
```

### 7.2 Page-Level State

Each page has its own model extending `FlutterFlowModel`:

```dart
class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  // Text controllers
  TextEditingController? searchController;
  
  // Focus nodes
  FocusNode? searchFocusNode;
  
  // API responses
  ApiCallResponse? gamesResponse;
  
  @override
  void initState(BuildContext context) {
    searchController = TextEditingController();
  }
  
  @override
  void dispose() {
    searchController?.dispose();
    searchFocusNode?.dispose();
  }
}
```

### 7.3 Provider Pattern

```dart
// In widget
ChangeNotifierProvider(
  create: (context) => FFAppState(),
  child: MaterialApp(...),
);

// Access in descendants
final appState = Provider.of<FFAppState>(context);
```

---

## 8. Firebase Integration

### 8.1 Firebase Setup

**Configuration:** `lib/firebase_options.dart`

Generated via:
```bash
flutterfire configure
```

**Initialization:** `lib/main.dart`
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

### 8.2 Firebase Authentication

**Service:** `lib/services/firebase_auth_service.dart`

**Phone Authentication:**
- SMS-based OTP
- Auto-verification support
- Rate limiting built-in
- Works on Android, iOS, Web

**Test Phone Numbers:**
Configure in Firebase Console for testing without SMS charges.

### 8.3 Firebase Cloud Messaging

**Service:** `lib/flutter_flow/device_token_service.dart`

**Setup:**
```dart
// Initialize messaging
final messaging = FirebaseMessaging.instance;

// Request permission
await messaging.requestPermission();

// Get device token
String? token = await messaging.getToken();

// Register with backend
await DeviceToken.call(
  token: FFAppState().token,
  deviceToken: token,
);
```

**Handling Notifications:**
```dart
// Foreground messages
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  // Show notification
});

// Background messages
FirebaseMessaging.onBackgroundMessage(
  _firebaseMessagingBackgroundHandler
);

// Notification tap
FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  // Navigate to relevant page
});
```

---

## 9. UI Components

### 9.1 Page Structure

Each page follows this pattern:

```dart
class MyPageWidget extends StatefulWidget {
  const MyPageWidget({super.key});
  
  @override
  State<MyPageWidget> createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> {
  late MyPageModel _model;
  
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyPageModel());
  }
  
  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(...),
      body: /* UI */,
    );
  }
}
```

### 9.2 FlutterFlow Widgets

**FFButtonWidget:**
```dart
FFButtonWidget(
  onPressed: () async {
    // Action
  },
  text: 'Click Me',
  options: FFButtonOptions(
    height: 40,
    color: FlutterFlowTheme.of(context).primary,
    textStyle: FlutterFlowTheme.of(context).titleSmall,
    borderRadius: BorderRadius.circular(8),
  ),
)
```

**Theme System:**
```dart
// Access theme
final theme = FlutterFlowTheme.of(context);

// Use theme colors
color: theme.primary,
color: theme.secondary,
color: theme.tertiary,

// Use theme text styles
style: theme.bodyMedium,
style: theme.headlineLarge,
```

### 9.3 Custom Widgets

**GameOn Widget:** `lib/custom_code/widgets/game_on.dart`
- Custom game rendering
- Touch interaction
- Animation support

**GameOn2 Widget:** `lib/custom_code/widgets/game_on2.dart`
- Enhanced version of GameOn
- Additional features

### 9.4 Pop-ups/Dialogs

**Confirm OTP Dialog:** `lib/pop_ups/confirm_otp/confirm_otp_widget.dart`

```dart
await showDialog(
  context: context,
  builder: (context) => ConfirmOtpWidget(
    phoneNumber: phone,
    onOtpVerified: () {
      // Handle verification
    },
    onResendOtp: () {
      // Resend OTP
    },
  ),
);
```

**Game Page Dialog:** `lib/pop_ups/game_page/game_page_widget.dart`
- Fullscreen game interface
- Bet range selection
- Find opponent functionality

---

## 10. Workflows

### 10.1 User Registration Flow

```
┌──────────────┐
│ Signup Page  │
└──────┬───────┘
       │ Enter details
       ▼
┌──────────────┐
│ Send OTP     │ ← Firebase Auth
│ (Firebase)   │
└──────┬───────┘
       │ SMS sent
       ▼
┌──────────────┐
│ OTP Dialog   │
└──────┬───────┘
       │ Verify OTP
       ▼
┌──────────────┐
│ Firebase     │
│ Verification │
└──────┬───────┘
       │ Get Firebase Token
       ▼
┌──────────────┐
│ Register API │ ← Backend
│ (with token) │
└──────┬───────┘
       │ Returns JWT
       ▼
┌──────────────┐
│ Save JWT     │
│ in AppState  │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Register     │
│ Device Token │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  Home Page   │
└──────────────┘
```

### 10.2 Challenge Creation Flow

```
┌───────────────┐
│ Challenge     │
│ Page          │
└───────┬───────┘
        │ Select game & bet
        ▼
┌───────────────┐
│ Create        │
│ Challenge API │
└───────┬───────┘
        │ Challenge created
        ▼
┌───────────────┐
│ Wait for      │
│ Opponent      │
└───────┬───────┘
        │ Opponent joins
        ▼
┌───────────────┐
│ Game Starts   │
└───────┬───────┘
        │ Players play
        ▼
┌───────────────┐
│ Submit        │
│ Results       │
└───────┬───────┘
        │ Verify winner
        ▼
┌───────────────┐
│ Distribute    │
│ Winnings      │
└───────────────┘
```

### 10.3 Tournament Registration Flow

```
┌───────────────┐
│ Tournament    │
│ Lobby         │
└───────┬───────┘
        │ Browse tournaments
        ▼
┌───────────────┐
│ Select        │
│ Tournament    │
└───────┬───────┘
        │ View details
        ▼
┌───────────────┐
│ Register      │
│ (Pay fee)     │
└───────┬───────┘
        │ Wait for start
        ▼
┌───────────────┐
│ Tournament    │
│ Starts        │
└───────┬───────┘
        │ Play rounds
        ▼
┌───────────────┐
│ Leaderboard   │
│ Updates       │
└───────┬───────┘
        │ Tournament ends
        ▼
┌───────────────┐
│ Prize         │
│ Distribution  │
└───────────────┘
```

### 10.4 Wallet Transaction Flow

**Deposit:**
```
Add Money Page → Payment Gateway → Webhook → Update Balance → Confirmation
```

**Withdrawal:**
```
Withdraw Page → Verify KYC → Check Balance → Process Request → 
Bank Transfer → Update Balance → Confirmation
```

---

## 11. Database & Storage

### 11.1 Local Storage (SharedPreferences)

**Location:** `FFAppState` persists to SharedPreferences

**Stored Data:**
- User token (JWT)
- User ID
- Wallet balance (cached)
- App preferences
- Last sync timestamp

**Implementation:**
```dart
// Read
final prefs = await SharedPreferences.getInstance();
String? token = prefs.getString('ff_token');

// Write
await prefs.setString('ff_token', token);
```

### 11.2 Local Database (SQLite)

**Usage:** Game history, cached data

**Tables:**
- game_history
- cached_tournaments
- offline_messages

**Example:**
```dart
final db = await openDatabase('ful2win.db');

await db.insert('game_history', {
  'gameId': gameId,
  'result': result,
  'timestamp': DateTime.now().millisecondsSinceEpoch,
});
```

### 11.3 Remote Storage

**Backend:** All persistent data stored in backend database

**Firebase Storage:** Profile pictures, post images (if configured)

---

## 12. Third-Party Integrations

### 12.1 Payment Gateway

**Integration:** Razorpay / Paytm / UPI

**Flow:**
1. User selects amount
2. App initiates payment
3. Gateway handles transaction
4. Webhook notifies backend
5. Backend updates wallet
6. App refreshes balance

### 12.2 Audio System

**Package:** `just_audio: ^0.9.36`

**Usage:**
```dart
final player = AudioPlayer();
await player.setAsset('assets/audios/game_sound.mp3');
await player.play();
await player.pause();
await player.stop();
await player.dispose();
```

### 12.3 Image Handling

**Packages:**
- `cached_network_image`: Image caching
- `image_picker`: Camera/gallery access

**Upload:**
```dart
final pickedFile = await ImagePicker().pickImage(
  source: ImageSource.gallery,
);

if (pickedFile != null) {
  final uploadedFile = FFUploadedFile(
    bytes: await pickedFile.readAsBytes(),
    name: pickedFile.name,
  );
  
  await ProfilePictureCall.call(
    token: token,
    profilePicture: uploadedFile,
  );
}
```

### 12.4 Web View

**Package:** `webview_flutter: ^4.4.2`

**Usage:** Terms, Privacy Policy, Help pages

```dart
WebView(
  initialUrl: 'https://ful2win.com/terms',
  javascriptMode: JavascriptMode.unrestricted,
)
```

---

## 13. Build & Deployment

### 13.1 Development Build

```bash
# Run on connected device
flutter run

# Run with specific flavor
flutter run --flavor dev

# Run in release mode
flutter run --release
```

### 13.2 Android Build

**Debug APK:**
```bash
flutter build apk --debug
```

**Release APK:**
```bash
flutter build apk --release
```

**App Bundle (Google Play):**
```bash
flutter build appbundle --release
```

**Configuration:**
- `android/app/build.gradle`: Version, signing
- `android/app/google-services.json`: Firebase config
- `android/local.properties`: SDK paths

### 13.3 iOS Build

**Prerequisites:**
- macOS with Xcode
- Apple Developer account
- Provisioning profiles

**Build:**
```bash
flutter build ios --release
```

**Archive in Xcode:**
1. Open `ios/Runner.xcworkspace`
2. Product → Archive
3. Distribute to App Store

**Configuration:**
- `ios/Runner/Info.plist`: App settings
- `ios/Runner/GoogleService-Info.plist`: Firebase config

### 13.4 Version Management

**Update version:**

In `pubspec.yaml`:
```yaml
version: 1.0.2+3  # version_name+build_number
```

In `android/app/build.gradle`:
```gradle
versionCode 3
versionName "1.0.2"
```

In `ios/Runner/Info.plist`:
```xml
<key>CFBundleShortVersionString</key>
<string>1.0.2</string>
<key>CFBundleVersion</key>
<string>3</string>
```

### 13.5 Environment Configuration

**Development:**
```dart
const baseUrl = 'https://dev-api.fulboost.fun/api/';
```

**Staging:**
```dart
const baseUrl = 'https://staging-api.fulboost.fun/api/';
```

**Production:**
```dart
const baseUrl = 'https://api.fulboost.fun/api/';
```

---

## 14. Testing

### 14.1 Unit Tests

**Location:** `test/`

**Example:**
```dart
test('API call returns valid response', () async {
  final response = await GamesCall.call(token: 'test_token');
  expect(response.succeeded, isTrue);
  expect(response.jsonBody, isNotNull);
});
```

### 14.2 Widget Tests

```dart
testWidgets('Login page renders correctly', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  expect(find.text('Login'), findsOneWidget);
  expect(find.byType(TextField), findsNWidgets(2));
});
```

### 14.3 Integration Tests

**Location:** `integration_test/`

**Run:**
```bash
flutter test integration_test/app_test.dart
```

### 14.4 Test Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

---

## 15. Troubleshooting

### 15.1 Common Issues

#### Build Errors

**Error:** `Gradle sync failed`
**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

**Error:** `Firebase not initialized`
**Solution:**
```bash
flutterfire configure
```

#### Runtime Errors

**Error:** `Widget disposed` / `Context not mounted`
**Solution:**
```dart
if (!mounted) return;
// Use context only if mounted
```

**Error:** `Token expired`
**Solution:**
- Clear app data
- Re-login
- Implement token refresh

#### API Errors

**Error:** `401 Unauthorized`
**Solution:**
- Check token validity
- Re-login
- Verify API headers

**Error:** `500 Internal Server Error`
**Solution:**
- Check request body format
- Verify required fields
- Check backend logs

### 15.2 Debugging Tips

**Enable Debug Mode:**
```dart
const bool kDebugMode = true;

if (kDebugMode) {
  print('Debug info: $variable');
}
```

**Network Logging:**
```dart
// In api_manager.dart
print('Request: $apiUrl');
print('Body: $body');
print('Response: ${response.body}');
```

**State Inspection:**
```dart
// Use Flutter DevTools
// View widget tree, state, network calls
```

### 15.3 Performance Optimization

**Image Caching:**
```dart
CachedNetworkImage(
  imageUrl: url,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

**Lazy Loading:**
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
)
```

**Reduce Rebuilds:**
```dart
const MyWidget(); // Mark as const when possible
```

---

## Appendix

### A. File Naming Conventions

- **Widgets:** `*_widget.dart`
- **Models:** `*_model.dart`
- **Services:** `*_service.dart`
- **Constants:** `constants.dart`
- **Utils:** `utils.dart`

### B. Code Style Guide

**Follow Dart conventions:**
- Class names: `PascalCase`
- Variables/functions: `camelCase`
- Constants: `UPPER_SNAKE_CASE`
- Files: `snake_case.dart`

**Use meaningful names:**
```dart
// Good
final userToken = FFAppState().token;
final isGameActive = challenge.status == 'active';

// Bad
final t = FFAppState().token;
final a = challenge.status == 'active';
```

### C. Git Workflow

**Branches:**
- `main`: Production
- `develop`: Development
- `feature/*`: New features
- `bugfix/*`: Bug fixes

**Commit Messages:**
```
feat: Add spin wheel feature
fix: Resolve OTP verification issue
docs: Update API documentation
refactor: Simplify challenge logic
```

### D. Useful Commands

```bash
# Clean build
flutter clean && flutter pub get

# Check for updates
flutter pub outdated

# Analyze code
flutter analyze

# Format code
dart format lib/

# Generate icons
flutter pub run flutter_launcher_icons

# Check Flutter doctor
flutter doctor -v
```

### E. Contact & Support

**Developer Team:**
- Lead Developer: [Contact Info]
- Backend Team: [Contact Info]
- UI/UX Team: [Contact Info]

**Resources:**
- API Documentation: [Link]
- Design Files: [Figma Link]
- Project Management: [Jira/Trello Link]

---

**End of Developer Manual**

*Last Updated: October 28, 2025*  
*Version: 1.0*  
*For Ful2Win Gaming App v1.0.1+2*
