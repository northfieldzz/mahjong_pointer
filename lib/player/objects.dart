import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayersState extends ChangeNotifier {
  List<Player> players = [];

  PlayersState({@required this.players}) {
    notifyListeners();
  }

  void add(Player player) {
    players.add(player);
    notifyListeners();
  }

  void removeAt(int index) {
    players.removeAt(index);
    notifyListeners();
  }

  void submit() => notifyListeners();
}

class Player {
  String name;
  int point;

  Player({
    this.name,
    this.point,
  });
}
