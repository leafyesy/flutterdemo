import 'package:flutter/material.dart';

class Drag extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DragState();
  }
}

class _DragState extends State<Drag> {
  double _top = 0.0;
  double _left = 0.0;

  void _updatePosition(DragUpdateDetails d) {
    setState(() {
      //这里可以做边界判断
      _left += d.delta.dx;
      _top += d.delta.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            onPanDown: (d) => print("用户手指按下：${d.globalPosition}"),
            onPanUpdate: (d) => _updatePosition(d),
            onPanEnd: (d) => print("用户手指离开:${d.velocity}"),
            child: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(
                "A",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        )
      ],
    );
  }
}
