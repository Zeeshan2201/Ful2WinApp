import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'registration_tournament_pop_up_widget.dart'
    show RegistrationTournamentPopUpWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class RegistrationTournamentPopUpModel
    extends FlutterFlowModel<RegistrationTournamentPopUpWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (tournamentRegister)] action in Button widget.
  ApiCallResponse? ragister;
  AudioPlayer? soundPlayer;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
