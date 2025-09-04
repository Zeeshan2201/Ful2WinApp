// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

//const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start FulWin Group Code

class FulWinGroup {
  static String getBaseUrl({
    String? token = '',
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

class ChallengesCall {
  static Future<ApiCallResponse> call({
    String? gameId = '',
    String? token = '',
    String? challengedUserId = '',
    String? message = '',
  }) async {
    final baseUrl = FulWinGroup.getBaseUrl(
      token: token,
    );
    final apiRequestBody = '''
{
  "gameId": "$gameId",
  "challengedUserId": "$challengedUserId",
  "message": "$message"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'challenges',
      apiUrl: '${baseUrl}challenges',
      callType: ApiCallType.GET,
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

class TournamentRegisterCall {
  Future<ApiCallResponse> call({
    String? tournamentId = '',
    String? userId = '',
    String? token = '',
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
    const ffApiRequestBody = '''
{
"fullName":"sanskruti",
"phoneNumber":9022975788,
"password":"sp@12345",
"email":"sp@gmail.com"

}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Register',
      apiUrl: 'https://api.fulboost.fun/api/users/register',
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

  static List<String>? gameNames(dynamic response) {
    return (getJsonField(response, r'$.games[:].name', true) as List?)
        ?.map((e) => e.toString())
        .toList();
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
    String? token = '',
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
    String? token = '',
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

  static List<String>? fullNames(dynamic response) {
    return (getJsonField(response, r'$.users[:].fullName', true) as List?)
        ?.map((e) => e.toString())
        .toList();
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

  static List<String>? gameNames(dynamic response) {
    return (getJsonField(response, r'$.games[:].displayName', true) as List?)
        ?.map((e) => e.toString())
        .toList();
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
    String? userId = '',
    String? fullName = '',
    String? email = '',
    int? phoneNumber,
    String? bio = '',
    String? gender = '',
    String? country = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'updateProfile',
      apiUrl: 'https://api.fulboost.fun/api/users/profile/$userId',
      callType: ApiCallType.PUT,
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
