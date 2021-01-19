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

/// 東家
class EastHouse extends House {
  EastHouse({Player player})
      : super(
          player: player,
          direction: Direction.East,
        );
}

/// 南家
class SouthHouse extends House {
  SouthHouse({Player player})
      : super(
          player: player,
          direction: Direction.South,
        );
}

/// 西家
class WestHouse extends House {
  WestHouse({Player player})
      : super(
          player: player,
          direction: Direction.West,
        );
}

/// 北家
class NorthHouse extends House {
  NorthHouse({Player player})
      : super(
          player: player,
          direction: Direction.North,
        );
}

class House {
  Player player;
  final Direction direction;

  House({this.player, this.direction});
}

/// プレイヤー
class Player {
  String name;
  int point;

  Player({
    this.name,
    this.point,
  });
}
