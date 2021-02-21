import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'index.dart';

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
        dividerColor: const Color.fromARGB(255, 74, 150, 127),
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
