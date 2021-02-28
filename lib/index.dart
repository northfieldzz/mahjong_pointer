import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'game/pages.dart';
import 'game/player.dart';
import 'game/setting.dart';
import 'logo.dart';
import 'player.dart';
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

class SettingButton extends StatelessWidget {
  final double iconSize;

  // TODO: 画面サイズに合わせて変更できるようにする必要がある
  SettingButton({this.iconSize = 50.0});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<IndexPageState>();
    return PopupMenuButton(
      icon: Icon(
        Icons.settings,
        // size: iconSize,
        color: Theme.of(context).iconTheme.color,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: FlatButton(
              child: Text('プレイヤー'),
              onPressed: () async {
                final persons = await Navigator.push<List<Player>>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlayersForm(players: state.players),
                  ),
                );
                if (persons != null) {
                  state.players = persons;
                }
              },
            ),
          ),
          PopupMenuItem(
            child: FlatButton(
              child: Text('ゲーム設定'),
              onPressed: () async {
                final setting = await Navigator.push<Setting>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsForm(setting: state.setting),
                  ),
                );
                if (setting != null) {
                  state.setting = setting;
                }
              },
            ),
          ),
        ];
      },
    );
  }
}

class GameControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<IndexPageState>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _GameStartButton(
          '1 round',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                state.setInitial();
                return Game(
                  playerTop: state.players[0],
                  playerLeft: state.players[1],
                  playerBottom: state.players[2],
                  playerRight: state.isExistNorth ? state.players[3] : null,
                  setting: state.setting,
                );
              },
            ),
          ),
        ),
        _GameStartButton(
          'Half round',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                state.setInitial();
                return Game(
                  playerTop: state.players[0],
                  playerLeft: state.players[1],
                  playerBottom: state.players[2],
                  playerRight: state.isExistNorth ? state.players[3] : null,
                  setting: state.setting,
                );
              },
            ),
          ),
        ),
        _GameStartButton(
          'Half round',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                state.setInitial();
                return Game(
                  playerTop: state.players[0],
                  playerLeft: state.players[1],
                  playerBottom: state.players[2],
                  playerRight: state.isExistNorth ? state.players[3] : null,
                  setting: state.setting,
                );
              },
            ),
          ),
        ),
        _GameStartButton(
          'Tutorial',
          onPressed: () async {
            final url = 'https://www.youtube.com/watch?v=C4YfppkXhfM';
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
      ],
    );
  }
}

class _GameStartButton extends StatelessWidget {
  /// 表示テキスト
  final String text;

  /// 押下時イベント
  final VoidCallback onPressed;

  /// ボタン背景色
  final Color color;

  /// ボタン幅
  final double width;

  _GameStartButton(
    this.text, {
    this.onPressed,
    this.color,
    // TODO: 画面サイズに合わせて変更できるようにする必要がある
    this.width = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: this.color != null ? this.color : Theme.of(context).buttonColor,
      // TODO: Themeを使用して色の指定をできるようにしたい
      child: Text(text, style: TextStyle(color: Color(0xFF4A967F))),
      onPressed: onPressed,
      minWidth: width,
    );
  }
}
