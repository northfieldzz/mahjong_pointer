import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../objects.dart';

class PlayersPage extends StatelessWidget {
  final Player player0;
  final Player player1;
  final Player player2;
  final Player player3;

  PlayersPage({
    this.player0,
    this.player1,
    this.player2,
    this.player3,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlayersState(
        player0: player0,
        player1: player1,
        player2: player2,
        player3: player3,
      ),
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
    final state = context.watch<PlayersState>();
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          PlayerInput(player: state.player0),
          PlayerInput(player: state.player1),
          PlayerInput(player: state.player2),
          PlayerInput(player: state.player3),
          IconButton(icon: Icon(Icons.add), onPressed: () {})
        ],
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
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Text(player.name),
          TextField(
            controller: TextEditingController(text: player.name),
            decoration: const InputDecoration(
              labelText: 'player name',
              hintText: 'enter player name',
            ),
            onChanged: (name) => player.name = name,
          ),
        ],
      ),
    );
  }
}
