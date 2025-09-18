import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

import 'leader_board_page_model.dart';
export 'leader_board_page_model.dart';

class LeaderBoardPageWidget extends StatefulWidget {
  const LeaderBoardPageWidget({
    super.key,
    required this.gameId,
    required this.tournamentId,
    required this.gameName,
  });

  final String? gameId;
  final String? tournamentId;
  final String? gameName;

  static String routeName = 'LeaderBoardPage';
  static String routePath = '/leaderBoardPage';

  @override
  State<LeaderBoardPageWidget> createState() => _LeaderBoardPageWidgetState();
}

class _LeaderBoardPageWidgetState extends State<LeaderBoardPageWidget>
    with TickerProviderStateMixin {
  late LeaderBoardPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};
  late Future<ApiCallResponse> gameResponse;
  late Future<ApiCallResponse> leaderboard;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LeaderBoardPageModel());
    gameResponse = GameCall.call(
      gameId: widget.gameId,
    );
    leaderboard = LeaderboardSinglegameCall.call(
      roomId: widget.tournamentId,
      gameName: widget.gameName,
    );
    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

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
        loop: true,
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
        loop: true,
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

String truncateWithEllipsisEnd(String text, {int maxLength = 10}) {
  if (text.length <= maxLength) return text;
  return text.substring(0, maxLength) + "...";
}
 
  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiCallResponse>(
      future: gameResponse,
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
        final leaderBoardPageGameResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFF1565C0),
            body: SafeArea(
            top: true,
             child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/bgimage.png',
                  ).image,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF08162C), Color(0x2208162C)],
                        stops: [0, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 1),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 10, 30, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 0, 0),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xA60A1B33),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      width: 2,
                                    ),
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.safePop();
                                      _model.soundPlayer ??= AudioPlayer();
                                      if (_model.soundPlayer!.playing) {
                                        await _model.soundPlayer!.stop();
                                      }
                                      _model.soundPlayer!.setVolume(1);
                                      _model.soundPlayer!
                                          .setAsset('assets/audios/click.mp3')
                                          .then((_) =>
                                              _model.soundPlayer!.play());
                                    },
                                    child: Icon(
                                      Icons.chevron_left_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: const AlignmentDirectional(0, -1),
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: const Color(0xBB08162C),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      ),
                                      border: Border.all(
                                        color: const Color(0xFF00CFFF),
                                        width: 2,
                                      ),
                                    ),
                                    child: Text(
                                      'DETAILS',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .displayMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .displayMedium
                                                      .fontWeight,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            color: const Color(0xFFFBD34D),
                                            fontSize: 24,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .displayMedium
                                                    .fontWeight,
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 100,
                              height: 2,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00CFFF),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 100,
                                height: 2,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF00CFFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xBB08162C),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.network(
                                              getJsonField(
                                                leaderBoardPageGameResponse
                                                    .jsonBody,
                                                r'''$.data.assets.thumbnail''',
                                              ).toString(),
                                            ).image,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFF00CFFF),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      valueOrDefault<double>(
                                        MediaQuery.sizeOf(context).width < 350.0
                                            ? 10.0
                                            : 20.0,
                                        0.0,
                                      ),
                                      10,
                                      0,
                                      20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Prize Pool',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                        color: const Color(
                                                            0xFF00CFFF),
                                                        fontSize: 12,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                ),
                                                Text(
                                                  '10000',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                        color: const Color(
                                                            0xFF00CFFF),
                                                        fontSize: 16,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Tournament Spots',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                        color: const Color(
                                                            0xFF00CFFF),
                                                        fontSize: 12,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                ),
                                                Text(
                                                  '100/100',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                        color: const Color(
                                                            0xFF00CFFF),
                                                        fontSize: 16,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.italic,
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      valueOrDefault<double>(
                                        MediaQuery.sizeOf(context).width < 350.0
                                            ? 10.0
                                            : 20.0,
                                        0.0,
                                      ),
                                      10,
                                      0,
                                      20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Registration end',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                      color: const Color(
                                                          0xFF00CFFF),
                                                      fontSize: 12,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                              ),
                                              Text(
                                                '28 Aug / 12:08 PM',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                      color: const Color(
                                                          0xFF00CFFF),
                                                      fontSize: 12,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Results Out',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                      color: const Color(
                                                          0xFF00CFFF),
                                                      fontSize: 12,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                              ),
                                              Text(
                                                '28 Aug / 12:08 PM',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                      color: const Color(
                                                          0xFF00CFFF),
                                                      fontSize: 12,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF08162C), Color(0x0008162C)],
                          stops: [0, 1],
                          begin: AlignmentDirectional(0, -1),
                          end: AlignmentDirectional(0, 1),
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: const Alignment(0, 0),
                            child: TabBar(
                              labelColor: const Color(0xFFFBD34D),
                              unselectedLabelColor: const Color(0x9D4CC3FF),
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 13,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              unselectedLabelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 13,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              indicatorColor: const Color(0xFFFBD34D),
                              indicatorWeight: 3,
                              tabs: const [
                                Tab(
                                  text: 'PRIZES',
                                ),
                                Tab(
                                  text: 'LEADERBOARD',
                                ),
                                Tab(
                                  text: 'HOW TO PLAY',
                                ),
                              ],
                              controller: _model.tabBarController,
                              onTap: (i) async {
                                [() async {}, () async {}, () async {}][i]();
                              },
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _model.tabBarController,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 5, 10, 0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF0A1B33),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFF00CFFF),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 15),
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            physics: const AlwaysScrollableScrollPhysics(),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(10, 5, 0, 5),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              5, 0, 0, 0),
                                                      child: Text(
                                                        'Rank',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  color: const Color(
                                                                      0x9D4CC3FF),
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
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              5, 0, 15, 0),
                                                      child: Text(
                                                        'Prize',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  color: const Color(
                                                                      0x9D4CC3FF),
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
                                                    ),
                                                  ],
                                                ),
                                              ),
                                             
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            8, 0, 8, 10),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xBB08162C),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xFF00CFFF),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    -1, 0),
                                                            child: Container(
                                                              width: 140,
                                                              height: 50,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1, 0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            -1,
                                                                            0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        '#1',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .displaySmall
                                                                            .override(
                                                                              font: GoogleFonts.poppins(
                                                                                fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                fontStyle: FontStyle.italic,
                                                                              ),
                                                                              color: const Color(0xFF00CFFF),
                                                                              fontSize: 20,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                              fontStyle: FontStyle.italic,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            20,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                50,
                                                                            color:
                                                                                Color(0xFF00CFFF),
                                                                            offset:
                                                                                Offset(0, 0.0),
                                                                          )
                                                                        ],
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            FaIcon(
                                                                          FontAwesomeIcons
                                                                              .trophy,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                          size:
                                                                              24,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    1, 0),
                                                            child: Container(
                                                              width: 140,
                                                              height: 50,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color(
                                                                    0x2200CFFF),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1, 0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '1000',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .displaySmall
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.poppins(
                                                                              fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                              fontStyle: FontStyle.italic,
                                                                            ),
                                                                            color:
                                                                                const Color(0xFF00CFFF),
                                                                            fontSize:
                                                                                20,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ).animateOnPageLoad(
                                                        animationsMap[
                                                            'containerOnPageLoadAnimation3']!),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            8, 0, 8, 10),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xBB08162C),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xFF00CFFF),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    -1, 0),
                                                            child: Container(
                                                              width: 140,
                                                              height: 50,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1, 0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            -1,
                                                                            0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        '#2',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .displaySmall
                                                                            .override(
                                                                              font: GoogleFonts.poppins(
                                                                                fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                fontStyle: FontStyle.italic,
                                                                              ),
                                                                              color: const Color(0xFF00CFFF),
                                                                              fontSize: 20,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                              fontStyle: FontStyle.italic,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    1, 0),
                                                            child: Container(
                                                              width: 140,
                                                              height: 50,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1, 0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '500',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .displaySmall
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.poppins(
                                                                              fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                              fontStyle: FontStyle.italic,
                                                                            ),
                                                                            color:
                                                                                const Color(0xFF00CFFF),
                                                                            fontSize:
                                                                                20,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ).animateOnPageLoad(
                                                        animationsMap[
                                                            'containerOnPageLoadAnimation4']!),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            8, 0, 8, 10),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xBB08162C),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xFF00CFFF),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    -1, 0),
                                                            child: Container(
                                                              width: 140,
                                                              height: 50,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1, 0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            -1,
                                                                            0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        '#3',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .displaySmall
                                                                            .override(
                                                                              font: GoogleFonts.poppins(
                                                                                fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                fontStyle: FontStyle.italic,
                                                                              ),
                                                                              color: const Color(0xFF00CFFF),
                                                                              fontSize: 20,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                              fontStyle: FontStyle.italic,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    1, 0),
                                                            child: Container(
                                                              width: 140,
                                                              height: 50,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1, 0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '300',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .displaySmall
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.poppins(
                                                                              fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                              fontStyle: FontStyle.italic,
                                                                            ),
                                                                            color:
                                                                                const Color(0xFF00CFFF),
                                                                            fontSize:
                                                                                20,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            8, 0, 8, 10),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xBB08162C),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xFF00CFFF),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    -1, 0),
                                                            child: Container(
                                                              width: 140,
                                                              height: 50,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1, 0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            -1,
                                                                            0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        '#4-50',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .displaySmall
                                                                            .override(
                                                                              font: GoogleFonts.poppins(
                                                                                fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                fontStyle: FontStyle.italic,
                                                                              ),
                                                                              color: const Color(0xFF00CFFF),
                                                                              fontSize: 20,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                              fontStyle: FontStyle.italic,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    1, 0),
                                                            child: Container(
                                                              width: 140,
                                                              height: 50,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1, 0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '100',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .displaySmall
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.poppins(
                                                                              fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                              fontStyle: FontStyle.italic,
                                                                            ),
                                                                            color:
                                                                                const Color(0xFF00CFFF),
                                                                            fontSize:
                                                                                20,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SingleChildScrollView(
  child: Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF0A1B33),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: Border.all(
              color: const Color(0xFF00CFFF),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, -1),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      'Your total entries - 1',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: Text(
                          'Rank',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: const Color(0x9D4CC3FF),
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 0, 15, 0),
                        child: Text(
                          'Score',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: const Color(0x9D4CC3FF),
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<ApiCallResponse>(
                  future: leaderboard,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final leaderboardResponse = snapshot.data!;
                    final players = getJsonField(
                      leaderboardResponse.jsonBody,
                      r'''$.scores''',
                    ).toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        final player = players[index];
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 5, 10, 10),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xBB08162C),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF00CFFF),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          (index + 1).toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                                color: FlutterFlowTheme.of(context).secondary,
                                                fontSize: 20,
                                              ),
                                        ),
                                        const SizedBox(width: 10),
                                        ClipOval(
  child: Image.network(
    getJsonField(player, r'''$.profilePicture''').toString(),
    width: 40,
    height: 40,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        width: 40,
        height: 40,
        color: Colors.grey.shade800,
        child: const Icon(
          Icons.person,
          color: Colors.white,
          size: 24,
        ),
      );
    },
  ),
),

                                        const SizedBox(width: 10),
                                        Expanded(
  child: Text(
    truncateWithEllipsisEnd(
      getJsonField(player, r'''$.username''').toString(),
      maxLength: 10, // adjust to fit design
    ),
    maxLines: 1,
    overflow: TextOverflow.clip,
    style: FlutterFlowTheme.of(context).displaySmall.override(
          font: GoogleFonts.poppins(),
          color: FlutterFlowTheme.of(context).secondaryBackground,
          fontSize: 18,
        ),
  ),
),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    color: Color(0x3F00CFFF),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      getJsonField(player, r'''$.score''')
                                          .toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            fontSize: 20,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
),

                             SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 70),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Top image
        Container(
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.asset(
                'assets/images/leaderboard.png',
              ).image,
            ),
          ),
        ),

        // How to play container
        Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xBB08162C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            'How To Play',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 0.5, color: Color(0xFF746464)),

                    // Objective
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                      child: Text(
                        'Objective',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 10),
                      child: Text(
                        getJsonField(
                          leaderBoardPageGameResponse.jsonBody,
                          r'''$.data.rules.objective''',
                        ).toString(),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    const Divider(thickness: 0.5, color: Color(0xFF746464)),

                    // Rules
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 5),
                      child: Text(
                        'Rules',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 25, 10),
                      child: Column(
                        children: List.generate(
                          getJsonField(
                            leaderBoardPageGameResponse.jsonBody,
                            r'''$.data.rules.howToPlay''',
                          ).toList().length,
                          (index) {
                            final rule = getJsonField(
                              leaderBoardPageGameResponse.jsonBody,
                              r'''$.data.rules.howToPlay''',
                            ).toList()[index];

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}.',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                        fontSize: 18,
                                      ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    rule.toString(),
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation2']!),
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
