import 'dart:ui';

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
                  Container(
                    alignment: Alignment.topRight,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: SettingWidget(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: GameTitleWidget(),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: GameWidget()),
                ],
              ),
            ),
          ],
        // backgroundColor: Color(0xFFBEEDED),
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
                  fontFamily: 'Cuprum',
                  fontWeight: FontWeight.bold,
                  fontSize: 80.0,
                  color: Colors.white))
        ),
        Container(
          child: Text('M',
              style: TextStyle(
                  fontFamily: 'Cuprum',
                  fontWeight: FontWeight.bold,
                  fontSize: 80.0,
                  color: Color(0xFF4A967F))),
        ),
        Container(
          child: Text('BOW',
              style: TextStyle(
                  fontFamily: 'Cuprum',
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
      create: (_) => GameWidgetState(),
      builder: (context, child) {
        final state = context.watch<GameWidgetState>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IndexRaisedButton(
              child: Text('1 round', style: TextStyle(color: Color(0xFF4A967F))),
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
              child: Text('Half round', style: TextStyle(color: Color(0xFF4A967F))),
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
            // IndexRaisedButton(
            //   child: Text('Setting'),
            //   onPressed: () async => state.setSetting(
            //     await Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => SettingsPage(state.setting),
            //       ),
            //     ),
            //   ),
            // ),
            IndexRaisedButton(
              color: Colors.white,
              child: Text('Tutorial', style: TextStyle(color: Color(0xFF4A967F))),
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

class IndexRaisedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double width;

  IndexRaisedButton({this.child, this.onPressed, this.color=Colors.white, this.width=200.0});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: color,
      minWidth: width,
      child: RaisedButton(
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
