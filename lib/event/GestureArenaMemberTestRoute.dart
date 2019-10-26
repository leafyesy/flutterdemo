import 'package:flutter/material.dart';

class GestureArenaMemberTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GestureArenaMemberTestRouteState();
  }
}

/*
每次拖动只会沿一个方向移动（水平或垂直），而竞争发生在手指按下后首次移动（move）时，
此例中具体的“获胜”条件是：首次移动时的位移在水平和垂直方向上的分量大的一个获胜。
 */
class _GestureArenaMemberTestRouteState
    extends State<GestureArenaMemberTestRoute> {
  double _top = 100.0;
  double _left = 100.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //垂直方向拖动事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        )
      ],
    );
  }
}
/*
手势冲突只是手势级别的，而手势是对原始指针的语义化的识别，所以在遇到复杂的冲突场景时，都可以通过Listener直接识别原始指针事件来解决冲突。
 */