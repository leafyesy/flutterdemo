import 'package:flutter/material.dart';

class DecoratedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("DecoratedBox"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DecoratedBox(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "LOGIN",
                style: TextStyle(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.red, Colors.orange[700]]),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                  )
                ]),
          )
        ],
      ),
    );
  }
}

/*
DecoratedBox 添加装饰使用 如背景/边框/渐变等

DecoratedBox{
  decoration 表示要绘制的装饰
  position 决定在哪里绘制 DecorationPosition枚举类型 background 背景 foreground 前景


}

BoxDecoration

实现了常用的装饰元素绘制

Color color 颜色
DecorationImage image
BoxBorder border //边框
List<BoxShadow> boxShadow //阴影
BorderRadiusGeometry borderRadius //圆角
Gradient gradient //渐变
BlendMode backgroundBlenMode //背景混合模式
BoxShape shape = BoxShare.rectangle //形状




 */
