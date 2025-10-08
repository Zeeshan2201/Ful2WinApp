import '/flutter_flow/flutter_flow_util.dart';
import '/pop_ups/header/header_widget.dart';
import '/pop_ups/navbar/navbar_widget.dart';
import '/index.dart';
import 'communitymembers_widget.dart' show CommunitymembersWidget;
import 'package:flutter/material.dart';

class CommunitymembersModel extends FlutterFlowModel<CommunitymembersWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for search text field.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;

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
    searchFocusNode?.dispose();
    searchTextController?.dispose();

    headerModel.dispose();
    navbarModel.dispose();
  }
}
