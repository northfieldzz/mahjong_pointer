import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game/player/objects.dart';
import 'game/setting.dart';

class IndexPageState extends ChangeNotifier {
  var setting = Setting();
  List<Player> players = [];
  Player playerTop;
  Player playerLeft;
  Player playerBottom;
  Player playerRight;
}
