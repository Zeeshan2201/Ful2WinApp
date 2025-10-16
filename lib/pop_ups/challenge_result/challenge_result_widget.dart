import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'challenge_result_model.dart';
export 'challenge_result_model.dart';

class ChallengeResultWidget extends StatefulWidget {
  const ChallengeResultWidget({
    super.key,
    required this.score,
    required this.gameName,
    required this.challengeId,
    required this.gameUrl,
  });

  final int? score;
  final String? gameName;
  final String? challengeId;
  final String? gameUrl;

  @override
  State<ChallengeResultWidget> createState() => _ChallengeResultWidgetState();
}

class _ChallengeResultWidgetState extends State<ChallengeResultWidget>
    with TickerProviderStateMixin {
  late ChallengeResultModel _model;

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
    _model = createModel(context, () => ChallengeResultModel());

    // Fetch challenge details to get scores and determine winner
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
          height: 350,
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

              // Get scores
              final myScore = widget.score ?? 0;
              final myUserId = FFAppState().userId;

              // Determine if opponent has played
              final challengerScore =
                  getJsonField(currentChallenge, r'''$.challengerScore''');
              final challengedScore =
                  getJsonField(currentChallenge, r'''$.challengedScore''');

              final challengerId =
                  getJsonField(currentChallenge, r'''$.challenger._id''')
                          ?.toString() ??
                      getJsonField(currentChallenge, r'''$.challenger''')
                          ?.toString() ??
                      '';

              final isChallenger = challengerId == myUserId;
              final opponentScore =
                  isChallenger ? challengedScore : challengerScore;

              // Get opponent username
              final opponentUsername = isChallenger
                  ? (getJsonField(currentChallenge,
                              r'''$.challengedUser.username''')
                          ?.toString() ??
                      getJsonField(
                              currentChallenge, r'''$.challengee.username''')
                          ?.toString() ??
                      'Opponent')
                  : (getJsonField(
                              currentChallenge, r'''$.challenger.username''')
                          ?.toString() ??
                      'Opponent');

              // Determine result
              bool isWaiting = opponentScore == null;
              bool isWinner = false;
              bool isDraw = false;

              if (!isWaiting) {
                final oppScore = opponentScore is int
                    ? opponentScore
                    : int.tryParse(opponentScore.toString()) ?? 0;
                if (myScore > oppScore) {
                  isWinner = true;
                } else if (myScore == oppScore) {
                  isDraw = true;
                }
              }

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    'Challenge Result',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context).secondary,
                          fontSize: 24,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 20),

                  // Your Score
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Score:',
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          myScore.toString(),
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context).secondary,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Result Status
                  if (isWaiting)
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0x44FFA500),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.hourglass_empty,
                            color: Colors.orange,
                            size: 40,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Waiting for opponent...',
                            textAlign: TextAlign.center,
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'Inter',
                                      color: Colors.orange,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Check back later to see the result',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    )
                  else if (isWinner)
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0x4400FF00),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.emoji_events,
                            color: Colors.yellow,
                            size: 50,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '🎉 You Win! 🎉',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.green,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Opponent: $opponentUsername (${opponentScore ?? 0})',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                          ),
                        ],
                      ),
                    )
                  else if (isDraw)
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0x440000FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.handshake,
                            color: Colors.blue,
                            size: 40,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'It\'s a Draw!',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.blue,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Both scored: ${opponentScore ?? 0}',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0x44FF0000),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.red,
                            size: 40,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'You Lost',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Winner: $opponentUsername (${opponentScore ?? 0})',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                          ),
                        ],
                      ),
                    ),

                  const Spacer(),

                  // Close Button
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: FFButtonWidget(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        if (Navigator.of(context, rootNavigator: true)
                            .canPop()) {
                          Navigator.of(context, rootNavigator: true).pop();
                        }
                        // Navigate to challenges page
                        context.pushNamed('challengePage');
                      },
                      text: 'Back to Challenges',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).secondary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                        elevation: 3,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ).animateOnPageLoad(
                  animationsMap['containerOnPageLoadAnimation1']!);
            },
          ),
        ),
      ),
    );
  }
}
