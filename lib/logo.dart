import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  /// ベースとなるサイズ
  final double baseSize;

  Logo({this.baseSize = 5.0});

  /// 大きい玉のサイズ
  double get bigSize => baseSize * 20;

  /// 基本のパディングサイズ
  double get padding => baseSize * 2;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: bigSize + padding * 7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _LogoText('T'),
          _LogoText('E'),
          _LogoText('M', color: Color(0xFF4A967F)),
          _LogoText('B'),
          _LogoText('O'),
          _LogoText('W'),
        ],
      ),
    );
  }
}

class _LogoText extends StatelessWidget {
  /// 表示テキスト
  final String text;

  /// フォントサイズ
  final double fontSize;

  /// フォント色
  final Color color;

  _LogoText(
    this.text, {
    this.fontSize = 80.0,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Grandstander',
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
