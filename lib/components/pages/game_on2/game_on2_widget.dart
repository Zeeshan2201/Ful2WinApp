import '/flutter_flow/flutter_flow_util.dart';
//import '/flutter_flow/flutter_flow_widgets.dart';
//import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/components/loading/loading_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_on2_model.dart';
export 'game_on2_model.dart';

class GameOn2Widget extends StatefulWidget {
  const GameOn2Widget({
    super.key,
    String? gameUrl,
    required this.gamename,
    required this.challangeId,
    this.isChallenge = true,
  }) : gameUrl = gameUrl ?? 'https://eggcatcher.fulboost.fun';

  final String gameUrl;
  final String? gamename;
  final String? challangeId;
  final bool isChallenge;

  static String routeName = 'gameOn2';
  static String routePath = '/gameOn2';

  @override
  State<GameOn2Widget> createState() => _GameOn2WidgetState();
}

class _GameOn2WidgetState extends State<GameOn2Widget> {
  late GameOn2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameOn2Model());
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (_showLoading) {
      return const LoadingScreenWidget();
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF000B33),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => custom_widgets.GameOn2(
                    width: MediaQuery.of(context).size.width,
                    height: constraints.maxHeight,
                    gameUrl: widget.gameUrl,
                    gameName: widget.gamename!,
                    challengeId: widget.challangeId!,
                    isChallenge: widget.isChallenge,
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
