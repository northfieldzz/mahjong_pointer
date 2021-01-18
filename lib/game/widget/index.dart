import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/player/objects.dart';
import 'package:mahjong_pointer/player/widget/index.dart';
import 'package:provider/provider.dart';

import '../objects.dart';
import 'pointer.dart';
import 'setting.dart';

/// ゲーム画面
class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameState(),
      builder: (context, child) {
        final state = context.watch<GameState>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Game'),
            leading: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => state.reset(),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.supervised_user_circle_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayersPage(
                      player0: state.player0,
                      player1: state.player1,
                      player2: state.player2,
                      player3: state.player3,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(setting: state.setting),
                  ),
                ),
              ),
            ],
          ),
          body: child,
        );
      },
      child: Center(child: Align(child: PointWidget())),
    );
  }
}

class PointWidget extends StatelessWidget {
  final double playerSize;

  PointWidget({this.playerSize = 20.0});

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    return Container(
      padding: EdgeInsets.all(playerSize),
      child: ChangeNotifierProvider<DragAndDropState>(
        create: (_) => DragAndDropState(),
        builder: (context, child) {
          final dragState = context.watch<DragAndDropState>();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              PlayerWidget(
                player: gameState.player3,
                isReceive: dragState.isTargetPlayer3,
                onDragStarted: dragState.dragPlayer3,
                onDragEnd: (_) => dragState.reset(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: PlayerWidget(
                      player: gameState.player0,
                      isReceive: dragState.isTargetPlayer0,
                      onDragStarted: dragState.dragPlayer0,
                      onDragEnd: (_) => dragState.reset(),
                    ),
                  ),
                  CustomPaint(
                    painter: SquarePainter(),
                    child: CreditorWidget(child: Container()),
                  ),
                  Expanded(
                    child: PlayerWidget(
                      player: gameState.player2,
                      isReceive: dragState.isTargetPlayer2,
                      onDragStarted: dragState.dragPlayer2,
                      onDragEnd: (_) => dragState.reset(),
                    ),
                  )
                ],
              ),
              PlayerWidget(
                player: gameState.player1,
                isReceive: dragState.isTargetPlayer1,
                onDragStarted: dragState.dragPlayer1,
                onDragEnd: (_) => dragState.reset(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final Player player;
  final bool isReceive;
  final VoidCallback onDragStarted;
  final Function(Player) onDragEnd;

  PlayerWidget({
    @required this.player,
    this.isReceive = false,
    @required this.onDragStarted,
    @required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(player.name),
        isReceive
            ? CreditorWidget(
                creditor: player,
                child: Icon(Icons.face_retouching_natural, size: 90),
              )
            : DebtorWidget(
                debtor: player,
                child: Icon(Icons.person_sharp, size: 90),
                onDragStarted: onDragStarted,
                onDragEnd: onDragEnd,
              ),
        Text(player.point.toString()),
      ],
    );
  }
}

class SquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green;
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
