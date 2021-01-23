import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state.dart';
import 'objects.dart';

class HomesForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SettingsPageState>();
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          ...List.generate(
            state.setting.persons.length,
            (index) => HousesInput(person: state.setting.persons[index]),
          ),
          state.setting.persons.length == 3
              ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => state.addNorth(
                    Person(name: 'North House'),
                  ),
                )
              : Container(),
          state.setting.persons.length == 4
              ? IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => state.removeNorth(),
                )
              : Container(),
        ],
      ),
    );
  }
}

class HousesInput extends StatelessWidget {
  final Person person;

  HousesInput({this.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          // Text('${character.direction.display}家'),
          TextField(
            controller: TextEditingController(text: person.name),
            decoration: const InputDecoration(
              labelText: 'player name',
              hintText: 'enter player name',
            ),
            onChanged: (name) => person.name = name,
          ),
        ],
      ),
    );
  }
}
