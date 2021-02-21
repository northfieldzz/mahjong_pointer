import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/game/player.dart';
import 'package:mahjong_pointer/game/setting.dart';
import 'package:provider/provider.dart';

import 'game.dart';
import 'index.dart';
import 'player.dart';

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
