import 'package:flutter/material.dart';

class ContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container Demo"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.all(30),
          constraints: BoxConstraints.tightFor(width: 200, height: 200),
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.red, Colors.orange],
                  center: Alignment.topLeft,
                  radius: .98),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 1),
                    blurRadius: 4.0)
              ]),
          transform: Matrix4.rotationZ(.2),
          alignment: Alignment.center,
          child: Text(
            "hello world",
            style: TextStyle(color: Colors.white, fontSize: 40.0),
          ),
        ),
      ),
    );
  }
}
/*
Container({
  this.alignment 
  this.padding 
  Color.color 
  Decoration decoration //背景装饰
  Decoration foregroundDecoration //前景装饰
  double width //宽度
  double height //高度
  BoxConstraints constraints// 容器大小的限制条件
  this.margin 
  this.transform //变换
  this.child

})

容器大小可以通过width/height 进行指定 也可以通过constraints来指定 如果同时存在,width/height优先 
实际上是因为Container内部会通过width/height来生成一个constraints

color和decoration是互斥的,因为指定color时内部会创建一个decoration

 */
