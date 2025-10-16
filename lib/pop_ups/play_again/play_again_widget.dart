import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/custom_functions.dart' as functions;

import 'play_again_model.dart';
export 'play_again_model.dart';

class PlayAgainWidget extends StatefulWidget {
  const PlayAgainWidget({
    super.key,
    required this.score,
    required this.gameName,
    required this.tournamentId,
    required this.gameUrl,
  });

  final int? score;
  final String? gameName;
  final String? tournamentId;
  final String? gameUrl;

  @override
  State<PlayAgainWidget> createState() => _PlayAgainWidgetState();
}

class _PlayAgainWidgetState extends State<PlayAgainWidget>
    with TickerProviderStateMixin {
  late PlayAgainModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  late Future<ApiCallResponse> gameResponse;
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlayAgainModel());
    // Fetch all games to resolve image/name references reliably
    gameResponse = GamesCall.call();
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
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
        child: Container(
          width: double.infinity,
          height: 280,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0x6D0B33FF),
                FlutterFlowTheme.of(context).primaryText
              ],
              stops: const [0, 1],
              begin: const AlignmentDirectional(0, -1),
              end: const AlignmentDirectional(0, 1),
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            border: Border.all(
              color: FlutterFlowTheme.of(context).secondary,
              width: 1,
            ),
          ),
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
              final columnGameResponse = snapshot.data!;

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // children: [
                      //   FlutterFlowIconButton(
                      //     borderRadius: 8,
                      //     buttonSize: 40,
                      //     icon: Icon(
                      //       Icons.cancel_outlined,
                      //       color: FlutterFlowTheme.of(context).info,
                      //       size: 24,
                      //     ),
                      //     onPressed: () => Navigator.of(context).pop(),
                      //   ),
                      // ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(functions.gameImg(
                                      getJsonField(columnGameResponse.jsonBody,
                                          r'''$.data'''),
                                      valueOrDefault<String>(
                                          widget.gameName, '')))
                                  .image,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Text(
                          valueOrDefault<String>(widget.gameName, 'Game'),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .displayMedium
                              .override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .displayMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .displayMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).secondary,
                                fontSize: 24,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .displayMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .displayMedium
                                    .fontStyle,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                40, 0, 0, 0),
                            child: Text(
                              'Your Score:',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .displayMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .displayMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .displayMedium
                                          .fontStyle,
                                    ),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    fontSize: 30,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .displayMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .displayMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            valueOrDefault<String>(
                                widget.score?.toString(), '0'),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .displayMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .displayMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .displayMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 30,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .displayMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .displayMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            _model.soundPlayer1 ??= AudioPlayer();
                            if (_model.soundPlayer1!.playing) {
                              await _model.soundPlayer1!.stop();
                            }
                            _model.soundPlayer1!.setVolume(1);
                            _model.soundPlayer1!
                                .setAsset('assets/audios/click.mp3')
                                .then((_) => _model.soundPlayer1!.play());

                            Navigator.of(context).pop();
                            context.pushNamed(
                              GameOnWidget.routeName,
                              queryParameters: {
                                'gameUrl': serializeParam(
                                  widget.gameUrl,
                                  ParamType.String,
                                ),
                                'gamename': serializeParam(
                                  widget.gameName,
                                  ParamType.String,
                                ),
                                'tournamentId': serializeParam(
                                  widget.tournamentId,
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          },
                          text: 'Play Again',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width < 350.0
                                ? 110.0
                                : 130.0,
                            height: 45,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.sizeOf(context).width < 350.0
                                          ? 14.0
                                          : 16.0,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 3,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            _model.soundPlayer2 ??= AudioPlayer();
                            if (_model.soundPlayer2!.playing) {
                              await _model.soundPlayer2!.stop();
                            }
                            _model.soundPlayer2!.setVolume(1);
                            _model.soundPlayer2!
                                .setAsset('assets/audios/click.mp3')
                                .then((_) => _model.soundPlayer2!.play());

                            // Close the dialog and also remove GameOn page from the stack
                            final rootNav =
                                Navigator.of(context, rootNavigator: true);
                            // Pop PlayAgain dialog
                            rootNav.pop();
                            // Pop GameOn route so back won't return to it
                            if (rootNav.canPop()) {
                              rootNav.pop();
                            }
                            // After popping, we land on the previous page (typically Tournament Lobby)
                          },
                          text: 'Tournaments',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width < 350.0
                                ? 110.0
                                : 130.0,
                            height: 45,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.sizeOf(context).width < 350.0
                                          ? 14.0
                                          : 16.0,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 3,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
      ),
    );
  }
}
