import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';

bool? isRegister(
  List<String> players,
  String? userId,
) {
  return players.contains(userId);
}

List<dynamic>? filterGames(List<dynamic>? allGames) {
  return allGames?.where((game) => game['type'] != 'Unlimited').toList();
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
