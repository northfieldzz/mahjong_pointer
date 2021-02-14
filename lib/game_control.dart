import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'game/pages.dart';
import 'state.dart';

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
              builder: (context) => GamePage(
                setting: state.setting,
              ),
            ),
          ),
        ),
        _GameStartButton(
          'Half round',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GamePage(
                setting: state.setting,
                isHalf: true,
              ),
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
    this.width = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: this.color != null ? this.color : Theme.of(context).buttonColor,
      child: Text(text, style: TextStyle(color: Color(0xFF4A967F))),
      onPressed: onPressed,
      minWidth: width,
    );
  }
}
