// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:ui_web' as ui;
import 'dart:html' as html;
import 'dart:convert';
import '/backend/api_requests/api_calls.dart';

class GameOn extends StatefulWidget {
  const GameOn({
    Key? key,
    this.width,
    this.height,
    required this.gameUrl,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String gameUrl;

  @override
  _GameOnState createState() => _GameOnState();
}

class _GameOnState extends State<GameOn> {
  late final html.IFrameElement _iframeElement;
  late final String viewType;

  @override
  void initState() {
    super.initState();
    viewType = 'game-iframe-${DateTime.now().microsecondsSinceEpoch}';

    // Register the view factory for the iframe
    ui.platformViewRegistry.registerViewFactory(
      viewType,
      (int viewId) {
        _iframeElement = html.IFrameElement()
          ..src = widget.gameUrl
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';
        return _iframeElement;
      },
    );

    // Listen for messages from the iframe
    html.window.addEventListener('message', _handleMessage);
  }

  void _handleMessage(html.Event event) async {
    if (event is html.MessageEvent) {
      // Verify the origin for security

      try {
        final dynamic data = jsonDecode(event.data);
        if (data is Map<String, dynamic> && data['type'] == 'GAME_OVER') {
          final int? score = data['score'] as int?;
          if (score != null) {
            // Update app state with the score
            FFAppState().update(() {
              FFAppState().gameScore = score;
            });

            // Submit score via API
            try {
              var apiResult = await SubmitScoreCall.call(
                score: score,
                userId: FFAppState().userId,
                userName: FFAppState().userName,
                roomId: FFAppState().tournamentId,
                gameName: FFAppState().gameName,
              );

              if (apiResult.succeeded) {
                print('Score submitted successfully!');
                // Navigate to results page
                if (mounted) {
                  context.pushNamed('tournamentLobby');
                }
              } else {
                print('Failed to submit score: ${apiResult.statusCode}');
                // Still navigate even if API fails
                if (mounted) {
                  context.pushNamed('homepage');
                }
              }
            } catch (e) {
              print('Error submitting score: $e');
              // Navigate even if there's an error
              if (mounted) {
                context.pushNamed('gamePage');
              }
            }
          }
        }
      } catch (e) {
        print('Error parsing message data: $e');
      }
    }
  }

  @override
  void dispose() {
    // Clean up the event listener
    html.window.removeEventListener('message', _handleMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: HtmlElementView(viewType: viewType),
    );
  }
}
