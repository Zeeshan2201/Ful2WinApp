import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pop_ups/header/header_widget.dart';
import '/pop_ups/navbar/navbar_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'communitymembers_widget.dart' show CommunitymembersWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommunitymembersModel extends FlutterFlowModel<CommunitymembersWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Header component.
  late HeaderModel headerModel;
  // Model for Navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    navbarModel.dispose();
  }
}
