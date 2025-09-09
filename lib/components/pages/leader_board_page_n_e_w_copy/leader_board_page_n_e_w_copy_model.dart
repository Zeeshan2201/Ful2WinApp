import '/flutter_flow/flutter_flow_util.dart';
import '/pop_ups/header/header_widget.dart';
import '/index.dart';
import 'leader_board_page_n_e_w_copy_widget.dart'
    show LeaderBoardPageNEWCopyWidget;
import 'package:flutter/material.dart';

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
