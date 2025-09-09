import '/flutter_flow/flutter_flow_util.dart';
import '/pop_ups/header/header_widget.dart';
import '/index.dart';
import 'home_page_copy_copy_widget.dart' show HomePageCopyCopyWidget;
import 'package:flutter/material.dart';

class HomePageCopyCopyModel extends FlutterFlowModel<HomePageCopyCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Header component.
  late HeaderModel headerModel;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
  }
}
