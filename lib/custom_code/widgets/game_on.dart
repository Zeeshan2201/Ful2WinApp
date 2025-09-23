// Automatic FlutterFlow imports
//import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
//import '/custom_code/widgets/index.dart'; // Imports other custom widgets
//import '/custom_code/actions/index.dart'; // Imports custom actions
//import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:webview_flutter/webview_flutter.dart';
import '/backend/api_requests/api_calls.dart';
import '/pop_ups/play_again/play_again_widget.dart';

class GameOn extends StatefulWidget {
  const GameOn(
      {super.key,
      required this.gameUrl,
      this.width,
      this.height,
      required this.gameName,
      required this.tournamentId});

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
  bool _playAgainShown = false;
  bool _scoreSubmitted = false;

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
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (url) async {
              await _injectJSBridge();
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.gameUrl));
    }
  }

  Future<void> _injectJSBridge() async {
    const js = r"""
      (function() {
        try {
          if (window.__FUL2WIN_BRIDGED__) { return; }
          window.__FUL2WIN_BRIDGED__ = true;

          // simple dedupe by last payload string
          var __lastMsg = null;
          var __lastTime = 0;
          function shouldForward(str) {
            var now = Date.now();
            if (__lastMsg === str && (now - __lastTime) < 1500) { return false; }
            __lastMsg = str; __lastTime = now; return true;
          }

          // If the game posts messages using window.parent.postMessage, intercept and forward.
          function normalizeAndSend(eventData) {
            try {
              var payload = eventData;
              if (typeof eventData === 'string') {
                try { payload = JSON.parse(eventData); } catch (e) {}
              }
              if (!payload || typeof payload !== 'object') return;
              var type = payload.type || payload.event || '';
              if (type === 'GAME_OVER') {
                var score = payload.score;
                if (typeof score === 'string') score = parseInt(score, 10);
                if (typeof score !== 'number' || isNaN(score)) return;
                var msg = JSON.stringify({ type: 'GAME_OVER', score: score });
                if (!shouldForward(msg)) return;
                if (window.GameChannel && window.GameChannel.postMessage) {
                  window.GameChannel.postMessage(msg);
                } else if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
                  // Fallback for other webview libs
                  window.flutter_inappwebview.callHandler('GameChannel', msg);
                }
              }
            } catch (err) {
              // swallow
            }
          }

          // Patch window.postMessage and also listen to message events
          var originalPostMessage = window.postMessage;
          window.postMessage = function(message, targetOrigin, transfer) {
            try { normalizeAndSend(message); } catch (e) {}
            return originalPostMessage.apply(this, arguments);
          };

          // Some games call window.parent.postMessage from inside iframe
          try {
            var parentPostMessage = window.parent && window.parent.postMessage ? window.parent.postMessage.bind(window.parent) : null;
            if (parentPostMessage) {
              window.parent.postMessage = function(message, targetOrigin, transfer) {
                try { normalizeAndSend(message); } catch (e) {}
                return parentPostMessage(message, targetOrigin, transfer);
              };
            }
          } catch (e) { /* cross-origin access may throw */ }

          window.addEventListener('message', function(ev) {
            try { normalizeAndSend(ev && ev.data); } catch (e) {}
          }, false);
        } catch (e) {
          // noop
        }
      })();
    """;
    try {
      await _controller.runJavaScript(js);
    } catch (_) {}
  }

  Future<void> _handleMessage(String message) async {
    try {
      final data = jsonDecode(message);
      print("📩 Message from game: $data");
      if (data['type'] == 'GAME_OVER') {
        if (_scoreSubmitted) {
          // Ignore duplicate GAME_OVER events
          return;
        }
        final score = (data['score'] as num?)?.toInt();
        if (score != null) {
          // Save score in AppState
          FFAppState().update(() {
            FFAppState().gameScore = score;
          });

          // Submit to backend
          _scoreSubmitted = true;
          final apiResult = await SubmitScoreCall.call(
            score: score,
            userId: FFAppState().userId,
            userName: FFAppState().userName,
            roomId: widget.tournamentId,
            gameName: widget.gameName,
          );

          if (apiResult.succeeded) {
            print("✅ Score submitted!");

            if (mounted && !_playAgainShown) {
              _playAgainShown = true;
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) {
                  return WillPopScope(
                    onWillPop: () async {
                      final rootNav =
                          Navigator.of(dialogContext, rootNavigator: true);
                      // Close dialog
                      rootNav.pop();
                      // Pop GameOn page so it can't be returned via back
                      if (rootNav.canPop()) {
                        rootNav.pop();
                      }
                      return false;
                    },
                    child: Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PlayAgainWidget(
                        score: score,
                        tournamentId: widget.tournamentId,
                        gameName: widget.gameName,
                        gameUrl: widget.gameUrl,
                      ),
                    ),
                  );
                },
              );
            }
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
