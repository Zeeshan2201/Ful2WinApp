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
        print(profilePageResponse.jsonBody);
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
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            // Add follow/unfollow logic here
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
                                          },
                                          text: 'Follow',
                                          options: FFButtonOptions(
                                            width: 100,
                                            height: 36,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                            color: const Color(0xFF00CFFF),
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
                                            getJsonField(
                                              profilePageResponse.jsonBody,
                                              r'''$.followersCount''',
                                            ).toString(),
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
                                            getJsonField(
                                              profilePageResponse.jsonBody,
                                              r'''$.followingCount''',
                                            ).toString(),
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
                              child: Row(
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
                                    '12 posts', // You can replace with actual post count
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

                            // Posts ListView (Future Implementation)
                            Container(
                              width: double.infinity,
                              height: 400, // Fixed height for ListView
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: ListView.builder(
                                itemCount: 5, // Placeholder count
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 10),
                                    child: Container(
                                      width: double.infinity,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: const Color(0xBB08162C),
                                        borderRadius: BorderRadius.circular(15),
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xFFE0E5E9),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.image,
                                                    color: Color(0xFF57636C),
                                                    size: 20,
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
                                                          'Post Title ${index + 1}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                        Text(
                                                          '2 hours ago',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white70,
                                                                fontSize: 10,
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
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                              child: Text(
                                                'This is a placeholder for post content. Future implementation will show actual user posts here.',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white70,
                                                          fontSize: 12,
                                                          letterSpacing: 0.0,
                                                        ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.white70,
                                                    size: 16,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            5, 0, 15, 0),
                                                    child: Text(
                                                      '${(index + 1) * 12}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodySmall
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                Colors.white70,
                                                            fontSize: 10,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.comment_outlined,
                                                    color: Colors.white70,
                                                    size: 16,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            5, 0, 0, 0),
                                                    child: Text(
                                                      '${(index + 1) * 3}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodySmall
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                Colors.white70,
                                                            fontSize: 10,
                                                            letterSpacing: 0.0,
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
}
