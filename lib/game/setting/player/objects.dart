/// 方角
enum Direction {
  /// 東
  East,

  /// 南
  South,

  /// 西
  West,

  /// 北
  North,
}

extension DirectionExtension on Direction {
  static const displays = <Direction, String>{
    Direction.East: '東',
    Direction.South: '南',
    Direction.West: '西',
    Direction.North: '北'
  };

  /// 表示名
  String get display => displays[this];
}

/// プレイヤー
class Person {
  /// 名前
  String name;

  Person({this.name});
}
