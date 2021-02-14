import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_control.dart';
import 'logo.dart';
import 'setting.dart';
import 'state.dart';
import 'tembow.dart';
import 'widgets.dart';

void main() => runApp(MahjongPointerApp());

class MahjongPointerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahjong Pointer',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color.fromARGB(255, 190, 237, 237),
        accentColor: const Color.fromARGB(255, 250, 248, 159),
        scaffoldBackgroundColor: const Color.fromARGB(255, 190, 237, 237),
        buttonColor: const Color.fromARGB(255, 255, 255, 255),
        iconTheme: const IconThemeData.fallback().copyWith(
          color: Color.fromARGB(255, 74, 150, 127),
        ),
      ),
      darkTheme: ThemeData.dark(),
      home: IndexPage(),
    );
  }
}

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Tembow(),
            Logo(),
            ThemeContainer(
              child: ChangeNotifierProvider(
                create: (_) => IndexPageState(),
                builder: (context, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: SettingButton(),
                      ),
                      Container(
                        height: 400.0,
                        child: GameControl(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
