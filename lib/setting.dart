import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game.dart';
import 'index.dart';
import 'player.dart';

/// ゲームタイプ
enum GameType {
  /// 東風戦
  One,

  /// 半荘戦
  Half,

  /// 一荘戦
  Full,
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
                final persons = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => PlayersPageState(players: state.players),
                      builder: (context, _) => PlayersPage(),
                    ),
                  ),
                );
                if (persons != null) {
                  // state.persons = persons;
                }
              },
            ),
          ),
          PopupMenuItem(
            child: FlatButton(
              child: Text('ゲーム設定'),
              onPressed: () async {
                final setting = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => SettingsPageState(setting: state.setting),
                      builder: (context, _) => SettingsPage(),
                    ),
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
