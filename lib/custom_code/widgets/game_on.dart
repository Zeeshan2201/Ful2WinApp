// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
//import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import '/backend/api_requests/api_calls.dart';

class GameOn extends StatefulWidget {
  const GameOn(
      {Key? key,
      required this.gameUrl,
      this.width,
      this.height,
      required this.gameName,
      required this.tournamentId})
      : super(key: key);

  final String gameUrl;
  final String tournamentId;
  final String gameName;
  final double? width;
  final double? height;

  @override
  _GameOnState createState() => _GameOnState();
}

class _GameOnState extends State<GameOn> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..addJavaScriptChannel(
          'GameChannel',
          onMessageReceived: (JavaScriptMessage msg) {
            _handleMessage(msg.message);
          },
        )
        ..loadRequest(Uri.parse(widget.gameUrl));
    }
  }

  Future<void> _handleMessage(String message) async {
    try {
      final data = jsonDecode(message);

      if (data['type'] == 'GAME_OVER') {
        final score = data['score'] as int?;
        if (score != null) {
          // Save score in AppState
          FFAppState().update(() {
            FFAppState().gameScore = score;
          });

          // Submit to backend
          final apiResult = await SubmitScoreCall.call(
            score: score,
            userId: FFAppState().userId,
            userName: FFAppState().userName,
            roomId: widget.tournamentId,
            gameName: widget.gameName,
          );

          if (apiResult.succeeded) {
            print("✅ Score submitted!");
            if (mounted) context.pushNamed("tournamentLobby");
          } else {
            print("❌ API failed: ${apiResult.statusCode}");
            if (mounted) context.pushNamed("homepage");
          }
        }
      }
    } catch (e) {
      print("⚠️ Error handling message: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Center(
        child: Text("⚠️ Web not supported for this widget"),
      );
    }
    return SizedBox.expand(
      child: WebViewWidget(controller: _controller),
    );
  }
}
