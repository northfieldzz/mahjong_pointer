import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_pointer/widgets.dart';
import 'package:provider/provider.dart';

import 'game/player.dart';

class PlayersPageState extends ChangeNotifier {
  List<Player> players;

  PlayersPageState({this.players});

  bool get canAdd => players.length <= 3;

  void add() {
    players.add(Player(name: '新しい北さん', direction: Direction.North));
    notifyListeners();
  }

  void remove() {
    players.removeLast();
    notifyListeners();
  }
}

class PlayersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<PlayersPageState>();
    return Scaffold(
      appBar: AppBar(title: Text('Players')),
      body: ThemeContainer(
        child: Column(
          children: [
            ListView.builder(
              itemCount: state.players.length,
              itemBuilder: (_, index) =>
                  PlayerInput(player: state.players[index]),
            ),
            Expanded(
              child: state.canAdd
                  ? IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => state.add(),
                    )
                  : IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => state.remove(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerInput extends StatelessWidget {
  final Player player;

  PlayerInput({this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: TextField(
        controller: TextEditingController(text: player.name),
        decoration: const InputDecoration(
          labelText: 'player name',
          hintText: 'enter player name',
        ),
        onChanged: (name) => player.name = name,
      ),
    );
  }
}
