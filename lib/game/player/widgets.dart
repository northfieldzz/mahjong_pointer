import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../player.dart';

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
      feedback: Icon(Icons.money, size: 60),
      childWhenDragging: draggingChild ?? Icon(Icons.mood_bad, size: 60),
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
