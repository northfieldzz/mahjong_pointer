import 'dart:math';

import 'enums.dart';

class Score {
  /// 符
  final int hu;

  /// 翻
  final int fan;

  /// 固定値上がり点
  final FixedPoint fixedPoint;

  /// 勝者が東家か
  final bool isHost;

  /// 上がり方がツモ
  final bool isPicked;

  Score({
    this.hu,
    this.fan,
    this.fixedPoint,
    this.isHost,
    this.isPicked,
  });

  bool get isUniform => isHost;

  /// ベースとなる点数
  ///
  /// 符、翻から算出
  num get basePoint {
    if (fixedPoint != null) {
      return fixedPoint.point;
    }
    var _hu = hu;

    // 平和、七対子の符は切り上げを無視
    if (_hu != 20 && _hu != 25) {
      _hu = (_hu / 10).ceil() * 10;
    }

    // メインの点数計算式
    var _point = _hu * 4 * pow(2, fan);

    // 存在しない点数は無視
    if (200 >= _point) {
      return null;
    }

    // 満貫になる点数は満貫の固定値点数を与える
    if (_point >= 2240) {
      _point = FixedPoint.Mangan.point;
    }

    // 翻で固定値点数になる場合は固定値点数に置き換える
    if (6 <= fan && fan <= 7) {
      _point = FixedPoint.Haneman.point;
    } else if (8 <= fan && fan <= 10) {
      _point = FixedPoint.Baiman.point;
    } else if (11 <= fan && fan <= 12) {
      _point = FixedPoint.Sanbaiman.point;
    } else if (13 <= fan) {
      _point = FixedPoint.Yakuman.point;
    }
    return _point;
  }

  /// 算出できない値か
  bool get isEmpty => basePoint == null;

  /// ベースとなる点の子と親別の点数
  num get _point => basePoint * (isHost ? 1.5 : 1);

  /// 合計点数(切り上げ前)
  num get sumPoint => _point * 4;

  /// 合計点数(ロンのときの点数)
  num get point => _ceil(sumPoint);

  /// 親の受け取れる点数
  int get hostPoint => payOtherPoint * 3;

  /// 親の支払い点数(ツモのときの点数)
  int get payHostPoint => _ceil(basePoint * 2);

  /// 子の受け取れる点数
  int get otherPoint => payOtherPoint * 2 + payHostPoint;

  /// 子の支払い点数(ツモのときの点数)
  int get payOtherPoint => _ceil(isHost ? sumPoint / 3 : _point);

  /// 100点以下の点数はすべて切り上げする
  int _ceil(num number) => (number / 100).ceil() * 100;

  /// 表示用
  String toString() {
    var text = point.toString();
    text += fixedPoint == null ? '' : ' (${fixedPoint.name})';
    text += '\n${payOtherPoint.toString()}';
    text += isUniform ? ' All' : '/${payHostPoint.toString()}';
    return text;
  }
}
