import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pop_ups/header/header_widget.dart';
import '/pop_ups/howto_playtournament/howto_playtournament_widget.dart';
import '/pop_ups/registration_tournament_pop_up/registration_tournament_pop_up_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'tournament_lobby_widget.dart' show TournamentLobbyWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TournamentLobbyModel extends FlutterFlowModel<TournamentLobbyWidget> {
  ///  Local state fields for this page.

  String selectedCategory = 'All';

  String moneyMode = 'Cash';

  ///  State fields for stateful widgets in this page.

  // Model for Header component.
  late HeaderModel headerModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
