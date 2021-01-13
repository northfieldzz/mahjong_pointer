import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/player/objects.dart';
import 'package:mahjong_pointer/player/widget/index.dart';
import 'package:provider/provider.dart';

import '../objects.dart';
import 'setting.dart';

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
          leading: _buildReset(),
          actions: [
            _buildPlayers(),
            _buildSetting(),
          ],
        ),
        body: PointWidget(),
      ),
    );
  }

  Widget _buildPlayers() {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return IconButton(
          icon: Icon(Icons.supervised_user_circle_outlined),
          onPressed: () async => await Navigator.push<List<Player>>(
            context,
            MaterialPageRoute(
              builder: (context) => PlayersPage(players: gameState.players),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSetting() {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return IconButton(
          icon: Icon(Icons.settings),
          onPressed: () async => await Navigator.push<Setting>(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsPage(setting: gameState.setting),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReset() {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => gameState.resetPoint(),
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
              gameState.players.length == 4
                  ? _buildBurger(player: gameState.players[3])
                  : Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    ),
              _buildHorizontal(
                leftPlayer: gameState.players[0],
                rightPlayer: gameState.players[2],
              ),
              _buildBurger(player: gameState.players[1]),
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
          Text(player.name.isNotEmpty ? player.name : 'No Name Player'),
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
