import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/player.dart';
import 'game/setting.dart';
import 'game_control.dart';
import 'logo.dart';
import 'setting.dart';
import 'tembow.dart';
import 'widgets.dart';

class IndexPageState extends ChangeNotifier {
  var setting = Setting();
  var players = [
    Player(name: '東さん', direction: Direction.East),
    Player(name: '南さん', direction: Direction.South),
    Player(name: '西さん', direction: Direction.West),
    Player(name: '北さん', direction: Direction.North),
  ];

  void setInitial() {
    for (var player in players) {
      player.initialPoint = setting.initialPoint;
    }
  }

  bool get isExistNorth => players.length == 4;
}

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Tembow(),
            Logo(),
            ThemeContainer(
              child: ChangeNotifierProvider(
                create: (_) => IndexPageState(),
                builder: (context, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: SettingButton(),
                      ),
                      Container(
                        // TODO: 画面サイズに合わせて変更できるようにする必要がある
                        height: 400.0,
                        child: GameControl(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
