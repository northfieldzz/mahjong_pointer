import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_score/score.dart';
import 'package:provider/provider.dart';

import 'delivery.dart';
import 'pages.dart';
import 'player.dart';
import 'position.dart';

/// 家クラス
class RotatedHouse extends StatelessWidget {
  /// プレイヤーインスタンス
  final Player player;

  /// 画面上のプレイヤーの位置
  final Position position;

  final bool isReceive;

  /// ウィジット拡大時ベースの比率
  final double baseSize;

  /// ウィジットの直径
  final double diameter;

  final VoidCallback onDragStarted;
  final Function(Player) onDragEnd;

  RotatedHouse({
    @required this.player,
    @required this.position,
    @required this.isReceive,
    this.diameter = 225,
    this.baseSize = 5.0,
    @required this.onDragStarted,
    @required this.onDragEnd,
  });

  /// Widgetの半分の距離
  double get halfBallDiameter => diameter / 2;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position == Position.Top ? -halfBallDiameter : null,
      left: position == Position.Left ? -halfBallDiameter : null,
      right: position == Position.Right ? -halfBallDiameter : null,
      bottom: position == Position.Bottom ? -halfBallDiameter : null,
      child: _HouseSwitch(
        player: player,
        isReceive: isReceive,
        onDragStarted: onDragStarted,
        onDragEnd: onDragEnd,
        child: Transform.rotate(
          angle: position.getAngle(),
          child: _House(
            player: player,
            diameter: diameter,
            baseSize: baseSize,
          ),
        ),
      ),
    );
  }
}

class _House extends StatelessWidget {
  /// プレイヤーインスタンス
  final Player player;

  /// ウィジット拡大時ベースの比率
  final double baseSize;

  /// ウィジットの直径
  final double diameter;

  _House({
    @required this.player,
    @required this.diameter,
    @required this.baseSize,
  });

  /// 線の太さ
  double get circleWidth => baseSize * 2;

  /// 強調線の円の直径
  double get accentDiameter => diameter - circleWidth;

  /// 点数等プレイヤー情報表示円の直径
  double get displayDiameter => accentDiameter - circleWidth;

  /// Widgetの半分の距離
  double get halfBallDiameter => diameter / 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _Circle(diameter: diameter),
          _Circle(diameter: accentDiameter, isActive: player.isHost),
          _Circle(
            diameter: displayDiameter,
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
    );
  }
}

class _Circle extends StatelessWidget {
  final double diameter;
  final bool isActive;
  final Widget child;

  _Circle({
    @required this.diameter,
    this.isActive = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Theme.of(context).dividerColor : Colors.white,
      ),
      child: child,
    );
  }
}

class _HouseSwitch extends StatelessWidget {
  final Player player;
  final bool isReceive;
  final Widget child;
  final VoidCallback onDragStarted;
  final Function(Player) onDragEnd;

  _HouseSwitch({
    @required this.player,
    @required this.child,
    this.isReceive = false,
    @required this.onDragStarted,
    @required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    return isReceive
        ? CreditorWidget(
            child: child,
            onAccept: (debtor) async {
              // 点数計算
              final score = await Navigator.push<Score>(
                context,
                MaterialPageRoute(
                  builder: (context) => PointSelector(
                    isHost: player.isHost,
                    isPicked: debtor.isPicked,
                    consecutivelyCount: gameState.consecutivelyCount,
                  ),
                ),
              );
              if (score == null) {
                return null;
              }
              gameState.finish(
                winner: player,
                loser: debtor,
                score: score,
                isPicked: debtor.isPicked,
              );
              if (player != gameState.eastPlayer) {
                gameState.rotate();
              } else {
                gameState.noMoreReader();
              }
            },
          )
        : DebtorWidget(
            player: player,
            child: child,
            onDragStarted: onDragStarted,
            onDragEnd: onDragEnd,
          );
  }
}
