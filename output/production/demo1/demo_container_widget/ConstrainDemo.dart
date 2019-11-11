import 'package:flutter/material.dart';

class ConstraintDemo extends StatelessWidget {
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Constraint Demo"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            ConstrainedBox(
//              constraints: BoxConstraints.tightFor(width: 80.0, height: 80.0),
//              child: ConstrainedBox(
//                constraints: BoxConstraints.tightFor(width: 40, height: 160.0),
//                child: Container(
//                  color: Colors.red,
//                ),
//              ),
//            )
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 60, minWidth: 60),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
                child: redBox,
              ),
            )
          ],
        ));
  }
}

/*
ConstrainedBox 对子Widget进行额外的约束

属性:

constraint:BoxConstraints{
  minWidth 最小宽度
  minHeight 最小高度
  maxWidth 最大宽度
  maxHeight 最大高度


}

注:其中使用double.infinity 表示使用能使用的最大

SizedBox{
  width 宽度
  height 高度
}

多重限制

对于多重限制来说:minWidth和minHeight 取父子中相对应的较大的.实际上这样才能保证父限制和子限制不冲突

UnconstrainedBox

不对子Widget进行任何限制 一般很少用 帮助widget进行本身的大小的显示的时候使用,可以做到去除多重限制带来的问题





 */
