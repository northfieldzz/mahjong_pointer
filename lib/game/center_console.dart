import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'player/position.dart';

class CenterConsole extends StatelessWidget {
  final double distance;

  CenterConsole({this.distance = 120});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        height: distance,
        width: distance,
        color: Theme.of(context).dividerColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildText(context, '東一局'),
                _buildText(context, '一本場'),
              ],
            ),
            _ReachBar(
              isLit: true,
              direction: PositionDirection.Top,
            ),
            _ReachBar(
              isLit: true,
              direction: PositionDirection.Left,
            ),
            _ReachBar(
              isLit: true,
              direction: PositionDirection.Right,
            ),
            _ReachBar(
              isLit: true,
              direction: PositionDirection.Bottom,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}

class _ReachBar extends StatelessWidget {
  final bool isLit;
  final PositionDirection direction;
  final double height;
  final double width;

  _ReachBar({
    @required this.isLit,
    @required this.direction,
    this.height = 6,
    this.width = 50,
  });

  double get _distance => height * 1.5;

  double get _sideDistance => _distance - width / 2 + height / 2;

  double get _top {
    return direction == PositionDirection.Top ? _distance : null;
  }

  double get _left {
    return direction == PositionDirection.Left ? _sideDistance : null;
  }

  double get _right {
    return direction == PositionDirection.Right ? _sideDistance : null;
  }

  double get _bottom {
    return direction == PositionDirection.Bottom ? _distance : null;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _top,
      left: _left,
      right: _right,
      bottom: _bottom,
      child: Transform.rotate(
        angle: direction.getAngle(),
        child: Container(
          height: height,
          width: width,
          color: isLit
              ? Theme.of(context).accentColor
              : Theme.of(context).dividerColor,
        ),
      ),
    );
  }
}
