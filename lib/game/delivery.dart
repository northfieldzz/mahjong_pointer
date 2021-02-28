import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_score/base.dart';
import 'package:mahjong_score/fixed.dart';
import 'package:mahjong_score/score.dart';

import 'player.dart';

class DragAndDropState extends ChangeNotifier {
  bool isTop = false;
  bool isLeft = false;
  bool isBottom = false;
  bool isRight = false;
  bool isCenterConsole = false;

  void dragPlayerTop() {
    disableAll();
    isTop = false;
    notifyListeners();
  }

  void dragPlayerLeft() {
    disableAll();
    isLeft = false;
    notifyListeners();
  }

  void dragPlayerBottom() {
    disableAll();
    isBottom = false;
    notifyListeners();
  }

  void dragPlayerRight() {
    disableAll();
    isRight = false;
    notifyListeners();
  }

  void dragCenterConsole() {
    disableAll();
    isCenterConsole = false;
    notifyListeners();
  }

  void disableAll() {
    isTop = true;
    isLeft = true;
    isBottom = true;
    isRight = true;
    isCenterConsole = true;
  }

  void reset(Player player) {
    isTop = false;
    isLeft = false;
    isBottom = false;
    isRight = false;
    isCenterConsole = false;
    notifyListeners();
  }
}

/// 支払うプレイヤーのウィジット
///
/// 支払うプレイヤーはドラッグできる
class DebtorWidget extends StatelessWidget {
  final Player debtor;
  final Widget child;
  final VoidCallback onDragStarted;
  final Function(Player) onDragEnd;
  final Widget draggingChild;

  DebtorWidget({
    this.debtor,
    this.child,
    @required this.onDragStarted,
    @required this.onDragEnd,
    this.draggingChild,
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
      feedback: child,
      childWhenDragging: draggingChild,
    );
  }
}

/// 受け取るプレイヤーのウィジット
///
/// 受け取るプレイヤーはドロップして支払うプレイヤーインスタンスを取得することができる
class CreditorWidget extends StatelessWidget {
  final Widget child;
  final Function(Player) onAccept;

  CreditorWidget({
    @required this.child,
    @required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Player>(
      builder: (context, candidateData, rejectedData) => child,
      onWillAccept: (data) => true,
      onAccept: onAccept,
      onLeave: (data) => print('DragTarget.onLeave'),
    );
  }
}

class PointSelector extends StatelessWidget {
  final bool isHost;
  final bool isPicked;
  final int consecutivelyCount;
  final List<int> hus = [20, 25, 30, 40, 50, 60, 70];
  final List<int> hons = [1, 2, 3, 4];
  final List<int> specialHans = [5, 6, 7, 8, 9, 10, 11, 12, 13, 14];

  PointSelector({
    this.isHost,
    this.isPicked,
    this.consecutivelyCount,
  });

  String get playerGrade => isHost ? '親' : '子';

  String get finishMethod => isPicked ? 'ツモ' : 'ロン';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Point')),
      body: Column(
        children: [
          Text('$playerGrade  $finishMethod'),
          MahjongPointTable(
            isHost: isHost,
            isPicked: isPicked,
            noMoreReaderCount: consecutivelyCount,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: FixedPointType.values.length,
              itemBuilder: (context, i) {
                final score = Score(
                  abstractPoint: FixedPointType.values[i].detail,
                  isHost: isHost,
                  isPicked: isPicked,
                  consecutivelyCount: consecutivelyCount,
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
  final int noMoreReaderCount;
  final List<int> hus = [20, 25, 30, 40, 50, 60, 70];
  final List<int> fans = [1, 2, 3, 4];
  final List<int> specialHans = [5, 6, 7, 8, 9, 10, 11, 12, 13, 14];

  MahjongPointTable({
    this.isHost,
    this.isPicked,
    this.noMoreReaderCount,
  });

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
                  abstractPoint: BasePoint(hu: hu, fan: fans[index]),
                  isHost: isHost,
                  isPicked: isPicked,
                  consecutivelyCount: noMoreReaderCount,
                );
                if (score.isNotDisplay) {
                  return Container();
                }
                return GestureDetector(
                  child: _buildBodyCell(score.toString()),
                  onTap: () => Navigator.pop(context, score),
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
