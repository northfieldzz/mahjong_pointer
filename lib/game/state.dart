import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
