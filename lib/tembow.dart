import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 点棒ウィジット
class Tembow extends StatelessWidget {
  /// ベースとなるサイズ
  final double baseSize;

  Tembow({this.baseSize = 5.0});

  /// 基本のパディングサイズ
  double get padding => baseSize * 2;

  /// 横幅でちょうど真ん中にあたる距離
  double get halfDistance => smallSidePadding * 2 + smallSize;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -halfDistance,
      top: bigSize * 0.5,
      child: Container(
        child: Column(
          children: [
            _buildBigBall(),
            _buildSmallBall(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSmallBall(context),
                _buildSmallBall(context),
              ],
            ),
            _buildMiddleBall(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSmallBall(context),
                _buildSmallBall(context),
              ],
            ),
            _buildSmallBall(context),
            _buildBigBall(),
          ],
        ),
      ),
    );
  }

  /// 大きい玉のサイズ
  double get bigSize => baseSize * 20;

  /// 大きい玉ウィジットの構築
  Widget _buildBigBall() {
    return _Ball(
      diameter: bigSize,
      padding: EdgeInsets.all(padding * 4),
    );
  }

  /// 中くらいの玉のサイズ
  double get middleSize => baseSize * 19;

  /// 中くらいの玉のウィジット構築
  Widget _buildMiddleBall(BuildContext context) {
    return _Ball(
      diameter: middleSize,
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.all(padding),
    );
  }

  /// 小さい玉のサイズ
  double get smallSize => baseSize * 10;

  /// 小さい玉の横パディング
  double get smallSidePadding => padding * 2;

  /// 小さい玉のウィジット構築
  Widget _buildSmallBall(BuildContext context) {
    return _Ball(
      diameter: smallSize,
      padding: EdgeInsets.only(
        top: padding,
        bottom: padding,
        left: smallSidePadding,
        right: smallSidePadding,
      ),
    );
  }
}

/// 玉ウィジット
class _Ball extends StatelessWidget {
  /// 直径
  final double diameter;

  /// 色
  final Color color;

  /// パディング
  final EdgeInsets padding;

  _Ball({
    this.diameter = 20,
    this.color = Colors.white,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
