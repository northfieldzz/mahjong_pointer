import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/player/objects.dart';

class GameState extends ChangeNotifier {
  var players = <Player>[];
  var setting = Setting();

  GameState({this.players});

  void setPlayers(List<Player> _players) {
    players = _players;
    notifyListeners();
  }

  void setSetting(Setting _setting) {
    setting = _setting;
    notifyListeners();
  }

  void resetPoint() {
    players = players.map((player) {
      player.point = setting.defaultPoint;
      return player;
    }).toList();
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
