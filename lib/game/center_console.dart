import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages.dart';
import 'position.dart';

/// 麻雀の真ん中にあるやつ
class CenterConsole extends StatelessWidget {
  /// Widgetの1辺の長さ
  final double distance;

  CenterConsole({this.distance = 120});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<GameState>();
    return Positioned(
      child: Container(
        height: distance,
        width: distance,
        color: Theme.of(context).dividerColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildText(context, state.title),
                state.noMoreReaderCount > 0
                    ? _buildText(context, state.subtitle)
                    : Container(),
              ],
            ),
            _ReachBar(
              isLit: state.playerTop.isCall,
              position: Position.Top,
            ),
            _ReachBar(
              isLit: state.playerLeft.isCall,
              position: Position.Left,
            ),
            _ReachBar(
              isLit: state.playerBottom.isCall,
              position: Position.Bottom,
            ),
            state.playerRight != null
                ? _ReachBar(
                    isLit: state.playerRight.isCall,
                    position: Position.Right,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  /// 表示文字列のビルド
  Widget _buildText(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        // TODO: サイズの可変化
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}

/// リーチ棒
class _ReachBar extends StatelessWidget {
  /// リーチしてるか
  final bool isLit;

  /// 画面上のプレイヤーの位置
  final Position position;

  /// リーチ棒の高さ
  final double height;

  /// リーチ棒の幅
  final double width;

  _ReachBar({
    @required this.isLit,
    @required this.position,
    this.height = 6,
    this.width = 50,
  });

  /// リーチ棒が上、下にあるとき親Widgetの一番近い一辺からの距離
  double get _distance => height * 1.5;

  /// リーチ棒が左、右にあるとき親widgetの一番近い一辺からの距離
  double get _sideDistance => _distance - width / 2 + height / 2;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position == Position.Top ? _distance : null,
      left: position == Position.Left ? _sideDistance : null,
      right: position == Position.Right ? _sideDistance : null,
      bottom: position == Position.Bottom ? _distance : null,
      child: Transform.rotate(
        angle: position.getAngle(),
        child: Container(
          height: height,
          width: width,
          color: isLit
              ? Theme.of(context).accentColor
              : Theme.of(context).dividerColor,
        ),
      ),
    );
  }
}
