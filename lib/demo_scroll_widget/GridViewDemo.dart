import 'package:flutter/material.dart';

class GridViewDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return null;
  }

}


/*
Axis scrollDirection = Axis.vertical,
  bool reverse = false,
  ScrollController controller,
  bool primary,
  ScrollPhysics physics,
  bool shrinkWrap = false,
  EdgeInsetsGeometry padding,
  @required SliverGridDelegate gridDelegate, //控制子widget layout的委托
  bool addAutomaticKeepAlives = true,
  bool addRepaintBoundaries = true,
  double cacheExtent,
  List<Widget> children = const <Widget>[],


关注 gridDelegate 参数:

类型是SliverGridDelegate，它的作用是控制GridView子widget如何排列(layout)，
SliverGridDelegate是一个抽象类，定义了GridView Layout相关接口，子类需要通过实现它们来实现具体的布局算法，
Flutter中提供了两个SliverGridDelegate的子类
SliverGridDelegateWithFixedCrossAxisCount
和 SliverGridDelegateWithMaxCrossAxisExtent

SliverGridDelegateWithFixedCrossAxisCount:

SliverGridDelegateWithFixedCrossAxisCount({
  @required double crossAxisCount, //横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了,即ViewPort横轴长度/crossAxisCount。
  double mainAxisSpacing = 0.0,//主轴方向的间距。
  double crossAxisSpacing = 0.0,//横轴方向子元素的间距。
  double childAspectRatio = 1.0,//子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。


})

SliverGridDelegateWithMaxCrossAxisExtent:

SliverGridDelegateWithMaxCrossAxisExtent({
  double maxCrossAxisExtent,
  double mainAxisSpacing = 0.0,
  double crossAxisSpacing = 0.0,
  double childAspectRatio = 1.0,
})





GridView.count{
}
内部使用了SliverGridDelegateWithFixedCrossAxisCount


 */