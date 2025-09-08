import 'package:flutter/material.dart';

class SpinWheelModel extends ChangeNotifier {
  int spinsLeft = 5;
  int timer = 0;
  bool isSpinning = false;
  String currentReward = "";

  void updateSpins(int newSpins) {
    spinsLeft = newSpins;
    notifyListeners();
  }

  void updateTimer(int newTimer) {
    timer = newTimer;
    notifyListeners();
  }

  void setSpinning(bool spinning) {
    isSpinning = spinning;
    notifyListeners();
  }

  void setReward(String reward) {
    currentReward = reward;
    notifyListeners();
  }
}
