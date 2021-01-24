import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/game/point/objects.dart';

import 'objects.dart';
import 'setting/objects.dart';
import 'setting/player/objects.dart';

class GamePageState extends ChangeNotifier {
  int stockPoint;
  Player playerTop;
  Player playerLeft;
  Player playerBottom;
  Player playerRight;

  GamePageState(Setting setting) {
    stockPoint = 0;
    playerTop = Player(
      person: setting.persons[0],
      initialPoint: setting.defaultPoint,
      direction: Direction.East,
    );
    playerLeft = Player(
      person: setting.persons[1],
      initialPoint: setting.defaultPoint,
      direction: Direction.South,
    );
    playerBottom = Player(
      person: setting.persons[2],
      initialPoint: setting.defaultPoint,
      direction: Direction.West,
    );
    if (setting.persons.length == 4) {
      playerRight = Player(
        person: setting.persons[3],
        initialPoint: setting.defaultPoint,
        direction: Direction.North,
      );
    }
  }

  void finish({
    Player winner,
    Player loser,
    Score score,
    bool isPicked,
  }) {
    playerTop.registerPoints(
      score: score,
      winner: winner,
      loser: loser,
      isPicked: isPicked,
      stockPoint: stockPoint,
    );
    playerLeft.registerPoints(
      score: score,
      winner: winner,
      loser: loser,
      isPicked: isPicked,
      stockPoint: stockPoint,
    );
    playerBottom.registerPoints(
      score: score,
      winner: winner,
      loser: loser,
      isPicked: isPicked,
      stockPoint: stockPoint,
    );
    playerRight?.registerPoints(
      score: score,
      winner: winner,
      loser: loser,
      isPicked: isPicked,
      stockPoint: stockPoint,
    );
    stockPoint = 0;
    notifyListeners();
  }

  void rotate() {
    notifyListeners();
  }

  void reach(int point) {
    stockPoint += point;
    notifyListeners();
  }
}

class DropTargetState extends ChangeNotifier {
  bool playerTop = false;
  bool playerLeft = false;
  bool playerBottom = false;
  bool playerRight = false;
  bool centerConsole = false;

  void dragPlayerTop() {
    disableAll();
    playerTop = false;
    notifyListeners();
  }

  void dragPlayerLeft() {
    disableAll();
    playerLeft = false;
    notifyListeners();
  }

  void dragPlayerBottom() {
    disableAll();
    playerBottom = false;
    notifyListeners();
  }

  void dragPlayerRight() {
    disableAll();
    playerRight = false;
    notifyListeners();
  }

  void dragCenterConsole() {
    disableAll();
    centerConsole = false;
    notifyListeners();
  }

  void disableAll() {
    playerTop = true;
    playerLeft = true;
    playerBottom = true;
    playerRight = true;
    centerConsole = true;
  }

  void reset() {
    playerTop = false;
    playerLeft = false;
    playerBottom = false;
    playerRight = false;
    centerConsole = false;
    notifyListeners();
  }
}
