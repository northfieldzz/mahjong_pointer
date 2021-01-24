import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'enums.dart';
import 'objects.dart';

class PointSelector extends StatelessWidget {
  final bool isHost;
  final bool isPicked;
  final List<int> hus = [20, 25, 30, 40, 50, 60, 70];
  final List<int> hons = [1, 2, 3, 4];
  final List<int> specialHans = [5, 6, 7, 8, 9, 10, 11, 12, 13, 14];

  PointSelector({this.isHost, this.isPicked});

  String get playerGrade => isHost ? '親' : '子';

  String get finishMethod => isPicked ? 'ツモ' : 'ロン';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Point')),
      body: Column(
        children: [
          Text('$playerGrade  $finishMethod'),
          MahjongPointTable(isHost: isHost, isPicked: isPicked),
          Expanded(
            child: ListView.builder(
              itemCount: FixedPoint.values.length,
              itemBuilder: (context, i) {
                final score = Score(
                  fixedPoint: FixedPoint.values[i],
                  isHost: isHost,
                  isPicked: isPicked,
                );
                return ListTile(
                  title: Text(score.toString()),
                  onTap: () => Navigator.pop(context, score),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MahjongPointTable extends StatelessWidget {
  final bool isHost;
  final bool isPicked;
  final List<int> hus = [20, 25, 30, 40, 50, 60, 70];
  final List<int> fans = [1, 2, 3, 4];
  final List<int> specialHans = [5, 6, 7, 8, 9, 10, 11, 12, 13, 14];

  MahjongPointTable({this.isHost, this.isPicked});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            _buildHeaderCell('符\\翻'),
            ...List.generate(
              fans.length,
              (i) => _buildHeaderCell('${fans[i].toString()}'),
            ),
          ],
        ),
        ...List.generate(hus.length, (index) {
          final hu = hus[index];
          return TableRow(
            children: [
              _buildBodyCell('$hu'),
              ...List.generate(fans.length, (index) {
                final score = Score(
                  hu: hu,
                  fan: fans[index],
                  isHost: isHost,
                  isPicked: isPicked,
                );
                if (score.isEmpty) {
                  return Container();
                }
                return PointCell(
                  score: score,
                  child: _buildBodyCell(score.toString()),
                );
              }),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildHeaderCell(String label) {
    return Container(
      padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: Center(child: Text(label, textAlign: TextAlign.center)),
    );
  }

  Widget _buildBodyCell(String label) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Center(child: Text(label, textAlign: TextAlign.center)),
    );
  }
}

class PointCell extends StatelessWidget {
  final Widget child;
  final Score score;

  PointCell({@required this.child, this.score});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () => Navigator.pop(context, score),
    );
  }
}
