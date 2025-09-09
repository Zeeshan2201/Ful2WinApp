import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'registration_tournament_pop_up_widget.dart'
    show RegistrationTournamentPopUpWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
