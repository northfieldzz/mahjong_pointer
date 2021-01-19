import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/player/objects.dart';
import 'package:mahjong_pointer/player/widget/index.dart';

const defaultPoint = 25000;

class GameState extends ChangeNotifier {
  Houses _houses = Houses(
    playerTop: EastHouse(
      player: Player(
        name: 'Player East',
        point: defaultPoint,
      ),
    ),
    playerLeft: SouthHouse(
      player: Player(
        name: 'Player South',
        point: defaultPoint,
      ),
    ),
    playerBottom: WestHouse(
      player: Player(
        name: 'Player West',
        point: defaultPoint,
      ),
    ),
    playerRight: NorthHouse(
      player: Player(
        name: 'Player North',
        point: defaultPoint,
      ),
    ),
  );

  var _setting = Setting();
  var _boardStock = 0;

  Houses get houses => _houses;

  set houses(Houses newInput) {
    _houses = newInput;
    submit();
  }

  Setting get setting => _setting;

  set setting(Setting newInput) {
    _setting = newInput;
    submit();
  }

  int get boardStock => _boardStock;

  set boardStock(int newInput) {
    _boardStock = newInput;
    submit();
  }

  void reset() {
    houses.reset(point: setting.defaultPoint);
    submit();
  }

  void submit() => notifyListeners();

  void rotateHouse() {
    houses.rotate();
    submit();
  }
}

class Setting {
  int defaultPoint = 25000;
}

class DragAndDropState extends ChangeNotifier {
  bool playerTop = false;
  bool playerLeft = false;
  bool playerBottom = false;
  bool playerRight = false;

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

  void disableAll() {
    playerTop = true;
    playerLeft = true;
    playerBottom = true;
    playerRight = true;
  }

  void reset() {
    playerTop = false;
    playerLeft = false;
    playerBottom = false;
    playerRight = false;
    notifyListeners();
  }
}
