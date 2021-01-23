import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages.dart';

void main() => runApp(MahjongPointerApp());

class MahjongPointerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahjong Pointer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
