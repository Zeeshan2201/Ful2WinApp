bool? isRegister(
  List<String> players,
  String? userId,
) {
  return players.contains(userId);
}

String findgameId(
  List<dynamic> games,
  String gameName,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  final game =
      games.firstWhere((g) => g['displayName'] == gameName, orElse: () => null);

  return game != null ? game['_id'].toString() : '';
}

String challangeTo(
  List<dynamic> users,
  String opponentName,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  final user = users.firstWhere(
    (u) => u['fullName'] == opponentName,
    orElse: () => null,
  );

  return user != null ? user['_id'].toString() : '';

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

bool? isLike(
  List<String> likes,
  String userId,
) {
  return likes.contains(userId);
}

String timeAgo(String date) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  DateTime parsedDate;
  try {
    parsedDate = DateTime.parse(date);
  } catch (e) {
    return 'invalid date';
  }

  final Duration diff = DateTime.now().difference(parsedDate);

  if (diff.inSeconds < 60) {
    return 'just now';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes}m ago';
  } else if (diff.inHours < 24) {
    return '${diff.inHours}h ago';
  } else if (diff.inDays < 7) {
    return '${diff.inDays}day ago';
  } else if (diff.inDays < 30) {
    final weeks = (diff.inDays / 7).floor();
    return '${weeks}week ago';
  } else if (diff.inDays < 365) {
    final months = (diff.inDays / 30).floor();
    return '${months}month ago';
  } else {
    final years = (diff.inDays / 365).floor();
    return '${years}year ago';
  }
}

List<dynamic>? filterGames(List<dynamic>? allGames) {
  return allGames?.where((game) => game['type'] != 'Unlimited').toList();
}

String? userName(
  List<dynamic> users,
  String userId,
) {
  if (users.isEmpty || userId.isEmpty) return '';
  try {
    for (final raw in users) {
      if (raw is Map) {
        final id = (raw['_id'] ?? raw['id'] ?? raw['user'])?.toString();
        if (id == userId) {
          final name = (raw['fullName'] ?? raw['username'] ?? '').toString();
          return name;
        }
      }
    }
  } catch (e) {
    // Silently fail; optionally log with debugPrint if needed
  }
  return '';
}

String? userProfilePicture(
  List<dynamic> users,
  String userId,
) {
  if (users.isEmpty || userId.isEmpty) return '';
  try {
    for (final raw in users) {
      if (raw is Map) {
        final id = (raw['_id'] ?? raw['id'] ?? raw['user'])?.toString();
        if (id == userId) {
          final name = (raw['profilePicture'] ?? '').toString();
          return name;
        }
      }
    }
  } catch (e) {
    // Silently fail; optionally log with debugPrint if needed
  }
  return '';
}

List<String>? fullNames(List<dynamic>? allUsers) {
  if (allUsers == null) return null;
  try {
    final names = <String>[];
    for (final raw in allUsers) {
      if (raw is Map && raw['fullName'] != null) {
        names.add(raw['fullName'].toString());
      }
    }
    return names;
  } catch (e) {
    // Silently fail; optionally log with debugPrint if needed
  }
  return null;
}

List<String>? gameNames(List<dynamic>? allGames) {
  if (allGames == null) return null;
  try {
    final names = <String>[];
    for (final raw in allGames) {
      if (raw is Map && raw['displayName'] != null) {
        names.add(raw['displayName'].toString());
      }
    }
    return names;
  } catch (e) {
    // Silently fail; optionally log with debugPrint if needed
  }
  return null;
}

List<dynamic>? filterUnlimitedGames(List<dynamic>? allGames) {
  return allGames?.where((game) => game['type'] == 'Unlimited').toList();
}

String? getRemainingTime(DateTime targetDate) {
  final now = DateTime.now().toUtc();
  final remaining = targetDate.toUtc().difference(now);

  if (remaining.isNegative) {
    return '00:00';
  }

  final minutes = remaining.inMinutes.remainder(60);
  final seconds = remaining.inSeconds.remainder(60);

  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
