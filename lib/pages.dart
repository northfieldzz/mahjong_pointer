import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'game/pages.dart';
import 'state.dart';
import 'tembow.dart';
import 'widgets.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Tembow(),
            ThemeContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: SettingWidget(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: GameTitleWidget(),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: GameWidget(),
                    ),
                  ),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            child: Text('TE',
                style: TextStyle(
                    fontFamily: 'Grandstander',
                    fontWeight: FontWeight.bold,
                    fontSize: 80.0,
                    color: Colors.white))),
        Container(
          child: Text('M',
              style: TextStyle(
                  fontFamily: 'Grandstander',
                  fontWeight: FontWeight.bold,
                  fontSize: 80.0,
                  color: Color(0xFF4A967F))),
        ),
        Container(
          child: Text('BOW',
              style: TextStyle(
                  fontFamily: 'Grandstander',
                  fontWeight: FontWeight.bold,
                  fontSize: 80.0,
                  color: Colors.white)),
        ),
      ],
    );
  }
}

class GameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MahjongPointerAppState(),
      builder: (context, child) {
        final state = context.watch<MahjongPointerAppState>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IndexFlatButton(
              child:
                  Text('1 round', style: TextStyle(color: Color(0xFF4A967F))),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(
                    setting: state.setting,
                  ),
                ),
              ),
            ),
            IndexFlatButton(
              child: Text('Half round',
                  style: TextStyle(color: Color(0xFF4A967F))),
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
            IndexFlatButton(
              child:
                  Text('Tutorial', style: TextStyle(color: Color(0xFF4A967F))),
              onPressed: () async {
                if (await canLaunch(
                    "https://www.youtube.com/watch?v=C4YfppkXhfM")) {
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

class SettingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameWidgetState(),
      builder: (context, child) {
        final state = context.watch<GameWidgetState>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.topRight,
              height: MediaQuery.of(context).size.height * 0.1,
              child: IconButton(
                icon: Icon(Icons.settings),
                iconSize: 60,
                color: Color(0xFF4A967F),
                onPressed: () async => state.setSetting(
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(state.setting),
                    ),
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

class IndexFlatButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double width;

  IndexFlatButton({this.child, this.onPressed, this.color, this.width = 200.0});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: this.color != null ? this.color : Theme.of(context).buttonColor,
      child: child,
      onPressed: onPressed,
      minWidth: width,
    );
  }
}
