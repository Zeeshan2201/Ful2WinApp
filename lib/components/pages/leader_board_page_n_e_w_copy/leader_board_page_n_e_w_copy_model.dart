import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pop_ups/header/header_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'leader_board_page_n_e_w_copy_widget.dart'
    show LeaderBoardPageNEWCopyWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LeaderBoardPageNEWCopyModel
    extends FlutterFlowModel<LeaderBoardPageNEWCopyWidget> {
  ///  Local state fields for this page.

  String selectedCategory = 'All';

  String moneyMode = 'Cash';

  ///  State fields for stateful widgets in this page.

  // Model for Header component.
  late HeaderModel headerModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    tabBarController?.dispose();
  }
}
