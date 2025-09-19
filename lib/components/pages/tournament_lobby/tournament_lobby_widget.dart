import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pop_ups/header/header_widget.dart';
import '/pop_ups/howto_playtournament/howto_playtournament_widget.dart';
import '/pop_ups/registration_tournament_pop_up/registration_tournament_pop_up_widget.dart';
//import 'dart:math';
//import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'tournament_lobby_model.dart';
export 'tournament_lobby_model.dart';

class TournamentLobbyWidget extends StatefulWidget {
  const TournamentLobbyWidget({
    super.key,
    required this.gameId,
  });
  final String? gameId;

  static String routeName = 'TournamentLobby';
  static String routePath = '/tournamentLobby';

  @override
  State<TournamentLobbyWidget> createState() => _TournamentLobbyWidgetState();
}

class _TournamentLobbyWidgetState extends State<TournamentLobbyWidget>
    with TickerProviderStateMixin {
  late TournamentLobbyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};
  late Future<ApiCallResponse> gameResponse;
  late Future<ApiCallResponse> tournamentResponse;
  final Set<String> _updatedToLive = <String>{};
  final Set<String> _updatedToCompleted = <String>{};
  final Set<String> _updateInFlight = <String>{};
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TournamentLobbyModel());
    gameResponse = GameCall.call(
      gameId: widget.gameId,
    );
    tournamentResponse = TournamentBygameCall.call(
      gameId: widget.gameId,
    );
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/bgimage.png',
                ).image,
              ),
              gradient: LinearGradient(
                colors: [
                  FlutterFlowTheme.of(context).primary,
                  const Color(0xFF000B33)
                ],
                stops: const [0, 1],
                begin: const AlignmentDirectional(0, -1),
                end: const AlignmentDirectional(0, 1),
              ),
            ),
            child: Stack(
              children: [
                FutureBuilder<ApiCallResponse>(
                  future: gameResponse,
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
                    final columnGameResponse = snapshot.data!;

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        wrapWithModel(
                          model: _model.headerModel,
                          updateCallback: () => safeSetState(() {}),
                          child: const HeaderWidget(),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 0, 10, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.safePop();
                                  _model.soundPlayer1 ??= AudioPlayer();
                                  if (_model.soundPlayer1!.playing) {
                                    await _model.soundPlayer1!.stop();
                                  }
                                  _model.soundPlayer1!.setVolume(1);
                                  _model.soundPlayer1!
                                      .setAsset('assets/audios/click.mp3')
                                      .then((_) => _model.soundPlayer1!.play());
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  size: 24,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 0, 0),
                                child: Text(
                                  getJsonField(
                                    columnGameResponse.jsonBody,
                                    r'''$.data.displayName''',
                                  ).toString(),
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        fontSize: 28,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 20, 10, 0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0x85FFFFFF),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 0),
                                  child: Icon(
                                    Icons.search_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 24,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                    child: SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                        controller: _model.textController,
                                        focusNode: _model.textFieldFocusNode,
                                        autofocus: false,
                                        obscureText: false,
                                        onChanged: (_) => setState(() {}),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                          hintText: 'Search tournaments...',
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        enableInteractiveSelection: true,
                                        validator: _model
                                            .textControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 0))
                                  .around(const SizedBox(width: 0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  _model.selectedCategory = 'All';
                                  safeSetState(() {});
                                  _model.soundPlayer2 ??= AudioPlayer();
                                  if (_model.soundPlayer2!.playing) {
                                    await _model.soundPlayer2!.stop();
                                  }
                                  _model.soundPlayer2!.setVolume(1);
                                  _model.soundPlayer2!
                                      .setAsset('assets/audios/click.mp3')
                                      .then((_) => _model.soundPlayer2!.play());
                                },
                                text: 'All',
                                options: FFButtonOptions(
                                  height: 35,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                  color: _model.selectedCategory == 'All'
                                      ? const Color(0xFFFFD600)
                                      : const Color(0xFF191A47),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: _model.selectedCategory == 'All'
                                            ? FlutterFlowTheme.of(context)
                                                .primaryText
                                            : FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        fontSize: 8,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  _model.selectedCategory = 'Upcoming';
                                  safeSetState(() {});
                                  _model.soundPlayer3 ??= AudioPlayer();
                                  if (_model.soundPlayer3!.playing) {
                                    await _model.soundPlayer3!.stop();
                                  }
                                  _model.soundPlayer3!.setVolume(1);
                                  _model.soundPlayer3!
                                      .setAsset('assets/audios/click.mp3')
                                      .then((_) => _model.soundPlayer3!.play());
                                },
                                text: 'Upcoming',
                                options: FFButtonOptions(
                                  height: 35,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                  color: _model.selectedCategory == 'Upcoming'
                                      ? const Color(0xFFFFD600)
                                      : const Color(0xFF191A47),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: _model.selectedCategory ==
                                                'Upcoming'
                                            ? FlutterFlowTheme.of(context)
                                                .primaryText
                                            : FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        fontSize: 8,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  _model.selectedCategory = 'Live';
                                  safeSetState(() {});
                                  _model.soundPlayer4 ??= AudioPlayer();
                                  if (_model.soundPlayer4!.playing) {
                                    await _model.soundPlayer4!.stop();
                                  }
                                  _model.soundPlayer4!.setVolume(1);
                                  _model.soundPlayer4!
                                      .setAsset('assets/audios/click.mp3')
                                      .then((_) => _model.soundPlayer4!.play());
                                },
                                text: 'Live',
                                options: FFButtonOptions(
                                  height: 35,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                  color: _model.selectedCategory == 'Live'
                                      ? const Color(0xFFFFD600)
                                      : const Color(0xFF191A47),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: _model.selectedCategory == 'Live'
                                            ? FlutterFlowTheme.of(context)
                                                .primaryText
                                            : FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        fontSize: 8,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  _model.selectedCategory = 'Completed';
                                  safeSetState(() {});
                                  _model.soundPlayer5 ??= AudioPlayer();
                                  if (_model.soundPlayer5!.playing) {
                                    await _model.soundPlayer5!.stop();
                                  }
                                  _model.soundPlayer5!.setVolume(1);
                                  _model.soundPlayer5!
                                      .setAsset('assets/audios/click.mp3')
                                      .then((_) => _model.soundPlayer5!.play());
                                },
                                text: 'Completed',
                                options: FFButtonOptions(
                                  height: 35,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                  color: _model.selectedCategory == 'Completed'
                                      ? const Color(0xFFFFD600)
                                      : const Color(0xFF191A47),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: _model.selectedCategory ==
                                                'Completed'
                                            ? FlutterFlowTheme.of(context)
                                                .primaryText
                                            : FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        fontSize: 8,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ].divide(const SizedBox(width: 2)),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -1),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 280, 0, 10),
                    child: FutureBuilder<ApiCallResponse>(
                      future: gameResponse,
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
                        final containerGameResponse = snapshot.data!;

                        return Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(),
                          child: FutureBuilder<ApiCallResponse>(
                            future: tournamentResponse,
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
                              final listViewTournamentBygameResponse =
                                  snapshot.data!;

                              return Builder(
                                builder: (context) {
                                  final allTournaments = getJsonField(
                                    listViewTournamentBygameResponse.jsonBody,
                                    r'''$.data''',
                                  ).toList();

                                  DateTime? _parseDate(
                                      dynamic obj, String path) {
                                    final val = getJsonField(obj, path);
                                    if (val == null) return null;
                                    final str = val.toString();
                                    final iso = DateTime.tryParse(str);
                                    if (iso != null) return iso;
                                    try {
                                      final ms = int.parse(str);
                                      return DateTime
                                          .fromMillisecondsSinceEpoch(
                                        ms,
                                        isUtc: true,
                                      );
                                    } catch (_) {
                                      return null;
                                    }
                                  }

                                  String _computeStatus(dynamic t) {
                                    final raw =
                                        getJsonField(t, r'''$.status''');
                                    if (raw != null) {
                                      final s =
                                          raw.toString().trim().toLowerCase();
                                      if (s.contains('upcoming'))
                                        return 'Upcoming';
                                      if (s.contains('live') ||
                                          s.contains('running')) return 'Live';
                                      if (s.contains('complete'))
                                        return 'Completed';
                                    }
                                    final now = DateTime.now().toUtc();
                                    final start =
                                        _parseDate(t, r'''$.startTime''') ??
                                            _parseDate(t, r'''$.startDate''') ??
                                            _parseDate(t, r'''$.start''') ??
                                            _parseDate(t, r'''$.startAt''');
                                    final end =
                                        _parseDate(t, r'''$.endTime''') ??
                                            _parseDate(t, r'''$.endDate''') ??
                                            _parseDate(t, r'''$.end''') ??
                                            _parseDate(t, r'''$.endAt''');
                                    if (start != null &&
                                        now.isBefore(start.toUtc())) {
                                      return 'Upcoming';
                                    }
                                    if (end != null &&
                                        now.isAfter(end.toUtc())) {
                                      return 'Completed';
                                    }
                                    return 'Live';
                                  }

                                  final query =
                                      (_model.textController?.text ?? '')
                                          .trim()
                                          .toLowerCase();
                                  final filtered = allTournaments.where((t) {
                                    final name = getJsonField(t, r'''$.name''')
                                        .toString()
                                        .toLowerCase();
                                    final displayName = getJsonField(
                                      t,
                                      r'''$.displayName''',
                                    ).toString().toLowerCase();
                                    final matchesQuery = query.isEmpty ||
                                        name.contains(query) ||
                                        displayName.contains(query);
                                    if (!matchesQuery) return false;
                                    final cat = _model.selectedCategory;
                                    if (cat == 'All' || cat.isEmpty)
                                      return true;
                                    final status =
                                        _computeStatus(t).toLowerCase();
                                    return status == cat.toLowerCase();
                                  }).toList();

                                  final tournaments = filtered.take(8).toList();

                                  return ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: tournaments.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 10),
                                    itemBuilder: (context, tournamentsIndex) {
                                      final tournamentsItem =
                                          tournaments[tournamentsIndex];
                                      return Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 0, 10, 0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 170,
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x33000000),
                                                offset: Offset(
                                                  0,
                                                  2,
                                                ),
                                              )
                                            ],
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF123C94),
                                                Color(0xFF1655DB),
                                                Color(0xFF123C94)
                                              ],
                                              stops: [0, 0.5, 1],
                                              begin: AlignmentDirectional(1, 0),
                                              end: AlignmentDirectional(-1, 0),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              width: 0.1,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(5, 5, 5, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFFFD600),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0, 0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                5, 5, 5, 5),
                                                        child: Text(
                                                          _computeStatus(
                                                              tournamentsItem),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Builder(
                                                            builder: (context) {
                                                          final status =
                                                              _computeStatus(
                                                                  tournamentsItem);
                                                          final label = status ==
                                                                  'Upcoming'
                                                              ? 'Starts in:'
                                                              : status ==
                                                                      'Completed'
                                                                  ? 'Ended'
                                                                  : 'Ends in:';
                                                          return Text(
                                                            label,
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
                                                                      .secondaryBackground,
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
                                                          );
                                                        }),
                                                        StreamBuilder<DateTime>(
                                                          stream: Stream.periodic(
                                                              const Duration(
                                                                  seconds: 1),
                                                              (_) =>
                                                                  DateTime.now()
                                                                      .toUtc()),
                                                          builder:
                                                              (context, _) {
                                                            // Determine which timestamp to use based on status
                                                            final status =
                                                                _computeStatus(
                                                                    tournamentsItem);
                                                            final useStart =
                                                                status ==
                                                                    'Upcoming';
                                                            final rawTarget = useStart
                                                                ? (_parseDate(
                                                                        tournamentsItem,
                                                                        r'''$.startTime''') ??
                                                                    _parseDate(
                                                                        tournamentsItem,
                                                                        r'''$.startDate''') ??
                                                                    _parseDate(
                                                                        tournamentsItem,
                                                                        r'''$.start''') ??
                                                                    _parseDate(
                                                                        tournamentsItem,
                                                                        r'''$.startAt'''))
                                                                : (_parseDate(
                                                                        tournamentsItem,
                                                                        r'''$.endTime''') ??
                                                                    _parseDate(
                                                                        tournamentsItem,
                                                                        r'''$.endDate''') ??
                                                                    _parseDate(
                                                                        tournamentsItem,
                                                                        r'''$.end''') ??
                                                                    _parseDate(
                                                                        tournamentsItem,
                                                                        r'''$.endAt'''));
                                                            // Auto-update server status transitions with guards
                                                            final tId = getJsonField(
                                                                    tournamentsItem,
                                                                    r'$._id')
                                                                .toString();
                                                            if (tId.isNotEmpty &&
                                                                rawTarget !=
                                                                    null) {
                                                              final nowUtc =
                                                                  DateTime.now()
                                                                      .toUtc();
                                                              if (status ==
                                                                  'Upcoming') {
                                                                final startUtc =
                                                                    rawTarget
                                                                        .toUtc();
                                                                if (!startUtc
                                                                    .isAfter(
                                                                        nowUtc)) {
                                                                  if (!_updateInFlight
                                                                          .contains(
                                                                              tId) &&
                                                                      !_updatedToLive
                                                                          .contains(
                                                                              tId)) {
                                                                    _updateInFlight
                                                                        .add(
                                                                            tId);
                                                                    UpdateStatusCall
                                                                        .call(
                                                                      token: FFAppState()
                                                                          .token,
                                                                      status:
                                                                          'live',
                                                                      tournamentId:
                                                                          tId,
                                                                    ).then(
                                                                        (res) {
                                                                      _updateInFlight
                                                                          .remove(
                                                                              tId);
                                                                      if (res
                                                                          .succeeded) {
                                                                        _updatedToLive
                                                                            .add(tId);
                                                                        safeSetState(
                                                                            () {});
                                                                      }
                                                                    }).catchError(
                                                                        (_) {
                                                                      _updateInFlight
                                                                          .remove(
                                                                              tId);
                                                                    });
                                                                  }
                                                                }
                                                              } else if (status ==
                                                                  'Live') {
                                                                final endUtc =
                                                                    rawTarget
                                                                        .toUtc();
                                                                if (!endUtc
                                                                    .isAfter(
                                                                        nowUtc)) {
                                                                  if (!_updateInFlight
                                                                          .contains(
                                                                              tId) &&
                                                                      !_updatedToCompleted
                                                                          .contains(
                                                                              tId)) {
                                                                    _updateInFlight
                                                                        .add(
                                                                            tId);
                                                                    UpdateStatusCall
                                                                        .call(
                                                                      token: FFAppState()
                                                                          .token,
                                                                      status:
                                                                          'completed',
                                                                      tournamentId:
                                                                          tId,
                                                                    ).then(
                                                                        (res) {
                                                                      _updateInFlight
                                                                          .remove(
                                                                              tId);
                                                                      if (res
                                                                          .succeeded) {
                                                                        _updatedToCompleted
                                                                            .add(tId);
                                                                        safeSetState(
                                                                            () {});
                                                                      }
                                                                    }).catchError(
                                                                        (_) {
                                                                      _updateInFlight
                                                                          .remove(
                                                                              tId);
                                                                    });
                                                                  }
                                                                }
                                                              }
                                                            }
                                                            String remainingStr;
                                                            if (status ==
                                                                'Completed') {
                                                              remainingStr = '';
                                                            } else if (rawTarget ==
                                                                null) {
                                                              remainingStr =
                                                                  ' —';
                                                            } else {
                                                              // Convert to IST (UTC+5:30) for display semantics
                                                              final targetIst = rawTarget
                                                                  .toUtc()
                                                                  .add(const Duration(
                                                                      hours: 5,
                                                                      minutes:
                                                                          30));
                                                              final nowIst = DateTime
                                                                      .now()
                                                                  .toUtc()
                                                                  .add(const Duration(
                                                                      hours: 5,
                                                                      minutes:
                                                                          30));
                                                              final diff = targetIst
                                                                  .difference(
                                                                      nowIst);
                                                              if (diff
                                                                  .isNegative) {
                                                                remainingStr = useStart
                                                                    ? ' Started'
                                                                    : ' Ended';
                                                              } else {
                                                                final days =
                                                                    diff.inDays;
                                                                final hours =
                                                                    diff.inHours %
                                                                        24;
                                                                final minutes =
                                                                    diff.inMinutes %
                                                                        60;
                                                                final seconds =
                                                                    diff.inSeconds %
                                                                        60;
                                                                if (days > 0) {
                                                                  remainingStr =
                                                                      ' ${days}d ${hours}h ${minutes}m';
                                                                } else {
                                                                  String two(int n) => n
                                                                      .toString()
                                                                      .padLeft(
                                                                          2,
                                                                          '0');
                                                                  remainingStr =
                                                                      ' ${two(hours)}:${two(minutes)}:${two(seconds)}';
                                                                }
                                                              }
                                                            }
                                                            return Text(
                                                              remainingStr,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 5, 0, 5),
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
                                                              5, 5, 0, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                Image.network(
                                                              getJsonField(
                                                                containerGameResponse
                                                                    .jsonBody,
                                                                r'''$.data.assets.thumbnail''',
                                                              ).toString(),
                                                              width: 60,
                                                              height: 60,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    5, 0, 0, 0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  'Prize Pool',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      '₹ ',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            fontSize:
                                                                                18,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      getJsonField(
                                                                        tournamentsItem,
                                                                        r'''$.prizePool''',
                                                                      ).toString(),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            fontSize:
                                                                                18,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  '0 of Spots Left',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0, 0, 5, 0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          if (functions.isRegister(
                                                                  (getJsonField(
                                                                    tournamentsItem,
                                                                    r'''$.currentPlayers''',
                                                                    true,
                                                                  ) as List?)!
                                                                      .map<String>((e) => e.toString())
                                                                      .toList()
                                                                      .cast<String>(),
                                                                  FFAppState().userId)!
                                                              ? true
                                                              : false) {
                                                            context.pushNamed(
                                                              GameOnWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'gameUrl':
                                                                    serializeParam(
                                                                  getJsonField(
                                                                    containerGameResponse
                                                                        .jsonBody,
                                                                    r'''$.data.assets.gameUrl.baseUrl''',
                                                                  ).toString(),
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'gamename':
                                                                    serializeParam(
                                                                  getJsonField(
                                                                    containerGameResponse
                                                                        .jsonBody,
                                                                    r'''$.data.name''',
                                                                  ).toString(),
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'tournamentId':
                                                                    serializeParam(
                                                                  getJsonField(
                                                                    tournamentsItem,
                                                                    r'''$._id''',
                                                                  ).toString(),
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                            );

                                                            FFAppState()
                                                                    .tournamentId =
                                                                getJsonField(
                                                              tournamentsItem,
                                                              r'''$._id''',
                                                            ).toString();
                                                            safeSetState(() {});
                                                          } else {
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              enableDrag: false,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .unfocus();
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: MediaQuery
                                                                        .viewInsetsOf(
                                                                            context),
                                                                    child:
                                                                        RegistrationTournamentPopUpWidget(
                                                                      tournamentId:
                                                                          getJsonField(
                                                                        tournamentsItem,
                                                                        r'''$._id''',
                                                                      ).toString(),
                                                                      gameUrl:
                                                                          getJsonField(
                                                                        containerGameResponse
                                                                            .jsonBody,
                                                                        r'''$.data.assets.gameUrl.baseUrl''',
                                                                      ).toString(),
                                                                      gamename:
                                                                          getJsonField(
                                                                        containerGameResponse
                                                                            .jsonBody,
                                                                        r'''$.data.name''',
                                                                      ).toString(),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          }
                                                        },
                                                        text: functions
                                                                .isRegister(
                                                                    (getJsonField(
                                                                      tournamentsItem,
                                                                      r'''$.currentPlayers''',
                                                                      true,
                                                                    ) as List?)!
                                                                        .map<String>((e) => e
                                                                            .toString())
                                                                        .toList()
                                                                        .cast<
                                                                            String>(),
                                                                    FFAppState()
                                                                        .userId)!
                                                            ? 'Play'
                                                            : "₹ ${getJsonField(
                                                                tournamentsItem,
                                                                r'''$.entryFee''',
                                                              )}",
                                                        options:
                                                            FFButtonOptions(
                                                          height: 40,
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  16, 0, 16, 0),
                                                          iconPadding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0, 0, 0, 0),
                                                          color: const Color(
                                                              0xFF2AD266),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .black,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 350,
                                                child: Divider(
                                                  height: 2,
                                                  thickness: 1,
                                                  color: Color(0xFF7A7A7A),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(5, 5, 5, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          enableDrag: false,
                                                          context: context,
                                                          builder: (context) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                              },
                                                              child: Padding(
                                                                padding: MediaQuery
                                                                    .viewInsetsOf(
                                                                        context),
                                                                child:
                                                                    HowtoPlaytournamentWidget(
                                                                  gameId: widget
                                                                      .gameId!,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));

                                                        _model.soundPlayer8 ??=
                                                            AudioPlayer();
                                                        if (_model.soundPlayer8!
                                                            .playing) {
                                                          await _model
                                                              .soundPlayer8!
                                                              .stop();
                                                        }
                                                        _model.soundPlayer8!
                                                            .setVolume(1);
                                                        _model.soundPlayer8!
                                                            .setAsset(
                                                                'assets/audios/click.mp3')
                                                            .then((_) => _model
                                                                .soundPlayer8!
                                                                .play());
                                                      },
                                                      text: 'How to Play',
                                                      options: FFButtonOptions(
                                                        height: 40,
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                16, 0, 16, 0),
                                                        iconPadding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0, 0, 0, 0),
                                                        color: const Color(
                                                            0x000B33FF),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                        elevation: 0,
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        FFAppState().gameName =
                                                            getJsonField(
                                                          containerGameResponse
                                                              .jsonBody,
                                                          r'''$.data.name''',
                                                        ).toString();
                                                        FFAppState()
                                                                .tournamentId =
                                                            getJsonField(
                                                          tournamentsItem,
                                                          r'''$._id''',
                                                        ).toString();
                                                        safeSetState(() {});

                                                        context.pushNamed(
                                                          LeaderBoardPageWidget
                                                              .routeName,
                                                          queryParameters: {
                                                            'tournamentId':
                                                                serializeParam(
                                                              getJsonField(
                                                                tournamentsItem,
                                                                r'''$._id''',
                                                              ).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'gameName':
                                                                serializeParam(
                                                              getJsonField(
                                                                containerGameResponse
                                                                    .jsonBody,
                                                                r'''$.data.name''',
                                                              ).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'gameId':
                                                                serializeParam(
                                                              widget.gameId,
                                                              ParamType.String,
                                                            ),
                                                          }.withoutNulls,
                                                        );

                                                        _model.soundPlayer9 ??=
                                                            AudioPlayer();
                                                        if (_model.soundPlayer9!
                                                            .playing) {
                                                          await _model
                                                              .soundPlayer9!
                                                              .stop();
                                                        }
                                                        _model.soundPlayer9!
                                                            .setVolume(1);
                                                        _model.soundPlayer9!
                                                            .setAsset(
                                                                'assets/audios/click.mp3')
                                                            .then((_) => _model
                                                                .soundPlayer9!
                                                                .play());
                                                      },
                                                      text: 'Leaderboard',
                                                      options: FFButtonOptions(
                                                        height: 40,
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                16, 0, 16, 0),
                                                        iconPadding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0, 0, 0, 0),
                                                        color: const Color(
                                                            0x000B33FF),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                        elevation: 0,
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                            'containerOnPageLoadAnimation2']!),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
        ),
      ),
    );
  }
}
