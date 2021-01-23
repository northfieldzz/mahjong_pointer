import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game/setting/objects.dart';

class GameWidgetState extends ChangeNotifier {
  Setting setting = Setting();

  void setSetting(Setting _setting) {
    if (_setting != null) {
      setting = _setting;
      notifyListeners();
    }
  }
}
