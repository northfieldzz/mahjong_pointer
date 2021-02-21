import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_score/score.dart';

import 'player.dart';
import 'setting.dart';

class GamePageState extends ChangeNotifier {
  int stockPoint;
  Player playerTop;
  Player playerLeft;
  Player playerBottom;
  Player playerRight;
  int noMoreReaderCount;

  GamePageState(
    Setting setting, {
    Player personEast,
    Player personSouth,
    Player personWest,
    Player personNorth,
  }) {
    // stockPoint = 0;
    // noMoreReaderCount = 0;
    // playerTop = Player(
    //   person: personEast,
    //   initialPoint: setting.defaultPoint,
    //   direction: Direction.East,
    // );
    // playerLeft = Player(
    //   person: personSouth,
    //   initialPoint: setting.defaultPoint,
    //   direction: Direction.South,
    // );
    // playerBottom = Player(
    //   person: personWest,
    //   initialPoint: setting.defaultPoint,
    //   direction: Direction.West,
    // );
    // if (personNorth == null) {
    //   playerRight = Player(
    //     person: personNorth,
    //     initialPoint: setting.defaultPoint,
    //     direction: Direction.North,
    //   );
    // }
  }

  List<Player> get players {
    return [playerTop, playerLeft, playerBottom, playerRight];
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
    var temp = playerRight.direction;
    playerRight.direction = playerBottom.direction;
    playerBottom.direction = playerLeft.direction;
    playerLeft.direction = playerTop.direction;
    playerTop.direction = temp;
    noMoreReaderCount = 0;
    notifyListeners();
  }

  void reach(int point) {
    stockPoint += point;
    notifyListeners();
  }

  Player get eastPlayer => players.firstWhere((player) => player.isHost);

  void noMoreReader() {
    noMoreReaderCount += 1;
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
