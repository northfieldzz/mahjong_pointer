import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


import 'game/pages.dart';
import 'game/setting/pages.dart';
import 'state.dart';
import 'tembow.dart';
import 'widgets.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Tembow(),
            ThemeContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GameTitleWidget(),
                  GameWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: NetworkImage(
          'https://4.bp.blogspot.com/-hlZSdtrebeU/WQA-FXkdZ5I/AAAAAAABD5A/Z9MR7EaB-48uJplYBSEOKrUmo-LN6cP6QCLcB/s800/ma-jan_ojisan.png',
        ),
      ),
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
            IndexRaisedButton(
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
            IndexRaisedButton(
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
            IndexRaisedButton(
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
            IndexRaisedButton(
              child: Text('Tutorial'),
              onPressed: () async {
                if (await canLaunch("https://www.youtube.com/watch?v=C4YfppkXhfM")) {
                  await launch("https://www.youtube.com/watch?v=C4YfppkXhfM");
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class IndexRaisedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  IndexRaisedButton({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 300.0,
      child: RaisedButton(
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
