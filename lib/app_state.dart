import 'package:flutter/material.dart';
//import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _token = prefs.getString('ff_token') ?? _token;
    });
    _safeInit(() {
      _userId = prefs.getString('ff_userId') ?? _userId;
    });
    _safeInit(() {
      _gameId = prefs.getString('ff_gameId') ?? _gameId;
    });
    _safeInit(() {
      _tournamentId = prefs.getString('ff_tournamentId') ?? _tournamentId;
    });
    _safeInit(() {
      _gameType = prefs.getString('ff_gameType') ?? _gameType;
    });
    _safeInit(() {
      _profilePicture = prefs.getString('ff_profilePicture') ?? _profilePicture;
    });
    _safeInit(() {
      _gameScore = prefs.getInt('ff_gameScore') ?? _gameScore;
    });
    _safeInit(() {
      _userName = prefs.getString('ff_userName') ?? _userName;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NjYyNzBhNjg3NjQ0MTIxYmFlYmI0ZCIsInBob25lTnVtYmVyIjoiOTAyMjk3NTc4NSIsImlhdCI6MTc1NTg0NDgxMiwiZXhwIjoxNzU4NDM2ODEyfQ.I0v5q07rrinYvAR8pTEtH0cqQ6pUZ13WKWs7I00nhyw';
  String get token => _token;
  set token(String value) {
    _token = value;
    prefs.setString('ff_token', value);
  }

  String _userId = '685c330ab7e0f4d7def7171b';
  String get userId => _userId;
  set userId(String value) {
    _userId = value;
    prefs.setString('ff_userId', value);
  }

  String _gameId = '';
  String get gameId => _gameId;
  set gameId(String value) {
    _gameId = value;
    prefs.setString('ff_gameId', value);
  }

  String _tournamentId = '685ed3d4a81dc4940706b443';
  String get tournamentId => _tournamentId;
  set tournamentId(String value) {
    _tournamentId = value;
    prefs.setString('ff_tournamentId', value);
  }

  String _gameType = 'Unlimited';
  String get gameType => _gameType;
  set gameType(String value) {
    _gameType = value;
    prefs.setString('ff_gameType', value);
  }

  String _gameName = 'flappy-ball';
  String get gameName => _gameName;
  set gameName(String value) {
    _gameName = value;
  }

  String _profilePicture = '';
  String get profilePicture => _profilePicture;
  set profilePicture(String value) {
    _profilePicture = value;
    prefs.setString('ff_profilePicture', value);
  }

  int _gameScore = 0;
  int get gameScore => _gameScore;
  set gameScore(int value) {
    _gameScore = value;
    prefs.setInt('ff_gameScore', value);
  }

  String _userName = '';
  String get userName => _userName;
  set userName(String value) {
    _userName = value;
    prefs.setString('ff_userName', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
