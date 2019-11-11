import 'package:flutter/material.dart';

class TransformDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transform Demo"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Container(
            color:Colors.black38,
          child: Transform(
            alignment: Alignment.topRight,
            transform: Matrix4.skewY(0.3),
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.deepOrange,
              child: Text("Decoration Here!!!"),
            ),
          ),
        ),
      ),
    );
  }

}
/*
transform 在绘制widget的时候 添加一个矩阵变换

平移:
Transform.translate(
  offset:Offset(-20,-5),
  child:Text("hello world")
)

旋转:
Transform.rotate(
  angle:math.pi/2,
)

缩放:
Transform.scale(
  scale:1.5,//放大到1.5倍
)

注:transform的变换是在应用的绘制阶段,而不是应用在布局阶段,所以 无论对子widget应用何种变换,
器占用空间的大小和在屏幕上的位置都是固定不变的,这些在布局阶段就确定的


RotatedBox

功能和transform.rotate一样 都可以对子widget进行旋转变换,但是RotatedBox变换是在layout阶段.
会影响widget的位置和大小.


 */