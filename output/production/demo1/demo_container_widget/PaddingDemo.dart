import "package:flutter/material.dart";

class PaddingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("PaddingDemo"),
      ),
      body: new Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 100.0),
                child: Text("left padding"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text("vertical direction padding 8"),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text("padding ltrb"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*

EdgeInsets:


fromLTRB(double left, double top, double right, double bottom)：分别指定四个方向的补白。

all(double value) : 所有方向均使用相同数值的补白。

only({left, top, right ,bottom })：可以设置具体某个方向的补白(可以同时指定多个方向)。

symmetric({ vertical, horizontal })：用于设置对称方向的补白，vertical指top和bottom，horizontal指left和right。

 */
