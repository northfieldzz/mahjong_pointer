import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/player/objects.dart';

class GamePageState {
  Player player;
  bool isTarget;
}

class GameState extends ChangeNotifier {
  Player _player0 = Player(name: 'Player 1');
  Player _player1 = Player(name: 'Player 2');
  Player _player2 = Player(name: 'Player 3');
  Player _player3 = Player(name: 'Player 4');
  var _setting = Setting();
  var _boardStock = 0;

  set player0(Player player) {
    _player0 = player;
    notifyListeners();
  }

  Player get player0 => _player0;

  set player1(Player player) {
    _player1 = player;
    notifyListeners();
  }

  Player get player1 => _player1;

  set player2(Player player) {
    _player2 = player;
    notifyListeners();
  }

  Player get player2 => _player2;

  set player3(Player player) {
    _player3 = player;
    notifyListeners();
  }

  Player get player3 => _player3;

  set setting(Setting setting) {
    _setting = setting;
    notifyListeners();
  }

  Setting get setting => _setting;

  int get boardStock => _boardStock;

  set boardStock(int point) {
    _boardStock = point;
    notifyListeners();
  }

  void reset() {
    _player0.point = setting.defaultPoint;
    _player1.point = setting.defaultPoint;
    _player2.point = setting.defaultPoint;
    _player3.point = setting.defaultPoint;
    _boardStock = 0;
    notifyListeners();
  }

  void submit() {
    notifyListeners();
  }
}

class SettingState extends ChangeNotifier {
  Setting setting;

  SettingState({this.setting});

  void submit() => notifyListeners();
}

class Setting {
  int defaultPoint = 25000;
}

class DragAndDropState extends ChangeNotifier {
  bool isTargetPlayer0 = false;
  bool isTargetPlayer1 = false;
  bool isTargetPlayer2 = false;
  bool isTargetPlayer3 = false;

  void dragPlayer0() {
    disableAll();
    isTargetPlayer0 = false;
    notifyListeners();
  }

  void dragPlayer1() {
    disableAll();
    isTargetPlayer1 = false;
    notifyListeners();
  }

  void dragPlayer2() {
    disableAll();
    isTargetPlayer2 = false;
    notifyListeners();
  }

  void dragPlayer3() {
    disableAll();
    isTargetPlayer3 = false;
    notifyListeners();
  }

  void disableAll() {
    isTargetPlayer0 = true;
    isTargetPlayer1 = true;
    isTargetPlayer2 = true;
    isTargetPlayer3 = true;
  }

  void reset() {
    isTargetPlayer0 = false;
    isTargetPlayer1 = false;
    isTargetPlayer2 = false;
    isTargetPlayer3 = false;
    notifyListeners();
  }
}
