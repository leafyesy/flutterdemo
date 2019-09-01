import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class TextDemo extends StatelessWidget {
  get _tapRecognizer => new TapGestureRecognizer();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("text demo"),
      ),
      body: new Container(
        width: double.infinity,
        color: Colors.black12,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text(
              "this is a Text",
              textAlign: TextAlign.left,
              style: new TextStyle(fontSize: 40, backgroundColor: Colors.blue),
            ),
            new Text(
              "TextAlign.center",
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
            ),
            new Text(
              "this is loooooog text." * 4,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(text: "Home: "),
              TextSpan(
                  text: "https://flutterchina.club",
                  style: TextStyle(color: Colors.blue),
                  recognizer: _tapRecognizer),
            ])),
            DefaultTextStyle(
              //1.设置文本默认样式
              style: TextStyle(
                color: Colors.red,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.start,
              child: Column(
                verticalDirection: VerticalDirection.up,//竖直排布方向
                textDirection: TextDirection.rtl,//文字排布方向
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("hello world"),
                  Text("I am Jack"),
                  Text(
                    "I am Jack",
                    style: TextStyle(
                        inherit: false, //2.不继承默认样式
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
