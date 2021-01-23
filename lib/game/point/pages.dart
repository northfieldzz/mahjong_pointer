import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
                final fixedPoint = FixedPoint.values[i];
                var point = MahjongCalculator.calculate(
                  isHostWithWinner: isHost,
                  isPicked: isPicked,
                  basePoint: fixedPoint.point,
                );
                var text = point.toString();
                if (isPicked && isHost) {
                  text += ' all';
                } else if (isPicked && !isHost) {
                  final lostPointToParent = MahjongCalculator.calculate(
                    isHostWithWinner: isHost,
                    isHostWithLoser: true,
                    isPicked: isPicked,
                    basePoint: point,
                  );
                  text += '/${lostPointToParent.toString()}';
                }
                return ListTile(
                  title: Text('$text (${fixedPoint.name})'),
                  onTap: () => Navigator.pop(context, point),
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
                final calculator = MahjongCalculator(hu: hu, fan: fans[index]);
                final point = MahjongCalculator.calculate(
                  isHostWithWinner: isHost,
                  isPicked: isPicked,
                  basePoint: calculator.basePoint,
                );
                if (point == null) {
                  return Container();
                }
                var text = point.toString();
                if (isPicked && isHost) {
                  text += ' all';
                } else if (isPicked && !isHost) {
                  final lostPointToParent = MahjongCalculator.calculate(
                    isHostWithWinner: isHost,
                    isHostWithLoser: true,
                    isPicked: isPicked,
                    basePoint: calculator.basePoint,
                  );
                  text += '/${lostPointToParent.toString()}';
                }

                return PointCell(
                  point: point,
                  child: _buildBodyCell(text),
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
  final int point;

  PointCell({@required this.child, this.point});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () => Navigator.pop(context, point),
    );
  }
}
