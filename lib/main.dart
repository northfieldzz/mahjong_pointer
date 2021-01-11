import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game/widget/index.dart';
import 'player/objects.dart';

void main() => runApp(MahjongPointerApp());

class MahjongPointerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahjong Pointer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: GamePage(players: [
        Player(name: 'Player 1', point: 25000),
        Player(name: 'Player 2', point: 25000),
        Player(name: 'Player 3', point: 25000),
        Player(name: 'Player 4', point: 25000),
      ]),
    );
  }
}
