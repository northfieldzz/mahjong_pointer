import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/game/objects.dart';
import 'package:mahjong_pointer/player/objects.dart';
import 'package:provider/provider.dart';

class DebtorWidget extends StatelessWidget {
  final Player debtor;
  final Widget child;
  final VoidCallback onDragStarted;
  final Function(Player) onDragEnd;

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
  final Player creditor;
  final Widget child;

  bool get isCenterConsole => Player == null;

  CreditorWidget({
    this.creditor,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameState>();
    return DragTarget<Player>(
      builder: (context, candidateData, rejectedData) => child,
      onWillAccept: (data) => true,
      onAccept: (debtor) {
        if (isCenterConsole) {
          state.boardStock += 1000;
        } else {
          // TODO: 得点算出ロジックの実装
          final point = 10000;
          debtor.point -= point;
          creditor.point += point;
          state.submit();
        }
      },
      onLeave: (data) => print('DragTarget.onLeave'),
    );
  }
}
