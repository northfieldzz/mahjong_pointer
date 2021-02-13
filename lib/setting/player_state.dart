import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../game/player/objects.dart';

class PlayersPageState extends ChangeNotifier {
  List<Player> players = [];

  PlayersPageState({this.players});

  void add() {
    players.add(
      Player(
        name: 'New Player',
      ),
    );
    notifyListeners();
  }
}
