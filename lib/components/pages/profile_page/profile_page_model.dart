import '/flutter_flow/flutter_flow_util.dart';
import '/pop_ups/navbar/navbar_widget.dart';
import 'profile_page_widget.dart' show UserProfileWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProfilePageModel extends FlutterFlowModel<UserProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getDataField] action in Button widget.
  AudioPlayer? soundPlayer1;

  // Model for Navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    soundPlayer1?.dispose();
    navbarModel.dispose();
  }
}
