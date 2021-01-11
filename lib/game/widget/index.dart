import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/player/objects.dart';
import 'package:mahjong_pointer/player/widget/index.dart';
import 'package:provider/provider.dart';

import '../objects.dart';

class GamePage extends StatelessWidget {
  final List<Player> players;

  GamePage({this.players});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameState(players: players),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Game'),
          actions: [_buildPlayers(context)],
        ),
        body: PointWidget(),
      ),
    );
  }

  Widget _buildPlayers(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return IconButton(
          icon: Icon(Icons.supervised_user_circle_outlined),
          onPressed: () async {
            final _players = await Navigator.push<List<Player>>(
              context,
              MaterialPageRoute(
                builder: (context) => PlayersPage(
                  players: gameState.players,
                ),
              ),
            );
            gameState.setPlayers(_players);
          },
        );
      },
    );
  }
}

class PointWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _buildBurger(player: gameState.players[3]),
              _buildHorizontal(
                leftPlayer: gameState.players[1],
                rightPlayer: gameState.players[2],
              ),
              _buildBurger(player: gameState.players[0]),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBurger({Player player}) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Column(
        children: <Widget>[
          Text(player.name),
          Text(player.point.toString()),
        ],
      ),
    );
  }

  Widget _buildHorizontal({
    Player leftPlayer,
    Player rightPlayer,
  }) {
    return Selector<GameState, List<Player>>(
      selector: (context, gameState) => gameState.players,
      builder: (context, players, child) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(leftPlayer.name),
                  Text(leftPlayer.point.toString()),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(100.0, 100.0)),
              child: Container(
                color: Colors.black,
                child: CustomPaint(
                  painter: SquarePainter(),
                  child: Container(height: 200),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(rightPlayer.name),
                  Text(rightPlayer.point.toString()),
                ],
              ),
            ),
          ],
        );
      },
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
