import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../objects.dart';

class SettingsPage extends StatelessWidget {
  final Setting setting;

  SettingsPage({this.setting});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingState(setting: setting),
      child: Scaffold(
        appBar: AppBar(title: Text('Settings')),
        body: SettingsForm(),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}

class SettingsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingState>(
      builder: (context, settingState, child) {
        var setting = settingState.setting;
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
                  settingState.setting.defaultPoint = int.parse(point);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
