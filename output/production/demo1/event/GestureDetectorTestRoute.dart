import 'package:flutter/material.dart';
import 'package:demo1/event/Drag.dart';
import 'package:demo1/event/Scale.dart';

class GestureDetectorTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GestureDetectorTestRouteState();
  }
}

class _GestureDetectorTestRouteState extends State<GestureDetectorTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetector Demo"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: GestureDetector(
                child: Container(
                  width: 200,
                  alignment: Alignment.center,
                  height: 100,
                  color: Colors.lightBlue,
                  child: Text("Gesture Detector Demo"),
                ),
                onTap: () => print("on tap"),
                onDoubleTap: () => print("on double tap"),
                onLongPress: () => debugPrint("on Long Press"),
                onTapDown: (details) => debugPrint("onTapDown"),
              ),
            ),
            Container(
              color: Colors.lightGreenAccent,
              width: double.infinity,
              height: 300,
              child: ScaleTestRoute(),
            )
          ],
        ),
      ),
    );
  }
}
/*

GestureRecognizer:

GestureDetector内部是使用一个或多个GestureRecognizer来识别各种手势的，
而GestureRecognizer的作用就是通过Listener来将原始指针事件转换为语义手势，
GestureDetector直接可以接收一个子Widget。GestureRecognizer是一个抽象类，
一种手势的识别器对应一个GestureRecognizer的子类，Flutter实现了丰富的手势识别器，我们可以直接使用。



 */
