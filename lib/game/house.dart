import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'player.dart';
import 'position.dart';

/// 家クラス
class House extends StatelessWidget {
  /// プレイヤーインスタンス
  final Player player;

  /// 画面上のプレイヤーの位置
  final Position position;

  /// ウィジット拡大時ベースの比率
  final double baseSize;

  /// ウィジットの直径
  final double diameter;

  House({
    @required this.player,
    @required this.position,
    this.diameter = 225,
    this.baseSize = 5.0,
  });

  /// 線の太さ
  double get circleWidth => baseSize * 2;

  /// 強調線の円の直径
  double get accentColorBall => diameter - circleWidth;

  /// 点数等プレイヤー情報表示円の直径
  double get displayBall => accentColorBall - circleWidth;

  /// Widgetの半分の距離
  double get halfBallDiameter => diameter / 2;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position == Position.Top ? -halfBallDiameter : null,
      left: position == Position.Left ? -halfBallDiameter : null,
      right: position == Position.Right ? -halfBallDiameter : null,
      bottom: position == Position.Bottom ? -halfBallDiameter : null,
      child: Transform.rotate(
        angle: position.getAngle(),
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: diameter,
                height: diameter,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              Container(
                width: accentColorBall,
                height: accentColorBall,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: player.isHost
                      ? Theme.of(context).dividerColor
                      : Colors.white,
                ),
              ),
              Container(
                width: displayBall,
                height: displayBall,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Container(
                  // TODO: サイズの可変化
                  padding: EdgeInsets.only(top: 35.0 - 2 * circleWidth),
                  child: Column(
                    children: [
                      Text(
                        player.point.toString(),
                        style: TextStyle(
                          fontFamily: 'Skia',
                          fontSize: 35,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      Text(
                        player.name,
                        style: TextStyle(
                          fontSize: 35 / 2,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
