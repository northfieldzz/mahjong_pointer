/// 固定値点数
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
