import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

//const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start FulWin Group Code

class FulWinGroup {
  static String getBaseUrl({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NWMzMzBhYjdlMGY0ZDdkZWY3MTcxYiIsInBob25lTnVtYmVyIjoiMTExMTEyMjIyMyIsImlhdCI6MTc1NjM2MjAwMiwiZXhwIjoxNzU4OTU0MDAyfQ.MZkgthzElldrYawIWkF4vj1vCg-VBrhr1DQOboJg31g',
  }) =>
      'https://api.fulboost.fun/api/';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [token]',
  };
  static StatusCall statusCall = StatusCall();
  static TournamentRegisterCall tournamentRegisterCall =
      TournamentRegisterCall();
}

class MyReferrals {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'myReferrals',
      apiUrl: '${baseUrl}referrals/my-referrals',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
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

class Follow {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? userId = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Follow',
      apiUrl: '${baseUrl}follow/$userId/follow',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
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

class UnFollow {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? userId = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'UnFollow',
      apiUrl: '${baseUrl}follow/$userId/unfollow',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
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

class UsersPosts {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? userId = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'usersPosts',
      apiUrl: '${baseUrl}posts/users/$userId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
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

class ReferralCode {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'referralCode',
      apiUrl: '$baseUrl/referrals/my-code',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
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

class NotificationCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'notifications',
      apiUrl: '${baseUrl}notifications',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
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

class DeviceToken {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? deviceToken = '',
  }) async {
    const baseUrl = 'https://api.fulboost.fun/api/';
    final apiRequestBody = '''
{
  "deviceToken": "$deviceToken"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'deviceToken',
      apiUrl: '${baseUrl}device/register-device',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
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

// ============================================================
// DEPRECATED: Backend OTP implementation (commented out)
// Now using Firebase Authentication for OTP
// See: lib/services/firebase_auth_service.dart
// ============================================================

/*
class SendOTP {
  static Future<ApiCallResponse> call({
    String? phoneNumber = '',
  }) async {
    const baseUrl = 'https://api.fulboost.fun/api/';

    final apiRequestBody = '''
{
  "phoneNumber": "+91$phoneNumber"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'OTP',
      apiUrl: '${baseUrl}otp/send-otp',
      callType: ApiCallType.POST,
      headers: {},
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

class VerifyOTP {
  static Future<ApiCallResponse> call({
    String? phoneNumber = '',
    String? otp = '',
  }) async {
    const baseUrl = 'https://api.fulboost.fun/api/';

    final apiRequestBody = '''
{
  "phoneNumber": "+91$phoneNumber",
  "otp": "$otp"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'Verify OTP',
      apiUrl: '${baseUrl}otp/verify-otp',
      callType: ApiCallType.POST,
      headers: {},
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
*/

class StatusCall {
  Future<ApiCallResponse> call({
    String? tournamentId = '',
    String? token = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'status',
      apiUrl: '${baseUrl}tournaments/$tournamentId/status',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
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

class AcceptChallengeCall {
  static Future<ApiCallResponse> call({
    String? challengeId = '',
    String? token = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'acceptChallenge',
      apiUrl: '${baseUrl}challenges/$challengeId/accept',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
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

class RejectChallengeCall {
  static Future<ApiCallResponse> call({
    String? challengeId = '',
    String? token = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'rejectChallenge',
      apiUrl: '${baseUrl}challenges/$challengeId/reject',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
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

class GetChallengesCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getchallenges',
      apiUrl: '${baseUrl}challenges',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
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

class ChallangeScore {
  static Future<ApiCallResponse> call({
    String? challengeId = '',
    int? score,
    String? token = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );
    final apiRequestBody = '''
{
  "score": $score
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'challengeScore',
      apiUrl: '${baseUrl}challenges/$challengeId/score',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
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

class ChallengesCall {
  static Future<ApiCallResponse> call({
    String? gameId = '',
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NWMzMzBhYjdlMGY0ZDdkZWY3MTcxYiIsInBob25lTnVtYmVyIjoiMTExMTEyMjIyMyIsImlhdCI6MTc1NjM2MjAwMiwiZXhwIjoxNzU4OTU0MDAyfQ.MZkgthzElldrYawIWkF4vj1vCg-VBrhr1DQOboJg31g',
    String? challengedUserId = '',
    int? entryFee = 0,
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );
    final apiRequestBody = '''
{
  "gameId": "$gameId",
  "challengedUserId": "$challengedUserId",
  "entryFee": $entryFee
}''';
    print("apiRequestBody $apiRequestBody ");
    return ApiManager.instance.makeApiCall(
      callName: 'challenges',
      apiUrl: '${baseUrl}challenges',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
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

class UpdateStatusCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? status = '',
    String? tournamentId = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );
    final apiRequestBody = '''
{
  "status": "$status"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'updateStatus',
      apiUrl: '${baseUrl}tournaments/$tournamentId/status',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
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

class SpinWheelCall {
  static Future<ApiCallResponse> call({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NWMzMzBhYjdlMGY0ZDdkZWY3MTcxYiIsInBob25lTnVtYmVyIjoiMTExMTEyMjIyMyIsImlhdCI6MTc1NjM2MjAwMiwiZXhwIjoxNzU4OTU0MDAyfQ.MZkgthzElldrYawIWkF4vj1vCg-VBrhr1DQOboJg31g',
    int amount = 0,
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );
    final apiRequestBody = '''
{
  "amount": $amount
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'SpinWheel',
      apiUrl: '${baseUrl}wallet/spin-reward',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
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

class TournamentRegisterCall {
  Future<ApiCallResponse> call({
    String? tournamentId = '',
    String? userId = '',
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NWMzMzBhYjdlMGY0ZDdkZWY3MTcxYiIsInBob25lTnVtYmVyIjoiMTExMTEyMjIyMyIsImlhdCI6MTc1NjM2MjAwMiwiZXhwIjoxNzU4OTU0MDAyfQ.MZkgthzElldrYawIWkF4vj1vCg-VBrhr1DQOboJg31g',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    final apiRequestBody = '''
{
  "playerId": "$userId"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'tournamentRegister',
      apiUrl: '${baseUrl}tournaments/$tournamentId/register',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
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

class ChatsCall {
  static Future<ApiCallResponse> call({
    String? user1,
    String? user2,
    String? token,
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );
    final Map<String, dynamic> params = {
      'user1': user1,
      'user2': user2,
    };
    return ApiManager.instance.makeApiCall(
      callName: 'chats',
      apiUrl: '${baseUrl}messages/conversation',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: params,
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

class AddComment {
  static Future<ApiCallResponse> call({
    String? postId = '',
    String? content = '',
    String? token = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );
    final apiRequestBody = '''
{
  "content": "${escapeStringForJson(content)}"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'addComment',
      apiUrl: '${baseUrl}posts/$postId/comments',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
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

class SendChatCall {
  static Future<ApiCallResponse> call({
    String? content,
    String? recipient,
    String? token,
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );
    final apiRequestBody = '''
{
  "content": "$content",
  "recipient": "$recipient"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'sendChat',
      apiUrl: '${baseUrl}messages/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
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

class LikeAndUnlikeCall {
  static Future<ApiCallResponse> call({
    String? postId = '',
    String? isLike = '',
    String? token = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );
    final apiRequestBody = '''
{
  "postId": "$postId"
}''';
    print('Request body: $apiRequestBody, isLike: $isLike');
    return ApiManager.instance.makeApiCall(
      callName: 'likeAndUnlike',
      apiUrl: '${baseUrl}posts/$isLike',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
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

class CreatePostCall {
  static Future<ApiCallResponse> call({
    String? content,
    FFUploadedFile? image,
    String? token = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );

    // Create a map for the request parameters
    final Map<String, dynamic> params = {};

    // Add content as a form field if not empty
    if (content != null && content.trim().isNotEmpty) {
      params['content'] = content;
    }

    // Add image to params if exists
    if (image != null) {
      params['image'] = image;
    }

    print('Request params: $params');

    // Prepare the API call
    return ApiManager.instance.makeApiCall(
      callName: 'createPost',
      apiUrl: '${baseUrl}post/create/',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: params,
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End FulWin Group Code

class LogInCall {
  static Future<ApiCallResponse> call({
    int? phoneNumber = 9022975787,
    String? password = 'Swapnil@343',
  }) async {
    final ffApiRequestBody = '''
{
  "phoneNumber": $phoneNumber,
  "password": "${escapeStringForJson(password)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'LogIn',
      apiUrl: 'https://api.fulboost.fun/api/users/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
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

class RegisterCall {
  static Future<ApiCallResponse> call({
    String? fullname = '',
    int? phoneNumber,
    String? password = '',
    String? email = '',
  }) async {
    final apiRequestBody = '''
{
  "fullName": "$fullname",
  "phoneNumber": $phoneNumber,
  "password": "$password",
  "email": "$email"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Register',
      apiUrl: 'https://api.fulboost.fun/api/users/register',
      callType: ApiCallType.POST,
      headers: {},
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

class GamesCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'Games',
      apiUrl: 'https://api.fulboost.fun/api/games/',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LogOutCall {
  static Future<ApiCallResponse> call({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NjYyNzBhNjg3NjQ0MTIxYmFlYmI0ZCIsInBob25lTnVtYmVyIjoiOTAyMjk3NTc4NSIsImlhdCI6MTc1NTU5NjcyNywiZXhwIjoxNzU4MTg4NzI3fQ.ij7uZ7cGDnaFbJJm1QqJBaB1STHQ1wPn1_XUg6aSVhQ',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'LogOut',
      apiUrl: 'http://api.fulboost.fun/api/users/logout',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer$token',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TournamentsCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'Tournaments',
      apiUrl: 'https://api.fulboost.fun/api/tournaments',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ProfileCall {
  static Future<ApiCallResponse> call({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NWMzMzBhYjdlMGY0ZDdkZWY3MTcxYiIsInBob25lTnVtYmVyIjoiMTExMTEyMjIyMyIsImlhdCI6MTc1NjM2MjAwMiwiZXhwIjoxNzU4OTU0MDAyfQ.MZkgthzElldrYawIWkF4vj1vCg-VBrhr1DQOboJg31g',
    String? userId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'profile',
      apiUrl: 'https://api.fulboost.fun/api/users/profile/$userId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ProfilePictureCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? userId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'profilePicture',
      apiUrl: 'https://api.fulboost.fun/api/users/profile-picture/$userId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PostsCall {
  static Future<ApiCallResponse> call({
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NWMzMzBhYjdlMGY0ZDdkZWY3MTcxYiIsInBob25lTnVtYmVyIjoiMTExMTEyMjIyMyIsImlhdCI6MTc1NjM2MjAwMiwiZXhwIjoxNzU4OTU0MDAyfQ.MZkgthzElldrYawIWkF4vj1vCg-VBrhr1DQOboJg31g',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Posts',
      apiUrl: 'https://api.fulboost.fun/api/posts/',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LeaderboardSinglegameCall {
  static Future<ApiCallResponse> call({
    String? roomId = '',
    String? gameName = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'leaderboardSinglegame',
      apiUrl: 'https://api.fulboost.fun/api/score/get-score',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'roomId': roomId,
        'gameName': gameName,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AllUsersCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'All Users',
      apiUrl: 'https://api.fulboost.fun/api/users/all',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GameCall {
  static Future<ApiCallResponse> call({
    String? gameId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'game',
      apiUrl: 'https://api.fulboost.fun/api/games/$gameId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TournamentBygameCall {
  static Future<ApiCallResponse> call({
    String? gameId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'TournamentBygame',
      apiUrl: 'https://api.fulboost.fun/api/tournaments/game/$gameId',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SubmitScoreCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? userName = '',
    int? score,
    String? roomId = '',
    String? gameName = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userId": "${escapeStringForJson(userId)}",
  "userName": "${escapeStringForJson(userName)}",
  "score": $score,
  "roomId": "${escapeStringForJson(roomId)}",
  "gameName": "${escapeStringForJson(gameName)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SubmitScore',
      apiUrl: 'https://api.fulboost.fun/api/score/submit-score',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
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

class UpdateProfileCall {
  static Future<ApiCallResponse> call({
    required String userId,
    String? fullName,
    String? email,
    int? phoneNumber,
    String? bio,
    String? gender,
    String? country,
    String? token,
  }) async {
    // Get token from app state
    print(token);
    try {
      // Prepare request body
      final apiRequestBody = {
        if (fullName != null) 'fullName': fullName,
        if (email != null) 'email': email,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (bio != null) 'bio': bio,
        if (gender != null) 'gender': gender,
        if (country != null) 'country': country,
      };
      // Make the API call
      print(apiRequestBody);
      final response = await ApiManager.instance.makeApiCall(
        callName: 'updateProfile',
        apiUrl: 'https://api.fulboost.fun/api/users/profile/$userId',
        callType: ApiCallType.PUT,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(apiRequestBody),
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: true,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: true,
      );

      // Log the response for debugging
      debugPrint(
          'UpdateProfile API Response: ${response.statusCode} - ${response.jsonBody}');

      return response;
    } catch (e, stackTrace) {
      // Log the error for debugging
      debugPrint('Error in UpdateProfileCall: $e');
      debugPrint('Stack trace: $stackTrace');

      // Return a failed response with error details
      final errorResponse = jsonEncode({
        'success': false,
        'message': 'Failed to update profile: ${e.toString()}',
      });

      return ApiCallResponse(
        errorResponse,
        {'Content-Type': 'application/json'},
        500,
      );
    }
  }
}

class LikePostCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'likePost',
      apiUrl: 'https://api.fulboost.fun/api/posts/like',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
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

class CommentCall {
  static Future<ApiCallResponse> call({
    String? postId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'comment',
      apiUrl: 'https://api.fulboost.fun/api/$postId/comment',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
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

class NotificationsCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'notifications',
      apiUrl: 'https://api.fulboost.fun/api/notifications/all/$userId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

// String _toEncodable(dynamic item) {
//   return item;
// }

// String _serializeList(List? list) {
//   list ??= <String>[];
//   try {
//     return json.encode(list, toEncodable: _toEncodable);
//   } catch (_) {
//     if (kDebugMode) {
//       print("List serialization failed. Returning empty list.");
//     }
//     return '[]';
//   }
// }

// String _serializeJson(dynamic jsonVar, [bool isList = false]) {
//   jsonVar ??= (isList ? [] : {});
//   try {
//     return json.encode(jsonVar, toEncodable: _toEncodable);
//   } catch (_) {
//     if (kDebugMode) {
//       print("Json serialization failed. Returning empty json.");
//     }
//     return isList ? '[]' : '{}';
//   }
// }

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
