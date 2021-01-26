import 'dart:math';

/// カスタムポイント抽象クラス
abstract class AbstractPoint {
  /// 名称
  final String name;

  /// 符
  final int hu;

  /// 翻
  final int fan;

  AbstractPoint({this.name, this.hu, this.fan});

  num operator +(num other) => point + other;

  num operator *(num other) => point * other;

  /// 算出される基底ポイント
  num get point;
}

/// 基底ポイント
///
/// 符、翻から求めた点計算の基底となるポイント
class BasePoint extends AbstractPoint {
  BasePoint({int hu, int fan}) : super(hu: hu, fan: fan);

  @override
  num get point {
    var _hu = hu;

    // 平和、七対子の符は切り上げを無視
    if (_hu != 20 && _hu != 25) {
      _hu = (_hu / 10).ceil() * 10;
    }

    // メインの点数計算式
    var _point = _hu * 4 * pow(2, fan);

    // 満貫になる点数は満貫の固定値点数を与える
    if (_point >= 2240) {
      _point = FixedPointType.Mangan.detail.point;
    }

    // 翻で固定値点数になる場合は固定値点数に置き換える
    if (6 <= fan && fan <= 7) {
      _point = FixedPointType.Haneman.detail.point;
    } else if (8 <= fan && fan <= 10) {
      _point = FixedPointType.Baiman.detail.point;
    } else if (11 <= fan && fan <= 12) {
      _point = FixedPointType.Sanbaiman.detail.point;
    } else if (13 <= fan) {
      _point = FixedPointType.Yakuman.detail.point;
    }
    return _point;
  }
}

/// 固定ポイント
///
/// 一定の基準を満たし、
/// 符、翻の計算から外れた固定的なポイント
class FixedPoint extends AbstractPoint {
  @override
  final int point;

  FixedPoint({this.point, String name}) : super(name: name);
}

/// 固定値点数
enum FixedPointType {
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
extension FixedPointExtension on FixedPointType {
  static final details = <FixedPointType, FixedPoint>{
    FixedPointType.Mangan: FixedPoint(name: '満貫', point: 2000),
    FixedPointType.Haneman: FixedPoint(name: '跳満', point: 3000),
    FixedPointType.Baiman: FixedPoint(name: '倍満', point: 4000),
    FixedPointType.Sanbaiman: FixedPoint(name: '三倍満', point: 6000),
    FixedPointType.Yakuman: FixedPoint(name: '役満', point: 8000),
  };

  /// 点数
  FixedPoint get detail => details[this];
}

class Score {
  final AbstractPoint abstractPoint;

  /// 勝者が東家か
  final bool isHost;

  /// 上がり方がツモ
  final bool isPicked;

  /// 連荘している回数
  final int noMoreReaderCount;

  Score({
    this.abstractPoint,
    this.isHost,
    this.isPicked,
    this.noMoreReaderCount,
  });

  bool get isUniform => isHost;

  /// 表示を行うか
  ///
  /// 基底ポイントが200以下の場合は表示しない
  bool get isNotDisplay => abstractPoint.point <= 200;

  /// ベースとなる点の子と親別の点数
  num get _point => abstractPoint * (isHost ? 1.5 : 1);

  /// 合計点数(切り上げ前)
  num get sumPoint => _point * 4;

  /// 合計点数(ロンのときの点数)
  num get point => _ceil(sumPoint);

  /// 親の受け取れる点数
  int get hostPoint => payOtherPoint * 3 + (300 * noMoreReaderCount);

  /// 親の支払い点数(ツモのときの点数)
  int get payHostPoint => _ceil(abstractPoint * 2) + (100 * noMoreReaderCount);

  /// 子の受け取れる点数
  int get otherPoint {
    return payOtherPoint * 2 + payHostPoint + (300 * noMoreReaderCount);
  }

  /// 子の支払い点数(ツモのときの点数)
  int get payOtherPoint {
    return _ceil(isHost ? sumPoint / 3 : _point) + (100 * noMoreReaderCount);
  }

  /// 100点以下の点数はすべて切り上げする
  int _ceil(num number) => (number / 100).ceil() * 100;

  /// 表示用
  String toString() {
    var text = point.toString();
    if (abstractPoint.name != null) {
      text += ' (${abstractPoint.name})';
    }
    text += '\n${payOtherPoint.toString()}';
    text += isUniform ? ' All' : '/${payHostPoint.toString()}';
    return text;
  }
}
