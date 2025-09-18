import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pop_ups/header/header_widget.dart';
import '/pop_ups/navbar/navbar_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'communitymembers_model.dart';
export 'communitymembers_model.dart';

class CommunitymembersWidget extends StatefulWidget {
  const CommunitymembersWidget({super.key});

  static String routeName = 'Communitymembers';
  static String routePath = '/communitymembers';

  @override
  State<CommunitymembersWidget> createState() => _CommunitymembersWidgetState();
}

class _CommunitymembersWidgetState extends State<CommunitymembersWidget>
    with TickerProviderStateMixin {
  late CommunitymembersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};
  late Future<ApiCallResponse> allUsersResponse;
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommunitymembersModel());
    allUsersResponse = AllUsersCall.call(
      token: FFAppState().token,
    );
    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeIn,
            delay: 180.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: const Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: const Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: const Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: const Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation6': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: const Color(0x80FFFFFF),
            angle: 0.524,
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1565C0),
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
          gradient: LinearGradient(
            colors: [
              FlutterFlowTheme.of(context).primary,
              FlutterFlowTheme.of(context).secondary
            ],
            stops: const [0, 1],
            begin: const AlignmentDirectional(0, -1),
            end: const AlignmentDirectional(0, 1),
          ),
        ),
        child: Stack(
          children: [
            wrapWithModel(
              model: _model.headerModel,
              updateCallback: () => safeSetState(() {}),
              child: const HeaderWidget(),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Community Members',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: const Color(0xFFFBD34D),
                              fontSize: 24,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width < 350.0
                              ? 300.0
                              : 350.0,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF0BC1FF),
                                                Color(0xFF0A2472)
                                              ],
                                              stops: [0, 1],
                                              begin:
                                                  AlignmentDirectional(0, -1),
                                              end: AlignmentDirectional(0, 1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: FlutterFlowIconButton(
                                            borderRadius: 50,
                                            buttonSize: 36,
                                            fillColor: Colors.transparent,
                                            icon: Icon(
                                              Icons.home_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              size: 20,
                                            ),
                                            onPressed: () async {
                                              context.pushNamed(
                                                CommunityPageWidget.routeName,
                                                queryParameters: {
                                                  'isExpanded': serializeParam(
                                                    false,
                                                    ParamType.bool,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                            'containerOnPageLoadAnimation2']!),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(5, 0, 0, 0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFFF3E2C2),
                                                  Color(0xFFE1B769)
                                                ],
                                                stops: [0, 1],
                                                begin:
                                                    AlignmentDirectional(0, -1),
                                                end: AlignmentDirectional(0, 1),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: FlutterFlowIconButton(
                                              borderRadius: 50,
                                              buttonSize: 36,
                                              fillColor: Colors.transparent,
                                              icon: Icon(
                                                Icons.chat_bubble_outline,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                          ).animateOnPageLoad(animationsMap[
                                              'containerOnPageLoadAnimation3']!),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0x33FFFFFF),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                alignment: const AlignmentDirectional(0, 0),
                                child: Text(
                                  'Chat',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: const Color(0xFFFBD34D),
                                        fontSize: 20,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation4']!),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF0BC1FF),
                                              Color(0xFF0A2472)
                                            ],
                                            stops: [0, 1],
                                            begin: AlignmentDirectional(0, -1),
                                            end: AlignmentDirectional(0, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: FlutterFlowIconButton(
                                          borderRadius: 50,
                                          buttonSize: 36,
                                          fillColor: Colors.transparent,
                                          icon: Icon(
                                            Icons.sensor_occupied,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            size: 20,
                                          ),
                                          onPressed: () async {
                                            context.pushNamed(
                                                ChallengePageWidget.routeName);
                                          },
                                        ),
                                      ).animateOnPageLoad(animationsMap[
                                          'containerOnPageLoadAnimation5']!),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 0, 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF0BC1FF),
                                                Color(0xFF0A2472)
                                              ],
                                              stops: [0, 1],
                                              begin:
                                                  AlignmentDirectional(0, -1),
                                              end: AlignmentDirectional(0, 1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: FlutterFlowIconButton(
                                            borderRadius: 50,
                                            buttonSize: 36,
                                            fillColor: Colors.transparent,
                                            icon: Icon(
                                              Icons.leaderboard_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              size: 20,
                                            ),
                                            onPressed: () async {
                                              context.pushNamed(
                                                  CommunityPageWidget
                                                      .routeName);
                                            },
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                            'containerOnPageLoadAnimation6']!),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: FutureBuilder<ApiCallResponse>(
                      future: allUsersResponse,
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final listViewAllUsersResponse = snapshot.data!;

                        return Builder(
                          builder: (context) {
                            final chatUsers = getJsonField(
                              listViewAllUsersResponse.jsonBody,
                              r'''$.data''',
                            ).toList();

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: chatUsers.length,
                              itemBuilder: (context, chatUsersIndex) {
                                final chatUsersItem = chatUsers[chatUsersIndex];
                                return SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            MessageWidget.routeName,
                                            queryParameters: {
                                              'user2': serializeParam(
                                                getJsonField(
                                                  chatUsersItem,
                                                  r'''$._id''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 236.3,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                              alignment:
                                                  const AlignmentDirectional(
                                                      0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                10, 0, 0, 0),
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            getJsonField(
                                                              chatUsersItem,
                                                              r'''$.profilePicture''',
                                                            ).toString(),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            10, 0, 0, 0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          getJsonField(
                                                            chatUsersItem,
                                                            r'''$.fullName''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              'Received. ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Text(
                                                              '2h',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  FlutterFlowIconButton(
                                                    borderRadius: 8,
                                                    buttonSize: 40,
                                                    fillColor:
                                                        Colors.transparent,
                                                    icon: Icon(
                                                      Icons.chat_bubble_outline,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      size: 20,
                                                    ),
                                                    onPressed: () async {
                                                      context.pushNamed(
                                                        MessageWidget.routeName,
                                                        queryParameters: {
                                                          'user2':
                                                              serializeParam(
                                                            getJsonField(
                                                              chatUsersItem,
                                                              r'''$._id''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 2,
                                        color: Color(0xFF00CFFF),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ]
                    .divide(const SizedBox(height: 20))
                    .around(const SizedBox(height: 20)),
              ),
            ),
            wrapWithModel(
              model: _model.navbarModel,
              updateCallback: () => safeSetState(() {}),
              child: const NavbarWidget(
                pageNav: 'CommunityPage',
              ),
            ),
          ],
        ),
      ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
    ),);
  }
}
