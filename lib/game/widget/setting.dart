import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../objects.dart';

class SettingsPage extends StatelessWidget {
  final Setting setting;

  SettingsPage({this.setting});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.pop(context, setting),
        ),
      ),
      body: SettingsForm(setting: setting),
      resizeToAvoidBottomPadding: false,
    );
  }
}

class SettingsForm extends StatelessWidget {
  final Setting setting;

  SettingsForm({this.setting});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: TextEditingController(
              text: setting.defaultPoint.toString(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              labelText: 'default point',
              hintText: 'enter default point',
            ),
            onChanged: (point) {
              if (point.isEmpty) point = '0';
              setting.defaultPoint = int.parse(point);
            },
          ),
        ],
      ),
    );
  }
}
