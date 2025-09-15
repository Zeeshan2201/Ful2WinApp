import '/flutter_flow/flutter_flow_util.dart';
import 'leader_board_page_widget.dart' show LeaderBoardPageWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class LeaderBoardPageModel extends FlutterFlowModel<LeaderBoardPageWidget> {
  ///  Local state fields for this page.

  String selectedCategory = 'All';

  String moneyMode = 'Cash';

  ///  State fields for stateful widgets in this page.

  AudioPlayer? soundPlayer;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Scroll controllers for each tab content
  final ScrollController prizesScrollController = ScrollController();
  final ScrollController leaderboardScrollController = ScrollController();
  final ScrollController howToPlayScrollController = ScrollController();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    prizesScrollController.dispose();
    leaderboardScrollController.dispose();
    howToPlayScrollController.dispose();
  }
}
