import 'point/score.dart';

/// 方角
enum HouseDirection {
  /// 東
  East,

  /// 南
  South,

  /// 西
  West,

  /// 北
  North,
}

extension DirectionExtension on HouseDirection {
  static const displays = <HouseDirection, String>{
    HouseDirection.East: '東',
    HouseDirection.South: '南',
    HouseDirection.West: '西',
    HouseDirection.North: '北'
  };

  /// 表示名
  String get display => displays[this];
}

/// プレイヤー
class Player {
  String name;
  HouseDirection direction;
  int initialPoint;
  List<int> _points = [];
  bool isCall;

  Player({
    this.name,
    this.direction,
    this.initialPoint,
    this.isCall = false,
  });
  bool get isHost => direction == HouseDirection.East;
  bool get isPicked => direction == null;
  int get point {
    var _point = initialPoint;
    _points.forEach((score) => _point += score);
    if (isCall) {
      _point -= 1000;
    }
    return _point;
  }

  List<int> get scores => _points;
  void registerPoints({
    Score score,
    Player winner,
    Player loser,
    bool isPicked,
    int stockPoint,
  }) {
    var _point = 0;
    if (isPicked) {
      // ツモの場合
      if (winner == this) {
        // 勝者の場合
        _point = isHost ? score.hostPoint : score.otherPoint;
      } else {
        // 勝者以外
        _point = isHost ? -score.payHostPoint : -score.payOtherPoint;
      }
    } else {
      // ロンの場合
      if (winner == this) {
        // 勝者の場合
        _point = score.point;
      } else if (loser == this) {
        // 敗者の場合
        _point = -score.point;
      }
    }
    // リーチ棒の処理
    if (winner == this) {
      _point += stockPoint;
    }
    _point -= isCall ? 1000 : 0;
    isCall = false;
    _points.add(_point);
  }
}
