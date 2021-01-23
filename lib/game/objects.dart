import 'setting/objects.dart';
import 'setting/player/objects.dart';

/// 1局
class RoundGame {
  int stockPoint;
  Player playerTop;
  Player playerLeft;
  Player playerBottom;
  Player playerRight;

  RoundGame(Setting setting) {
    stockPoint = 0;
    playerTop = Player(
      person: setting.persons[0],
      initialPoint: setting.defaultPoint,
      direction: Direction.East,
    );
    playerLeft = Player(
      person: setting.persons[1],
      initialPoint: setting.defaultPoint,
      direction: Direction.South,
    );
    playerBottom = Player(
      person: setting.persons[2],
      initialPoint: setting.defaultPoint,
      direction: Direction.West,
    );
    if (setting.persons.length == 4) {
      playerRight = Player(
        person: setting.persons[3],
        initialPoint: setting.defaultPoint,
        direction: Direction.North,
      );
    }
  }

  void finish({Player winner, Player loser, int point}) {
    if (loser == null) {
      // 特定の振込者がいない　-> ツモ
    } else {
      // 特定の振込者がいる -> ロン
    }
    stockPoint = 0;
  }

  void rotate() {}
}

/// プレイヤー
class Player {
  Person person;
  Direction direction;
  int initialPoint;
  List<int> scores = [];
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
    scores.forEach((score) => _point += score);
    if (isCall) {
      _point -= 1000;
    }
    return _point;
  }
}
