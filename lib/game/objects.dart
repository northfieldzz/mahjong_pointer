import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/player/objects.dart';

class GameState extends ChangeNotifier {
  var players = <Player>[];

  GameState({this.players});

  void setPlayers(List<Player> _players) {
    players = _players;
    notifyListeners();
  }
}
