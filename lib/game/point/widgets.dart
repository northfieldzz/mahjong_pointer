import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/game/objects.dart';

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
      feedback: Icon(Icons.money, size: 90),
      childWhenDragging: draggingChild ?? Icon(Icons.mood_bad, size: 90),
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

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String text;

  ConfirmDialog({this.title, @required this.text});

  @override
  Widget build(BuildContext context) {
    final loc = MaterialLocalizations.of(context);
    return AlertDialog(
      title: title != null ? Text(title) : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(text),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: Text(loc.cancelButtonLabel),
                onPressed: () => Navigator.pop(context, false),
              ),
              FlatButton(
                child: Text(loc.okButtonLabel),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
    );
  }
}