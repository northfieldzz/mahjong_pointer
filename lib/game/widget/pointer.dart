import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/game/objects.dart';
import 'package:mahjong_pointer/player/objects.dart';
import 'package:provider/provider.dart';

class DebtorWidget extends StatelessWidget {
  final House debtor;
  final Widget child;
  final VoidCallback onDragStarted;
  final Function(House) onDragEnd;

  DebtorWidget({
    this.debtor,
    this.child,
    @required this.onDragStarted,
    @required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: debtor,
      child: child,
      onDragStarted: onDragStarted,
      onDragEnd: (value) => onDragEnd(debtor),
      onDraggableCanceled: (velocity, offset) => onDragEnd(debtor),
      onDragCompleted: () => onDragEnd(debtor),
      feedback: Icon(Icons.money, size: 90),
      childWhenDragging: Icon(Icons.mood_bad, size: 90),
    );
  }
}

class CreditorWidget extends StatelessWidget {
  final House creditor;
  final Widget child;

  bool get isCenterConsole => Player == null;

  CreditorWidget({
    this.creditor,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameState>();
    return DragTarget<House>(
      builder: (context, candidateData, rejectedData) => child,
      onWillAccept: (data) => true,
      onAccept: (debtor) async {
        if (isCenterConsole) {
          state.boardStock += 1000;
        } else {
          final point = await Navigator.push<int>(
            context,
            MaterialPageRoute(
              builder: (context) => PointSelector(
                isDealer: creditor.direction == Direction.East,
              ),
            ),
          );
          if (point == null) {
            return null;
          }
          debtor.player.point -= point;
          creditor.player.point += point;
          state.submit();
          state.rotateHouse();
        }
      },
      onLeave: (data) => print('DragTarget.onLeave'),
    );
  }
}

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

extension FixedPointExtension on FixedPoint {
  static final points = <FixedPoint, int>{
    FixedPoint.Mangan: 8000,
    FixedPoint.Haneman: 12000,
    FixedPoint.Baiman: 16000,
    FixedPoint.Sanbaiman: 24000,
    FixedPoint.Yakuman: 32000,
  };

  int get point => points[this];
}

class PointSelector extends StatelessWidget {
  final List<int> hus = [20, 25, 30, 40, 50, 60, 70];
  final List<int> hons = [1, 2, 3, 4];
  final List<int> specialHans = [5, 6, 7, 8, 9, 10, 11, 12, 13, 14];
  final bool isDealer;

  PointSelector({this.isDealer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Point'),
      ),
      body: Column(
        children: [
          Text(isDealer ? '親' : '子'),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: List.generate(
                  hons.length + 1,
                  (index) {
                    if (index == 0) {
                      return Container(
                        child: Center(
                          child: Text(
                            '符\\翻',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                      child: Center(
                        child: Text(
                          '${hons[index - 1].toString()}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
              ...List.generate(
                hus.length,
                (index) {
                  final hu = hus[index];
                  return TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          '$hu',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ...List.generate(
                        hons.length,
                        (index) {
                          final hon = hons[index];
                          final point = calcPoint(
                            hu: hu,
                            hon: hon,
                            isDealer: isDealer,
                          );
                          var threshold = 8000;
                          if (isDealer) {
                            threshold = 12000;
                          }
                          return PointCell(
                            point: threshold <= point ? null : point,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: FixedPoint.values.length,
              itemBuilder: (context, index) {
                final fixedPoint = FixedPoint.values[index];
                var point = fixedPoint.point;
                if (isDealer) {
                  point = ((point * 1.5) / 100).ceil() * 100;
                }
                return ListTile(
                  title: Text(point.toString()),
                  onTap: () => Navigator.pop(context, point),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 点計算
  int calcPoint({
    @required int hu,
    @required int hon,
    bool isDealer = false,
  }) {
    if (hu != 20 && hu != 25) {
      hu = (hu / 10).ceil() * 10;
    }
    final rate = isDealer ? 6 : 4;
    final original = hu * rate * pow(2, hon + 2);
    return (original / 100).ceil() * 100;
  }
}

class PointCell extends StatelessWidget {
  final int point;

  PointCell({this.point});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: point == null
          ? null
          : GestureDetector(
              child: Text(
                '${point.toString()}',
                textAlign: TextAlign.center,
              ),
              onTap: () => Navigator.pop(context, point),
            ),
    );
  }
}
