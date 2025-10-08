//import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pop_ups/navbar/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'profile_page_model.dart';
export 'profile_page_model.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({required this.userId, super.key});
  final String userId;
  static String routeName = 'UserProfile';
  static String routePath = '/user-profile';

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget>
    with TickerProviderStateMixin {
  late ProfilePageModel _model;
  late Future<ApiCallResponse> profileResponse;
  late Future<ApiCallResponse> userPostsResponse;

  // Local state for immediate UI updates
  bool? _isFollowingOverride;

  // Counter to force FutureBuilder rebuild
  int _rebuildCounter = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());
    profileResponse = ProfileCall.call(
      token: FFAppState().token,
      userId: widget.userId,
    );
    userPostsResponse = UsersPosts.call(
      token: FFAppState().token,
      userId: widget.userId,
    );
    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      key: ValueKey(_rebuildCounter),
      future: profileResponse,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: const Color(0xFF000B33),
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final profilePageResponse = snapshot.data!;
        // print(profilePageResponse.jsonBody);
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: const Color(0xFF1565C0),
            body: SafeArea(
              top: true,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/bgimage.png',
                    ).image,
                  ),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0B33FF), Color(0xFF000B33)],
                    stops: [0, 1],
                    begin: AlignmentDirectional(0, -1),
                    end: AlignmentDirectional(0, 1),
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 60),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Profile Header Section
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 40, 20, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.network(
                                              getJsonField(
                                                profilePageResponse.jsonBody,
                                                r'''$.profilePicture''',
                                              ).toString(),
                                            ).image,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(15, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getJsonField(
                                                  profilePageResponse.jsonBody,
                                                  r'''$.fullName''',
                                                ).toString(),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: const Color(
                                                              0xFFFAFFFF),
                                                          fontSize: 20,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                              Text(
                                                getJsonField(
                                                  profilePageResponse.jsonBody,
                                                  r'''$.username''',
                                                ).toString(),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: const Color(
                                                              0xFFFAFFFF),
                                                          fontSize: 12,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Follow Button (Left Aligned)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                    child: Row(
                                      key: ValueKey(_isFollowingOverride),
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            // Play sound
                                            _model.soundPlayer1 ??=
                                                AudioPlayer();
                                            if (_model.soundPlayer1!.playing) {
                                              await _model.soundPlayer1!.stop();
                                            }
                                            _model.soundPlayer1!.setVolume(1);
                                            _model.soundPlayer1!
                                                .setAsset(
                                                    'assets/audios/click.mp3')
                                                .then((_) => _model
                                                    .soundPlayer1!
                                                    .play());

                                            // Check current follow status from followers array
                                            final followersList = getJsonField(
                                              profilePageResponse.jsonBody,
                                              r'''$.followers''',
                                            );

                                            bool isFollowing = false;
                                            if (followersList != null) {
                                              // Extract the 'id' field from each follower object
                                              final followers = (followersList
                                                      as List)
                                                  .map((follower) {
                                                    if (follower is Map) {
                                                      // Try 'id' first, then '_id'
                                                      return follower['id']
                                                              ?.toString() ??
                                                          follower['_id']
                                                              ?.toString() ??
                                                          '';
                                                    }
                                                    return follower.toString();
                                                  })
                                                  .where((id) => id.isNotEmpty)
                                                  .toList();

                                              isFollowing = followers.contains(
                                                  FFAppState().userId);
                                            }

                                            // Determine current state: use override if exists, otherwise use API data
                                            final currentlyFollowing =
                                                _isFollowingOverride ??
                                                    isFollowing;

                                            print(
                                                "=== FOLLOW/UNFOLLOW DEBUG ===");
                                            print(
                                                "Current button state (before click): ${currentlyFollowing ? 'UNFOLLOW' : 'FOLLOW'}");
                                            print(
                                                "Will call: ${currentlyFollowing ? 'UNFOLLOW' : 'FOLLOW'} API");

                                            // Optimistically toggle UI state
                                            setState(() {
                                              _isFollowingOverride =
                                                  !currentlyFollowing;
                                            });

                                            print(
                                                "New button state (after click): ${!currentlyFollowing ? 'UNFOLLOW' : 'FOLLOW'}");
                                            print(
                                                "================================");

                                            // Call appropriate API based on CURRENT state
                                            if (currentlyFollowing) {
                                              // Currently following (button shows Unfollow) → Call Unfollow
                                              print("Calling UNFOLLOW API...");
                                              final unfollowResponse =
                                                  await UnFollow.call(
                                                token: FFAppState().token,
                                                userId: widget.userId,
                                              );

                                              print(
                                                  "=== UNFOLLOW RESPONSE ===");
                                              print(
                                                  "Status Code: ${unfollowResponse.statusCode}");
                                              print(
                                                  "Succeeded: ${unfollowResponse.succeeded}");
                                              print(
                                                  "Response Body: ${unfollowResponse.jsonBody}");
                                              print(
                                                  "Response Body Type: ${unfollowResponse.jsonBody.runtimeType}");
                                              print("========================");

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Unfollowed successfully',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  backgroundColor:
                                                      Color(0xFF6C757D),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            } else {
                                              // Currently not following (button shows Follow) → Call Follow
                                              print("Calling FOLLOW API...");
                                              final followResponse =
                                                  await Follow.call(
                                                token: FFAppState().token,
                                                userId: widget.userId,
                                              );

                                              print("=== FOLLOW RESPONSE ===");
                                              print(
                                                  "Status Code: ${followResponse.statusCode}");
                                              print(
                                                  "Succeeded: ${followResponse.succeeded}");
                                              print(
                                                  "Response Body: ${followResponse.jsonBody}");
                                              print(
                                                  "Response Body Type: ${followResponse.jsonBody.runtimeType}");
                                              print("======================");

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Followed successfully',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  backgroundColor:
                                                      Color(0xFF00CFFF),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            }
                                          },
                                          text: () {
                                            // Check if we have an override state (from local toggle)
                                            if (_isFollowingOverride != null) {
                                              return _isFollowingOverride!
                                                  ? 'Unfollow'
                                                  : 'Follow';
                                            }

                                            // Otherwise check the API data
                                            final followersList = getJsonField(
                                              profilePageResponse.jsonBody,
                                              r'''$.followers''',
                                            );

                                            if (followersList != null) {
                                              final followers = (followersList
                                                      as List)
                                                  .map((follower) {
                                                    if (follower is Map) {
                                                      return follower['id']
                                                              ?.toString() ??
                                                          follower['_id']
                                                              ?.toString() ??
                                                          '';
                                                    }
                                                    return follower.toString();
                                                  })
                                                  .where((id) => id.isNotEmpty)
                                                  .toList();

                                              return followers.contains(
                                                      FFAppState().userId)
                                                  ? 'Unfollow'
                                                  : 'Follow';
                                            }
                                            return 'Follow';
                                          }(),
                                          options: FFButtonOptions(
                                            height: 40,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(24, 0, 24, 0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                            color: () {
                                              // Check if we have an override state
                                              if (_isFollowingOverride !=
                                                  null) {
                                                return _isFollowingOverride!
                                                    ? const Color(0xFF6C757D)
                                                    : const Color(0xFF00CFFF);
                                              }

                                              // Check if current user is in the followers list
                                              final followersList =
                                                  getJsonField(
                                                profilePageResponse.jsonBody,
                                                r'''$.followers''',
                                              );

                                              if (followersList != null) {
                                                // Extract the 'id' field from each follower object
                                                final followers = (followersList
                                                        as List)
                                                    .map((follower) {
                                                      if (follower is Map) {
                                                        return follower['id']
                                                                ?.toString() ??
                                                            follower['_id']
                                                                ?.toString() ??
                                                            '';
                                                      }
                                                      return follower
                                                          .toString();
                                                    })
                                                    .where(
                                                        (id) => id.isNotEmpty)
                                                    .toList();

                                                return followers.contains(
                                                        FFAppState().userId)
                                                    ? const Color(0xFF6C757D)
                                                    : const Color(0xFF00CFFF);
                                              }
                                              return const Color(0xFF00CFFF);
                                            }(),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                            elevation: 0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Stats Section - Followers and Following
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Followers
                                  Expanded(
                                    child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: const Color(0xBB08162C),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: const Color(0xFF00CFFF),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            () {
                                              final followersList =
                                                  getJsonField(
                                                profilePageResponse.jsonBody,
                                                r'''$.followers''',
                                              );

                                              int baseCount = 0;
                                              bool userIsInList = false;

                                              if (followersList != null) {
                                                final followerList =
                                                    followersList as List;
                                                baseCount = followerList.length;

                                                // Check if current user is in the followers list
                                                final followers = followerList
                                                    .map((follower) {
                                                      if (follower is Map) {
                                                        return follower['id']
                                                                ?.toString() ??
                                                            follower['_id']
                                                                ?.toString() ??
                                                            '';
                                                      }
                                                      return follower
                                                          .toString();
                                                    })
                                                    .where(
                                                        (id) => id.isNotEmpty)
                                                    .toList();

                                                userIsInList =
                                                    followers.contains(
                                                        FFAppState().userId);
                                              }

                                              // Adjust count based on local override
                                              if (_isFollowingOverride !=
                                                  null) {
                                                // If override says following but not in list, add 1
                                                if (_isFollowingOverride! &&
                                                    !userIsInList) {
                                                  baseCount++;
                                                }
                                                // If override says not following but in list, subtract 1
                                                else if (!_isFollowingOverride! &&
                                                    userIsInList) {
                                                  baseCount--;
                                                }
                                              }

                                              // Ensure count doesn't go below 0
                                              if (baseCount < 0) baseCount = 0;

                                              return baseCount.toString();
                                            }(),
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            'Followers',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  // Following
                                  Expanded(
                                    child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: const Color(0xBB08162C),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: const Color(0xFF00CFFF),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            () {
                                              final followingList =
                                                  getJsonField(
                                                profilePageResponse.jsonBody,
                                                r'''$.following''',
                                              );
                                              if (followingList != null) {
                                                return (followingList as List)
                                                    .length
                                                    .toString();
                                              }
                                              return '0';
                                            }(),
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            'Following',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  // Wins
                                  Expanded(
                                    child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: const Color(0xBB08162C),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: const Color(0xFF00CFFF),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.emoji_events,
                                            color: Color(0xFFFFD700),
                                            size: 28,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '150',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            'Wins',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Posts Section Header
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 30, 20, 10),
                              child: FutureBuilder<ApiCallResponse>(
                                future: userPostsResponse,
                                builder: (context, postsSnapshot) {
                                  final postsCount = postsSnapshot.hasData
                                      ? (getJsonField(
                                            postsSnapshot.data!.jsonBody,
                                            r'''$.length''',
                                          ) ??
                                          0)
                                      : 0;
                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Posts',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 18,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        '$postsCount posts',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white70,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            // Posts ListView
                            FutureBuilder<ApiCallResponse>(
                              future: userPostsResponse,
                              builder: (context, postsSnapshot) {
                                // Show loading indicator while fetching posts
                                if (!postsSnapshot.hasData) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 400,
                                    child: Center(
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                final postsData = getJsonField(
                                      postsSnapshot.data!.jsonBody,
                                      r'''$''',
                                      true,
                                    ) as List? ??
                                    [];

                                if (postsData.isEmpty) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: Center(
                                      child: Text(
                                        'No posts yet',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white70,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  );
                                }

                                return Container(
                                  width: double.infinity,
                                  height: 400,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: ListView.builder(
                                    itemCount: postsData.length,
                                    itemBuilder: (context, index) {
                                      final postItem = postsData[index];
                                      final likeCount = getJsonField(
                                            postItem,
                                            r'''$.likeCount''',
                                          ) ??
                                          0;
                                      final commentCount = getJsonField(
                                            postItem,
                                            r'''$.commentCount''',
                                          ) ??
                                          0;
                                      final content = getJsonField(
                                        postItem,
                                        r'''$.content''',
                                      ).toString();
                                      final createdAt = getJsonField(
                                        postItem,
                                        r'''$.createdAt''',
                                      ).toString();
                                      final postImage = getJsonField(
                                        postItem,
                                        r'''$.image''',
                                      )?.toString();

                                      return Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 10),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0xBB08162C),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: const Color(0xFF00CFFF)
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(15, 15, 15, 15),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Post header with profile picture
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: Image.network(
                                                            getJsonField(
                                                              profilePageResponse
                                                                  .jsonBody,
                                                              r'''$.profilePicture''',
                                                            ).toString(),
                                                          ).image,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                10, 0, 0, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              getJsonField(
                                                                profilePageResponse
                                                                    .jsonBody,
                                                                r'''$.fullName''',
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                            Text(
                                                              _formatTimeAgo(
                                                                  createdAt),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white70,
                                                                    fontSize:
                                                                        10,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Post content
                                                if (content.isNotEmpty)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 10, 0, 0),
                                                    child: Text(
                                                      content,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                // Post image
                                                if (postImage != null &&
                                                    postImage.isNotEmpty)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 10, 0, 0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        postImage,
                                                        width: double.infinity,
                                                        height: 200,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                // Like and comment counts
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 10, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      const Icon(
                                                        Icons.favorite,
                                                        color:
                                                            Color(0xFFFF0000),
                                                        size: 18,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                5, 0, 15, 0),
                                                        child: Text(
                                                          likeCount.toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.comment_outlined,
                                                        color: Colors.white70,
                                                        size: 18,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                5, 0, 0, 0),
                                                        child: Text(
                                                          commentCount
                                                              .toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Navigation Bar
                    wrapWithModel(
                      model: _model.navbarModel,
                      updateCallback: () => setState(() {}),
                      child: const NavbarWidget(
                        pageNav: 'ProfilePage',
                      ),
                    ),
                  ],
                ),
              ).animateOnPageLoad(
                  animationsMap['containerOnPageLoadAnimation1']!),
            ),
          ),
        );
      },
    );
  }

  String _formatTimeAgo(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 7) {
        return '${difference.inDays ~/ 7} week${difference.inDays ~/ 7 > 1 ? 's' : ''} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Recently';
    }
  }
}
