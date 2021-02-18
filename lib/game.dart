import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahjong_pointer/widgets.dart';
import 'package:provider/provider.dart';

import 'game/setting.dart';

class SettingsPageState extends ChangeNotifier {
  Setting setting;

  SettingsPageState({this.setting});
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SettingsPageState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.pop(context, state.setting),
        ),
      ),
      body: ThemeContainer(
        child: Column(
          children: [
            DefaultPointInput(),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}

class DefaultPointInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final setting = context.select((SettingsPageState state) => state.setting);
    return Column(
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
    );
  }
}
