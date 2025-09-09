import '/flutter_flow/flutter_flow_util.dart';
import 'add_money_page_widget.dart' show AddMoneyPageWidget;
import 'package:flutter/material.dart';

class AddMoneyPageModel extends FlutterFlowModel<AddMoneyPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
