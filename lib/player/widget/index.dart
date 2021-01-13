import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../objects.dart';

class PlayersPage extends StatelessWidget {
  final List<Player> players;

  PlayersPage({this.players});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlayersState(players: players),
      child: Scaffold(
        appBar: AppBar(title: Text('Players')),
        body: PlayersForm(),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}

class PlayersForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayersState>(
      builder: (context, playersState, child) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              ListView.builder(
                itemCount: playersState.players.length,
                itemBuilder: (context, index) => PlayerInput(
                  index: index,
                  initialName: playersState.players[index].name,
                  label: 'Player ${index + 1}',
                  onRemove: () {
                    if (3 >= playersState.players.length) return;
                    playersState.removeAt(index);
                  },
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (4 <= playersState.players.length) return;
                  playersState.add(Player(name: '', point: 25000));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class PlayerInput extends StatelessWidget {
  final int index;
  final String label;
  final String initialName;
  final VoidCallback onRemove;

  PlayerInput({
    this.index,
    this.label,
    this.initialName = '',
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayersState>(
      builder: (context, playersState, child) {
        var _player = playersState.players[index];
        return Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(label),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: onRemove,
                  ),
                ],
              ),
              TextField(
                controller: TextEditingController(text: initialName),
                decoration: const InputDecoration(
                  labelText: 'player name',
                  hintText: 'enter player name',
                ),
                onChanged: (name) => _player.name = name,
              ),
            ],
          ),
        );
      },
    );
  }
}
