import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'center_console.dart';
import 'player/house.dart';
import 'player/objects.dart';
import 'player/position.dart';
import 'setting.dart';

/// ゲーム画面
class GamePage extends StatelessWidget {
  final Setting setting;
  final bool isHalf;

  GamePage({@required this.setting, this.isHalf = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          child: Center(
            child: Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width,
                    child: Stack(
                      overflow: Overflow.visible,
                      alignment: Alignment.center,
                      children: [
                        House(
                          player: Player(),
                          direction: PositionDirection.Top,
                        ),
                        House(
                          player: Player(),
                          direction: PositionDirection.Left,
                        ),
                        House(
                          player: Player(),
                          direction: PositionDirection.Right,
                        ),
                        House(
                          player: Player(),
                          direction: PositionDirection.Bottom,
                        ),
                      ],
                    ),
                  ),
                  CenterConsole(),
                ],
              ),
            ),
          ),
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
