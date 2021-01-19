import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../objects.dart';

class Houses {
  House playerTop;
  House playerLeft;
  House playerBottom;
  House playerRight;

  Houses({
    this.playerTop,
    this.playerLeft,
    this.playerBottom,
    this.playerRight,
  });

  /// ローテーション
  void rotate() {
    final tempHouse = playerRight;
    playerRight = playerBottom;
    playerBottom = playerLeft;
    playerLeft = playerTop;
    playerTop = tempHouse;

    final tempPlayer = playerTop.player;
    playerTop.player = playerLeft.player;
    playerLeft.player = playerBottom.player;
    playerBottom.player = playerRight.player;
    playerRight.player = tempPlayer;
  }

  void reset({int point}) {
    playerTop.player.point = point;
    playerLeft.player.point = point;
    playerBottom.player.point = point;
    playerRight.player.point = point;
  }
}

class HousesPage extends StatelessWidget {
  final Houses houses;

  HousesPage({this.houses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Players'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.pop(context, houses),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            HousesInput(house: houses.playerTop),
            HousesInput(house: houses.playerLeft),
            HousesInput(house: houses.playerBottom),
            HousesInput(house: houses.playerRight),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => null,
            ),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}

class HousesInput extends StatelessWidget {
  final House house;

  HousesInput({this.house});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Text('${house.direction.display}家'),
          TextField(
            controller: TextEditingController(text: house.player.name),
            decoration: const InputDecoration(
              labelText: 'player name',
              hintText: 'enter player name',
            ),
            onChanged: (name) => house.player.name = name,
          ),
        ],
      ),
    );
  }
}
