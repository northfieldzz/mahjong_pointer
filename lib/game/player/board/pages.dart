import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../objects.dart';

class ScoreBoard extends StatelessWidget {
  final Player playerTop;
  final Player playerLeft;
  final Player playerBottom;
  final Player playerRight;

  ScoreBoard({
    this.playerTop,
    this.playerLeft,
    this.playerBottom,
    this.playerRight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Score Board')),
      body: SafeArea(
        child: Column(
          children: [
            ScoreBoardEachGame(),
          ],
        ),
      ),
    );
  }
}

class ScoreBoardEachGame extends StatelessWidget {
  final Player playerTop;
  final Player playerLeft;
  final Player playerBottom;
  final Player playerRight;

  ScoreBoardEachGame({
    this.playerTop,
    this.playerLeft,
    this.playerBottom,
    this.playerRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(children: [
            _buildHeaderCell('ゲーム数/プレイヤー名'),
            _buildHeaderCell(playerTop.name),
            _buildHeaderCell(playerLeft.name),
            _buildHeaderCell(playerBottom.name),
            _buildHeaderCell(playerRight.name),
          ])
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String label) {
    return Container(
      padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: Center(child: Text(label, textAlign: TextAlign.center)),
    );
  }

  // Widget _buildBodyCell(String label) {
  //   return Container(
  //     padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
  //     child: Center(child: Text(label, textAlign: TextAlign.center)),
  //   );
  // }
}
