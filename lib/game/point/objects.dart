import 'dart:math';

/// 固定値ポイント
enum FixedPoint {
  /// 満貫
  Mangan,

  /// 跳満
  Haneman,

  /// 倍満
  Baiman,

  /// 三倍満
  Sanbaiman,

  /// 役満
  Yakuman,
}

/// 満貫以上表示点数計算用列列挙拡張
extension FixedPointExtension on FixedPoint {
  static final points = <FixedPoint, int>{
    FixedPoint.Mangan: 2000,
    FixedPoint.Haneman: 3000,
    FixedPoint.Baiman: 4000,
    FixedPoint.Sanbaiman: 6000,
    FixedPoint.Yakuman: 8000,
  };

  static final names = <FixedPoint, String>{
    FixedPoint.Mangan: '満貫',
    FixedPoint.Haneman: '跳満',
    FixedPoint.Baiman: '倍満',
    FixedPoint.Sanbaiman: '三倍満',
    FixedPoint.Yakuman: '役満',
  };

  /// 点数
  int get point => points[this];

  /// 名前
  String get name => names[this];
}

/// 支払う金額を計算する計算機
class MahjongCalculator {
  /// 符
  int hu;

  /// 翻
  int fan;

  MahjongCalculator({this.hu, this.fan});

  /// ベースとなる点数
  ///
  /// 符、翻から算出
  int get basePoint {
    if (hu != 20 && hu != 25) {
      hu = (hu / 10).ceil() * 10;
    }
    var point = hu * 4 * pow(2, fan);
    if (200 >= point) {
      return null;
    }
    if (point >= 2240) {
      point = 2000;
    }
    if (6 <= fan && fan <= 7) {
      point = FixedPoint.Haneman.point;
    } else if (8 <= fan && fan <= 10) {
      point = FixedPoint.Baiman.point;
    } else if (11 <= fan && fan <= 12) {
      point = FixedPoint.Sanbaiman.point;
    } else if (13 <= fan) {
      point = FixedPoint.Yakuman.point;
    }
    return point.toInt();
  }

  /// ベースとなる点数からいくら支払う必要があるか計算する
  static int calculate({
    /// 上がった人が親か
    bool isHostWithWinner,

    /// 支払う人が親か
    bool isHostWithLoser = false,

    /// 上がり方がツモか
    bool isPicked,

    /// ベースとなる点数
    num basePoint,
  }) {
    var point = basePoint;
    if (point == null) {
      return point;
    }
    point *= isHostWithWinner ? 1.5 : 1;
    if (isPicked) {
      if (isHostWithWinner) {
        point = point * 4 / 3;
      } else if (isHostWithLoser) {
        point *= 2;
      }
    } else {
      point *= 4;
    }
    point = (point / 100).ceil() * 100;
    return point.toInt();
  }
}
