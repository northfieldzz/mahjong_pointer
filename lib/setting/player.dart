import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game/player/objects.dart';
import 'player_state.dart';

class PlayersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<PlayersPageState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Players'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => Navigator.pop(context, state.players),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: state.players.length,
        itemBuilder: (_, index) => PlayerInput(player: state.players[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => state.add(),
      ),
    );
  }
}

class PlayerInput extends StatelessWidget {
  final Player player;

  PlayerInput({this.player});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: TextEditingController(text: player.name),
          decoration: const InputDecoration(
            labelText: 'player name',
            hintText: 'enter player name',
          ),
          onChanged: (name) => player.name = name,
        ),
      ],
    );
  }
}
