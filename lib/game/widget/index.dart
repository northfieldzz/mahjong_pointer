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
                onPressed: () async =>
                    state.houses = await Navigator.push<Houses>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HousesPage(houses: state.houses),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () async =>
                    state.setting = await Navigator.push<Setting>(
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
              HouseWidget(
                house: gameState.houses.playerTop,
                isReceive: dragState.playerTop,
                onDragStarted: dragState.dragPlayerTop,
                onDragEnd: (_) => dragState.reset(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: HouseWidget(
                      house: gameState.houses.playerLeft,
                      isReceive: dragState.playerLeft,
                      onDragStarted: dragState.dragPlayerLeft,
                      onDragEnd: (_) => dragState.reset(),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.loose(Size(100.0, 100.0)),
                    child: Container(
                      color: Colors.black,
                      child: CustomPaint(
                        painter: SquarePainter(),
                        child: CreditorWidget(child: Container()),
                      ),
                    ),
                  ),
                  Expanded(
                    child: HouseWidget(
                      house: gameState.houses.playerRight,
                      isReceive: dragState.playerRight,
                      onDragStarted: dragState.dragPlayerRight,
                      onDragEnd: (_) => dragState.reset(),
                    ),
                  )
                ],
              ),
              HouseWidget(
                house: gameState.houses.playerBottom,
                isReceive: dragState.playerBottom,
                onDragStarted: dragState.dragPlayerBottom,
                onDragEnd: (_) => dragState.reset(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HouseWidget extends StatelessWidget {
  final House house;
  final bool isReceive;
  final VoidCallback onDragStarted;
  final Function(House) onDragEnd;

  HouseWidget({
    @required this.house,
    this.isReceive = false,
    @required this.onDragStarted,
    @required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('${house.direction.display}家'),
        Text(house.player.name),
        isReceive
            ? CreditorWidget(
                creditor: house,
                child: Icon(Icons.face_retouching_natural, size: 90),
              )
            : DebtorWidget(
                debtor: house,
                child: Icon(Icons.person_sharp, size: 90),
                onDragStarted: onDragStarted,
                onDragEnd: onDragEnd,
              ),
        Text(house.player.point.toString()),
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
