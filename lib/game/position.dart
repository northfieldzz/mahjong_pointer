import 'dart:math';

/// 画面表示上の位置
enum Position {
  /// 上
  Top,

  /// 左
  Left,

  /// 右
  Right,

  /// 下
  Bottom,
}

extension PositionExtension on Position {
  /// 内側に向く角度
  static final angles = {
    Position.Top: pi,
    Position.Left: pi / 2,
    Position.Right: pi / -2,
    Position.Bottom: pi * 2,
  };

  /// 内側に向く角度を取得
  double getAngle() => angles[this];
}
