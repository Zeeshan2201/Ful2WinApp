import '/flutter_flow/flutter_flow_util.dart';
import 'challenge_play_again_widget.dart' show ChallengePlayAgainWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ChallengePlayAgainModel
    extends FlutterFlowModel<ChallengePlayAgainWidget> {
  ///  State fields for stateful widgets in this component.

  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    soundPlayer1?.dispose();
    soundPlayer2?.dispose();
  }
}
