import 'dart:math';

enum PositionDirection {
  Top,
  Left,
  Right,
  Bottom,
}

extension DirectionExtension on PositionDirection {
  static final angles = {
    PositionDirection.Top: pi,
    PositionDirection.Left: pi / 2,
    PositionDirection.Right: pi / -2,
    PositionDirection.Bottom: pi * 2,
  };

  double getAngle() => angles[this];
}
