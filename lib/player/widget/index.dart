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
        appBar: AppBar(
          title: Text('Players'),
          leading: _buildBackButton(context),
        ),
        body: PlayersForm(),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Consumer<PlayersState>(
      builder: (context, playersState, child) {
        return IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.pop(context, playersState.players),
        );
      },
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
  final VoidCallback onRemove;

  PlayerInput({this.index, this.label, this.onRemove});

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
                decoration: const InputDecoration(
                  labelText: 'player name',
                  hintText: 'enter player name',
                ),
                onChanged: (name) {
                  _player.name = name;
                  playersState.set(index, _player);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
