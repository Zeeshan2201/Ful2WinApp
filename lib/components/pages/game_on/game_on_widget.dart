import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'game_on_model.dart';
export 'game_on_model.dart';

class GameOnWidget extends StatefulWidget {
  const GameOnWidget({
    super.key,
    String? gameUrl,
    required this.gamename,
    required this.tournamentId,
  }) : this.gameUrl = gameUrl ?? 'https://eggcatcher.fulboost.fun';

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
        backgroundColor: Color(0xFF000B33),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Page Title',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.poppins(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 400,
                height: 893,
                child: custom_widgets.GameOn(
                  width: 400,
                  height: 893,
                  gameUrl: widget!.gameUrl,
                  gameName: widget!.gamename!,
                  tournamentId: widget!.tournamentId!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
