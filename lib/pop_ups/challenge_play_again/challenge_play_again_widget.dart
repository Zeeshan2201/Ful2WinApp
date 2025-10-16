import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/custom_functions.dart' as functions;

import 'challenge_play_again_model.dart';
export 'challenge_play_again_model.dart';

class ChallengePlayAgainWidget extends StatefulWidget {
  const ChallengePlayAgainWidget({
    super.key,
    required this.myScore,
    required this.gameName,
    required this.challengeId,
    required this.gameUrl,
  });

  final int? myScore;
  final String? gameName;
  final String? challengeId;
  final String? gameUrl;

  @override
  State<ChallengePlayAgainWidget> createState() =>
      _ChallengePlayAgainWidgetState();
}

class _ChallengePlayAgainWidgetState extends State<ChallengePlayAgainWidget>
    with TickerProviderStateMixin {
  late ChallengePlayAgainModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  late Future<ApiCallResponse> challengeResponse;
  late Future<ApiCallResponse> gameResponse;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChallengePlayAgainModel());

    // Fetch challenge details to get both users' scores
    challengeResponse = GetChallengesCall.call(token: FFAppState().token);
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
          height: 400,
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
            future: Future.wait([challengeResponse, gameResponse])
                .then((results) => results[0]),
            builder: (context, snapshot) {
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

              final challengeData = snapshot.data!;

              // Find the current challenge
              final allChallenges = getJsonField(
                challengeData.jsonBody,
                r'''$.challenges''',
              ).toList();

              final currentChallenge = allChallenges.firstWhere(
                (c) =>
                    getJsonField(c, r'''$._id''')?.toString() ==
                    widget.challengeId,
                orElse: () => null,
              );

              // Get user info
              final myUserId = FFAppState().userId;

              // Get challenger and challenged info
              final challengerId =
                  getJsonField(currentChallenge, r'''$.challenger._id''')
                          ?.toString() ??
                      getJsonField(currentChallenge, r'''$.challenger''')
                          ?.toString() ??
                      '';

              final challengerUsername = getJsonField(
                          currentChallenge, r'''$.challenger.username''')
                      ?.toString() ??
                  getJsonField(currentChallenge, r'''$.challenger.fullName''')
                      ?.toString() ??
                  'User 1';

              final challengedUsername = getJsonField(
                          currentChallenge, r'''$.challenged.username''')
                      ?.toString() ??
                  getJsonField(currentChallenge, r'''$.challengee.username''')
                      ?.toString() ??
                  getJsonField(currentChallenge, r'''$.challenged.fullName''')
                      ?.toString() ??
                  'User 2';

              // Get scores
              final challengerScore = getJsonField(
                  currentChallenge, r'''$.result.score.challenger''');
              final challengedScore = getJsonField(
                  currentChallenge, r'''$.result.score.challenged''');

              final isChallenger = challengerId == myUserId;

              // Determine user1 and user2 (challenger is always user1)
              final user1Name = challengerUsername;
              final user2Name = challengedUsername;

              // Use widget.myScore for current user, API score for other user
              final user1Score =
                  isChallenger ? widget.myScore : challengerScore;
              final user2Score =
                  !isChallenger ? widget.myScore : challengedScore;

              // Check if second user has played
              final isWaitingForUser2 = user2Score == null;

              // Determine winner
              String resultText = '';
              Color resultColor = Colors.white;

              if (!isWaitingForUser2) {
                final score1 = user1Score is int
                    ? user1Score
                    : int.tryParse(user1Score.toString()) ?? 0;
                final score2 = user2Score is int
                    ? user2Score
                    : int.tryParse(user2Score.toString()) ?? 0;

                if (score1 > score2) {
                  resultText = '$user1Name Wins! 🏆';
                  resultColor = Colors.green;
                } else if (score2 > score1) {
                  resultText = '$user2Name Wins! 🏆';
                  resultColor = Colors.green;
                } else {
                  resultText = 'It\'s a Draw! 🤝';
                  resultColor = Colors.blue;
                }
              }

              return FutureBuilder<ApiCallResponse>(
                future: gameResponse,
                builder: (context, gameSnapshot) {
                  if (!gameSnapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    );
                  }

                  final columnGameResponse = gameSnapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 10),

                      // Game info row
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                25, 0, 0, 0),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(functions.gameImg(
                                          getJsonField(
                                              columnGameResponse.jsonBody,
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 0, 0, 0),
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
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
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

                      const SizedBox(height: 25),

                      // Title
                      Text(
                        'Challenge Results',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              font: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                              color: FlutterFlowTheme.of(context).secondary,
                              fontSize: 22,
                              letterSpacing: 0.0,
                            ),
                      ),

                      const SizedBox(height: 20),

                      // User 1 Score
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isChallenger
                                ? FlutterFlowTheme.of(context).secondary
                                : Colors.white30,
                            width: isChallenger ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (isChallenger)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                  ),
                                Text(
                                  user1Name,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        color: Colors.white,
                                        fontSize: 16,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              user1Score?.toString() ?? '0',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    fontSize: 20,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      // User 2 Score or Waiting
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: isWaitingForUser2
                              ? const Color(0x44FFA500)
                              : const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isWaitingForUser2
                                ? Colors.orange
                                : (!isChallenger
                                    ? FlutterFlowTheme.of(context).secondary
                                    : Colors.white30),
                            width:
                                isWaitingForUser2 ? 2 : (!isChallenger ? 2 : 1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (!isChallenger && !isWaitingForUser2)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                  ),
                                if (isWaitingForUser2)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.hourglass_empty,
                                      color: Colors.orange,
                                      size: 20,
                                    ),
                                  ),
                                Text(
                                  user2Name,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        color: isWaitingForUser2
                                            ? Colors.orange
                                            : Colors.white,
                                        fontSize: 16,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                            if (isWaitingForUser2)
                              Text(
                                'Waiting...',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      color: Colors.orange,
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      fontStyle: FontStyle.italic,
                                    ),
                              )
                            else
                              Text(
                                user2Score?.toString() ?? '0',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      font: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      fontSize: 20,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Result text (only if both played)
                      if (!isWaitingForUser2)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: resultColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: resultColor,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            resultText,
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  color: resultColor,
                                  fontSize: 18,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),

                      const Spacer(),

                      // Buttons
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: FFButtonWidget(
                                onPressed: () async {
                                  _model.soundPlayer1 ??= AudioPlayer();
                                  if (_model.soundPlayer1!.playing) {
                                    await _model.soundPlayer1!.stop();
                                  }
                                  _model.soundPlayer1!.setVolume(1);
                                  _model.soundPlayer1!
                                      .setAsset('assets/audios/click.mp3')
                                      .then((_) => _model.soundPlayer1!.play());

                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  if (Navigator.of(context, rootNavigator: true)
                                      .canPop()) {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  }
                                  context.pushNamed('challengePage');
                                },
                                text: 'Challenges',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width < 350.0
                                          ? 110.0
                                          : 130.0,
                                  height: 45,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
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
                                            MediaQuery.sizeOf(context).width <
                                                    350.0
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
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: FFButtonWidget(
                                onPressed: () async {
                                  _model.soundPlayer2 ??= AudioPlayer();
                                  if (_model.soundPlayer2!.playing) {
                                    await _model.soundPlayer2!.stop();
                                  }
                                  _model.soundPlayer2!.setVolume(1);
                                  _model.soundPlayer2!
                                      .setAsset('assets/audios/click.mp3')
                                      .then((_) => _model.soundPlayer2!.play());

                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  if (Navigator.of(context, rootNavigator: true)
                                      .canPop()) {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  }
                                  context.pushNamed('homepage');
                                },
                                text: 'Home',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width < 350.0
                                          ? 110.0
                                          : 130.0,
                                  height: 45,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).secondary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.sizeOf(context).width <
                                                    350.0
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation1']!);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
