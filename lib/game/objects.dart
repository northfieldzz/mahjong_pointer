import 'point/objects.dart';
import 'setting/player/objects.dart';

/// プレイヤー
class Player {
  Person person;
  Direction direction;
  int initialPoint;
  List<int> _points = [];
  bool isCall;

  Player({
    this.person,
    this.direction,
    this.initialPoint,
    this.isCall = false,
  });

  bool get isHost => direction == Direction.East;

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
    } else {
      _point -= isCall ? 1000 : 0;
    }
    isCall = false;
    _points.add(_point);
  }
}
