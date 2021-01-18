import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayersState extends ChangeNotifier {
  Player _player0;
  Player _player1;
  Player _player2;
  Player _player3;
  bool _isThreePlayer = false;

  PlayersState({
    Player player0,
    Player player1,
    Player player2,
    Player player3,
  }) {
    _player0 = player0;
    _player1 = player1;
    _player2 = player2;
    _player3 = player3;
    notifyListeners();
  }

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

  set isThreePlayer(bool isThree) {
    _isThreePlayer = isThree;
    notifyListeners();
  }

  bool get isThreePlayer => _isThreePlayer;

// void submit() => notifyListeners();
}

class Player {
  String name;
  int point;

  Player({
    this.name,
    this.point,
  });
}
