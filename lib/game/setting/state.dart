import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'objects.dart';
import 'player/objects.dart';

class SettingsPageState extends ChangeNotifier {
  Setting setting;

  SettingsPageState({this.setting});

  void addNorth(Person person) {
    setting.persons.add(Person(name: 'North Player'));
    notifyListeners();
  }

  void removeNorth() {
    setting.persons.removeLast();
    notifyListeners();
  }
}
