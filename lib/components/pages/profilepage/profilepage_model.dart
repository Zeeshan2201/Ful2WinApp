import '/flutter_flow/flutter_flow_util.dart';
import '/pop_ups/navbar/navbar_widget.dart';
import '/index.dart';
import 'profilepage_widget.dart' show ProfilepageWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProfilepageModel extends FlutterFlowModel<ProfilepageWidget> {
  ///  State fields for stateful widgets in this page.

  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  AudioPlayer? soundPlayer3;
  AudioPlayer? soundPlayer4;
  // Model for Navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    navbarModel.dispose();
  }
}