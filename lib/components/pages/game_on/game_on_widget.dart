import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
//import '/flutter_flow/flutter_flow_widgets.dart';
//import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_on_model.dart';
export 'game_on_model.dart';

class GameOnWidget extends StatefulWidget {
  const GameOnWidget({
    super.key,
    String? gameUrl,
    required this.gamename,
    required this.tournamentId,
  }) : gameUrl = gameUrl ?? 'https://eggcatcher.fulboost.fun';

  final String gameUrl;
  final String? gamename;
  final String? tournamentId;

  static String routeName = 'gameOn';
  static String routePath = '/gameOn';

  @override
  State<GameOnWidget> createState() => _GameOnWidgetState();
}

class _GameOnWidgetState extends State<GameOnWidget> {
  late GameOnModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameOnModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF000B33),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          actions: const [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => custom_widgets.GameOn(
                    width: MediaQuery.of(context).size.width,
                    height: constraints.maxHeight,
                    gameUrl: widget.gameUrl,
                    gameName: widget.gamename!,
                    tournamentId: widget.tournamentId!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
