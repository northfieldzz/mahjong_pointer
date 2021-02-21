import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/player.dart';
import 'widgets.dart';

class PlayersFormState extends ChangeNotifier {
  List<Player> players;

  PlayersFormState({this.players});

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

class PlayersForm extends StatelessWidget {
  final List<Player> players;

  PlayersForm({this.players});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayersFormState(players: players),
      builder: (context, _) {
        final state = context.watch<PlayersFormState>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Players'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, state.players),
            ),
          ),
          body: ThemeContainer(
            child: ListView.builder(
              itemCount: state.players.length,
              itemBuilder: (_, i) => _PlayerInput(player: state.players[i]),
            ),
          ),
        );
      },
    );
  }
}

class _PlayerInput extends StatelessWidget {
  final Player player;

  _PlayerInput({this.player});

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
        onChanged: (value) => player.name = value,
      ),
    );
  }
}
