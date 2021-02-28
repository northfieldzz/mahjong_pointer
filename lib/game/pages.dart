import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_score/score.dart';
import 'package:provider/provider.dart';

import 'center_console.dart';
import 'delivery.dart';
import 'house.dart';
import 'player.dart';
import 'position.dart';
import 'setting.dart';

/// ゲームタイプ
enum GameType {
  /// 東風戦
  One,

  /// 半荘戦
  Half,

  /// 一荘戦
  Full,
}

class GameState extends ChangeNotifier {
  Player playerTop;
  Player playerLeft;
  Player playerRight;
  Player playerBottom;
  final Setting setting;

  Direction direction = Direction.East;
  int rotatedCount;
  int stockPoint;
  int consecutivelyCount;

  GameState({
    this.playerTop,
    this.playerLeft,
    this.playerRight,
    this.playerBottom,
    this.setting,
  }) {
    direction = Direction.East;
    rotatedCount = 0;
    stockPoint = 0;
    consecutivelyCount = 0;
  }

  String get title => '${direction.display}${(rotatedCount + 1).toString()}局';

  String get subtitle => '${consecutivelyCount.toString()}本場';

  List<Player> get players => [
        playerTop,
        playerLeft,
        playerBottom,
        playerRight,
      ];

  void finish({
    Player winner,
    Player loser,
    Score score,
    bool isPicked,
  }) {
    playerTop.registerPoints(
      score: score,
      winner: winner,
      loser: loser,
      isPicked: isPicked,
      stockPoint: stockPoint,
    );
    playerLeft.registerPoints(
      score: score,
      winner: winner,
      loser: loser,
      isPicked: isPicked,
      stockPoint: stockPoint,
    );
    playerBottom.registerPoints(
      score: score,
      winner: winner,
      loser: loser,
      isPicked: isPicked,
      stockPoint: stockPoint,
    );
    playerRight?.registerPoints(
      score: score,
      winner: winner,
      loser: loser,
      isPicked: isPicked,
      stockPoint: stockPoint,
    );
    stockPoint = 0;
    notifyListeners();
  }

  void rotate() {
    var temp = playerRight.direction;
    playerRight.direction = playerBottom.direction;
    playerBottom.direction = playerLeft.direction;
    playerLeft.direction = playerTop.direction;
    playerTop.direction = temp;
    consecutivelyCount = 0;
    notifyListeners();
  }

  void reach(int point) {
    stockPoint += point;
    notifyListeners();
  }

  Player get eastPlayer => players.firstWhere((player) => player.isHost);

  void noMoreReader() {
    consecutivelyCount += 1;
    notifyListeners();
  }
}

/// ゲーム画面
class Game extends StatelessWidget {
  final Player playerTop;
  final Player playerLeft;
  final Player playerBottom;
  final Player playerRight;
  final Setting setting;
  final GameType gameType;

  Game({
    @required this.playerTop,
    @required this.playerLeft,
    @required this.playerBottom,
    this.playerRight,
    @required this.setting,
    this.gameType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10.0,
              left: 10.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Align(
              child: Center(
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (_) => GameState(
                        playerTop: playerTop,
                        playerLeft: playerLeft,
                        playerRight: playerRight,
                        playerBottom: playerBottom,
                        setting: setting,
                      ),
                    ),
                    ChangeNotifierProvider(
                      create: (_) => DragAndDropState(),
                    )
                  ],
                  builder: (context, child) {
                    var gameState = context.watch<GameState>();
                    var dragState = context.watch<DragAndDropState>();
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width,
                          child: Stack(
                            overflow: Overflow.visible,
                            alignment: Alignment.center,
                            children: [
                              RotatedHouse(
                                player: gameState.playerTop,
                                position: Position.Top,
                                isReceive: dragState.isTop,
                                onDragStarted: dragState.dragPlayerTop,
                                onDragEnd: dragState.reset,
                              ),
                              RotatedHouse(
                                player: gameState.playerLeft,
                                position: Position.Left,
                                isReceive: dragState.isLeft,
                                onDragStarted: dragState.dragPlayerLeft,
                                onDragEnd: dragState.reset,
                              ),
                              RotatedHouse(
                                player: gameState.playerBottom,
                                position: Position.Bottom,
                                isReceive: dragState.isBottom,
                                onDragStarted: dragState.dragPlayerBottom,
                                onDragEnd: dragState.reset,
                              ),
                              gameState.playerRight != null
                                  ? RotatedHouse(
                                      player: gameState.playerRight,
                                      position: Position.Right,
                                      isReceive: dragState.isRight,
                                      onDragStarted: dragState.dragPlayerRight,
                                      onDragEnd: dragState.reset,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        CenterConsole(
                          isReceive: dragState.isCenterConsole,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
