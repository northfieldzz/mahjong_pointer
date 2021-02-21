import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'center_console.dart';
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

  Direction direction = Direction.East;
  int rotatedCount;
  int stockPoint;
  int noMoreReaderCount;

  GameState({
    this.playerTop,
    this.playerLeft,
    this.playerRight,
    this.playerBottom,
  }) {
    direction = Direction.East;
    rotatedCount = 0;
    stockPoint = 0;
    noMoreReaderCount = 0;
  }

  String get title => '${direction.display}${(rotatedCount + 1).toString()}局';

  String get subtitle => '${noMoreReaderCount.toString()}本場';
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
                child: ChangeNotifierProvider(
                  create: (_) => GameState(
                    playerTop: playerTop,
                    playerLeft: playerLeft,
                    playerRight: playerRight,
                    playerBottom: playerBottom,
                  ),
                  builder: (context, child) {
                    var state = context.watch<GameState>();
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width,
                          child: Stack(
                            overflow: Overflow.visible,
                            alignment: Alignment.center,
                            children: [
                              House(
                                player: state.playerTop,
                                position: Position.Top,
                              ),
                              House(
                                player: state.playerLeft,
                                position: Position.Left,
                              ),
                              House(
                                player: state.playerBottom,
                                position: Position.Bottom,
                              ),
                              state.playerRight != null
                                  ? House(
                                      player: state.playerRight,
                                      position: Position.Right,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        CenterConsole(),
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

// class PointWidget extends StatelessWidget {
//   final int reachPoint;
//   final double playerSize;
//
//   PointWidget({this.playerSize = 20.0, @required this.reachPoint});
//
//   @override
//   Widget build(BuildContext context) {
//     final gameState = context.watch<GamePageState>();
//     return Container(
//       padding: EdgeInsets.all(playerSize),
//       child: ChangeNotifierProvider(
//         create: (_) => DropTargetState(),
//         builder: (context, child) {
//           final dragState = context.watch<DropTargetState>();
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               HouseWidget(
//                 player: gameState.playerTop,
//                 isReceive: dragState.playerTop,
//                 onDragStarted: dragState.dragPlayerTop,
//                 onDragEnd: (_) => dragState.reset(),
//                 quarterTurns: 2,
//               ),
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: HouseWidget(
//                       player: gameState.playerLeft,
//                       isReceive: dragState.playerLeft,
//                       onDragStarted: dragState.dragPlayerLeft,
//                       onDragEnd: (_) => dragState.reset(),
//                       quarterTurns: 1,
//                     ),
//                   ),
//                   ConstrainedBox(
//                     constraints: BoxConstraints.loose(Size(100.0, 100.0)),
//                     child: dragState.centerConsole
//                         ? CreditorWidget(
//                             child: CustomPaint(
//                               painter: SquarePainter(),
//                               child: Container(),
//                             ),
//                             onAccept: (debtor) async {
//                               if (!debtor.isCall) {
//                                 final isOk = await showDialog<bool>(
//                                   context: context,
//                                   barrierDismissible: false,
//                                   builder: (context) => ConfirmDialog(
//                                     text: 'リーチします？',
//                                   ),
//                                 );
//                                 if (isOk) {
//                                   gameState.reach(reachPoint);
//                                   BoxConstraints.loose(Size(10.0, 10.0));
//                                   debtor.isCall = true;
//                                 }
//                               }
//                             },
//                           )
//                         : DebtorWidget(
//                             child: CustomPaint(
//                               painter: SquarePainter(),
//                               child: Container(),
//                             ),
//                             debtor: Player(),
//                             onDragStarted: dragState.dragCenterConsole,
//                             onDragEnd: (_) => dragState.reset(),
//                             draggingChild: CustomPaint(
//                               painter: SquarePainter(),
//                               child: Container(),
//                             ),
//                           ),
//                   ),
//                   Expanded(
//                     child: HouseWidget(
//                       player: gameState.playerRight,
//                       isReceive: dragState.playerRight,
//                       onDragStarted: dragState.dragPlayerRight,
//                       onDragEnd: (_) => dragState.reset(),
//                       quarterTurns: 3,
//                     ),
//                   )
//                 ],
//               ),
//               HouseWidget(
//                 player: gameState.playerBottom,
//                 isReceive: dragState.playerBottom,
//                 onDragStarted: dragState.dragPlayerBottom,
//                 onDragEnd: (_) => dragState.reset(),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// class HouseWidget extends StatelessWidget {
//   final Player player;
//   final bool isReceive;
//   final VoidCallback onDragStarted;
//   final Function(Player) onDragEnd;
//   final int quarterTurns;
//
//   HouseWidget({
//     @required this.player,
//     this.isReceive = false,
//     @required this.onDragStarted,
//     @required this.onDragEnd,
//     this.quarterTurns = 0,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final gameState = context.watch<GamePageState>();
//     return RotatedBox(
//       quarterTurns: quarterTurns,
//       child: Column(
//         children: <Widget>[
//           Text('${player.direction.display}家'),
//           Text(player.name),
//           Container(
//             color: player.isCall ? Colors.green : Colors.white,
//             child: isReceive
//                 ? CreditorWidget(
//                     child: Icon(Icons.face_retouching_natural, size: 60),
//                     onAccept: (debtor) async {
//                       // 点数計算
//                       final score = await Navigator.push<Score>(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PointSelector(
//                             isHost: player.isHost,
//                             isPicked: debtor.isPicked,
//                             noMoreReaderCount: gameState.noMoreReaderCount,
//                           ),
//                         ),
//                       );
//                       if (score == null) {
//                         return null;
//                       }
//                       gameState.finish(
//                         winner: player,
//                         loser: debtor,
//                         score: score,
//                         isPicked: debtor.isPicked,
//                       );
//                       if (player != gameState.eastPlayer) {
//                         gameState.rotate();
//                       } else {
//                         gameState.noMoreReader();
//                       }
//                     },
//                   )
//                 : DebtorWidget(
//                     debtor: player,
//                     child: Icon(Icons.person_sharp, size: 60),
//                     onDragStarted: onDragStarted,
//                     onDragEnd: onDragEnd,
//                   ),
//           ),
//           Text(player.point.toString()),
//         ],
//       ),
//     );
//   }
// }

class SquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green;
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
