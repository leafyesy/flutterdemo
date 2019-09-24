import 'package:flutter/material.dart';

class ListViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(color: Colors.green);
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Demo"),
      ),
      body: Center(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return index % 2 == 0 ? divider1 : divider2;
              },
              itemCount: 50)),
    );
  }
}
/*
ListView

构造函数:
ListView({
  //可滚动的Widget的公共参数
  Axis scrollDirection = Axis.vertical
  bool reverse = false //是否翻转
  ScrollController controller //
  bool primary
  ScrollPhysics physics
  EdgeInsetsGeometry Padding
  //ListView构造函数的公共参数
  double itemExtent //该参数如果不为null，则会强制children的"长度"为itemExtent的值；
  //这里的"长度"是指滚动方向上子widget的长度，即如果滚动方向是垂直方向，则itemExtent代表子widget的高度，
  //如果滚动方向为水平方向，则itemExtent代表子widget的长度。
  //在ListView中，指定itemExtent比让子widget自己决定自身长度会更高效，这是因为指定itemExtent后，滚动系统可以提前知道列表的长度，而不是总是动态去计算，尤其是在滚动位置频繁变化时（滚动系统需要频繁去计算列表高度）
  bool shrinkWrap = false //该属性表示是否根据子widget的总长度来设置ListView的长度，默认值为false 。默认情况下，ListView的会在滚动方向尽可能多的占用空间。当ListView在一个无边界(滚动方向上)的容器中时，shrinkWrap必须为true。
  bool addAutomaticKeepAlives = true//属性表示是否将列表项（子widget）包裹在AutomaticKeepAlive widget中；典型地，在一个懒加载列表中，如果将列表项包裹在AutomaticKeepAlive中，在该列表项滑出视口时该列表项不会被GC，它会使用KeepAliveNotification来保存其状态。如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。
  bool addRepaintBoundaries = true//该属性表示是否将列表项（子widget）包裹在RepaintBoundary中。当可滚动widget滚动时，将列表项包裹在RepaintBoundary中可以避免列表项重绘，但是当列表项重绘的开销非常小（如一个颜色块，或者一个较短的文本）时，不添加RepaintBoundary反而会更高效。和addAutomaticKeepAlive一样，如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。
  double cacheExtent
  
  
  List<Widget> children = const <Widget>[],

})

ListView.builder:

ListView.Builder({

  @required IndexedWidgetBuilder itemBuilder,
  //它是列表项的构建器，类型为IndexedWidgetBuilder，返回值为一个widget。当列表滚动到具体的index
  位置时，会调用该构建器构建列表项。
  int itemCount//列表项的数量，如果为null，则为无限列表。

})

ListView.separated:

ListView.separated({
  separatorBuilder//分割器生成器
  
})


 */
