import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahjong_pointer/game/setting.dart';
import 'package:mahjong_pointer/widgets.dart';
import 'package:provider/provider.dart';

import 'game/setting.dart';

class SettingsFormState extends ChangeNotifier {
  Setting setting;

  void setIsFlowEast(bool status) {
    setting.isFlowEast = status;
    notifyListeners();
  }

  void setIsCeilThousand(bool status) {
    setting.isCeilThousand = status;
    notifyListeners();
  }

  SettingsFormState({this.setting});
}

class SettingsForm extends StatelessWidget {
  final Setting setting;

  SettingsForm({this.setting});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsFormState(setting: setting),
      builder: (context, _) {
        final state = context.watch<SettingsFormState>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, state.setting),
            ),
          ),
          body: ThemeContainer(
            child: Column(
              children: [
                TextField(
                  controller: TextEditingController(
                    text: state.setting.initialPoint.toString(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'initial point',
                    hintText: 'enter initial point',
                  ),
                  onChanged: (point) {
                    if (point.isEmpty) point = '0';
                    state.setting.initialPoint = int.parse(point);
                  },
                ),
                TextField(
                  controller: TextEditingController(
                    text: state.setting.reachPoint.toString(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'reach point',
                    hintText: 'enter reach point',
                  ),
                  onChanged: (point) {
                    if (point.isEmpty) point = '0';
                    state.setting.reachPoint = int.parse(point);
                  },
                ),
                SwitchListTile(
                  value: state.setting.isFlowEast,
                  onChanged: state.setIsFlowEast,
                  title: Text('流局で親流れ'),
                ),
                SwitchListTile(
                  value: state.setting.isCeilThousand,
                  onChanged: state.setIsCeilThousand,
                  title: Text('1000点未満を切り捨てるか'),
                ),
              ],
            ),
          ),
          resizeToAvoidBottomPadding: false,
        );
      },
    );
  }
}
