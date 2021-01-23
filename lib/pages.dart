import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/pages.dart';
import 'game/setting/pages.dart';
import 'state.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game')),
      body: Container(child: GameWidget()),
    );
  }
}

class GameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameWidgetState(),
      builder: (context, child) {
        final state = context.watch<GameWidgetState>();
        return Column(
          children: [
            RaisedButton(
              child: Text('One Round Game Start'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(
                    setting: state.setting,
                  ),
                ),
              ),
            ),
            RaisedButton(
              child: Text('Half Round Game Start'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(
                    setting: state.setting,
                    isHalf: true,
                  ),
                ),
              ),
            ),
            RaisedButton(
              child: Text('Setting'),
              onPressed: () async => state.setSetting(
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(state.setting),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
