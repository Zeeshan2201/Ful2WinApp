// Example: Using both GameOn and GameOn2 in your app

import 'package:flutter/material.dart';
import '/index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Example 1: Navigate to GameOn (Original)
void navigateToGameOn(BuildContext context) {
  context.pushNamed(
    GameOnWidget.routeName,
    queryParameters: {
      'gameUrl': serializeParam(
        'https://eggcatcher.fulboost.fun',
        ParamType.String,
      ),
      'gamename': serializeParam(
        'Egg Catcher',
        ParamType.String,
      ),
      'tournamentId': serializeParam(
        'tournament_001',
        ParamType.String,
      ),
    }.withoutNulls,
  );
}

/// Example 2: Navigate to GameOn2 (Clone)
void navigateToGameOn2(BuildContext context) {
  context.pushNamed(
    GameOn2Widget.routeName,
    queryParameters: {
      'gameUrl': serializeParam(
        'https://flappyball.fulboost.fun',
        ParamType.String,
      ),
      'gamename': serializeParam(
        'Flappy Ball',
        ParamType.String,
      ),
      'tournamentId': serializeParam(
        'tournament_002',
        ParamType.String,
      ),
    }.withoutNulls,
  );
}

/// Example 3: Button to choose between GameOn and GameOn2
class GameSelectionExample extends StatelessWidget {
  const GameSelectionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Game Instance')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => navigateToGameOn(context),
              child: const Text('Launch GameOn (Original)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => navigateToGameOn2(context),
              child: const Text('Launch GameOn2 (Clone)'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example 4: Using in Tournament Lobby
class TournamentLobbyExample {
  static void launchGame(
    BuildContext context, {
    required String gameUrl,
    required String gameName,
    required String tournamentId,
    bool useGameOn2 = false,
  }) {
    final routeName =
        useGameOn2 ? GameOn2Widget.routeName : GameOnWidget.routeName;

    context.pushNamed(
      routeName,
      queryParameters: {
        'gameUrl': serializeParam(gameUrl, ParamType.String),
        'gamename': serializeParam(gameName, ParamType.String),
        'tournamentId': serializeParam(tournamentId, ParamType.String),
      }.withoutNulls,
    );
  }
}

/// Example 5: Switching between GameOn instances
class DynamicGameLauncher {
  static void launchWithFallback(BuildContext context) {
    // Try GameOn first, if fails use GameOn2
    try {
      context.pushNamed(
        GameOnWidget.routeName,
        queryParameters: {
          'gameUrl': serializeParam(
            'https://game.example.com',
            ParamType.String,
          ),
          'gamename': serializeParam('Test Game', ParamType.String),
          'tournamentId': serializeParam('test_001', ParamType.String),
        }.withoutNulls,
      );
    } catch (e) {
      // Fallback to GameOn2
      context.pushNamed(
        GameOn2Widget.routeName,
        queryParameters: {
          'gameUrl': serializeParam(
            'https://game.example.com',
            ParamType.String,
          ),
          'gamename': serializeParam('Test Game', ParamType.String),
          'tournamentId': serializeParam('test_001', ParamType.String),
        }.withoutNulls,
      );
    }
  }
}
