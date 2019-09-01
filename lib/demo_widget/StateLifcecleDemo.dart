import 'package:flutter/material.dart';

class StateLifecycleDemo extends StatefulWidget {
  final int initValue;

  const StateLifecycleDemo({Key key, this.initValue: 0});

  @override
  _StateLifecycleDemoState createState() {
    return _StateLifecycleDemoState();
  }
}

class _StateLifecycleDemoState extends State<StateLifecycleDemo> {
  int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('$_counter'),
          //点击后计数器自增
          onPressed: () => setState(
                () => ++_counter,
              ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(StateLifecycleDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }
  ///当State对象从树中被移除时，会调用此回调。
  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }
  ///当State对象从树中被永久移除时调用；通常在此回调中释放资源。
  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  /// 此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用。
  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}
/*
我们运行应用并打开该路由页面，在新路由页打开后，屏幕中央就会出现一个数字0，然后控制台日志输出：

I/flutter ( 5436): initState
I/flutter ( 5436): didChangeDependencies
I/flutter ( 5436): build

可以看到，在StatefulWidget插入到Widget树时首先initState方法会被调用。

然后我们点击⚡️按钮热重载，控制台输出日志如下：

I/flutter ( 5436): reassemble
I/flutter ( 5436): didUpdateWidget
I/flutter ( 5436): build


可以看到此时initState 和didChangeDependencies都没有被调用，而此时didUpdateWidget被调用。

接下来，我们在widget树中移除CounterWidget，将路由build方法改为：

Widget build(BuildContext context) {
  //移除计数器
  //return CounterWidget();
  //随便返回一个Text()
  return Text("xxx");
}
然后热重载，日志如下：

I/flutter ( 5436): reassemble
I/flutter ( 5436): deactive
I/flutter ( 5436): dispose

我们可以看到，在CounterWidget从widget树中移除时，deactive和dispose会依次被调用。

各个回调函数:

- initState：当Widget第一次插入到Widget树时会被调用，对于每一个State对象，Flutter
framework只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。不能在该回调中调用BuildContext.inheritFromWidgetOfExactType（该方法用于在Widget树上获取离当前widget最近的一个父级InheritFromWidget，关于InheritedWidget我们将在后面章节介绍），原因是在初始化完成后，Widget树中的InheritFromWidget也可能会发生变化，所以正确的做法应该在在build（）方法或didChangeDependencies()中调用它。
- didChangeDependencies()：当State对象的依赖发生变化时会被调用；例如：在之前build()
中包含了一个InheritedWidget，然后在之后的build() 中InheritedWidget发生了变化，那么此时InheritedWidget的子widget的didChangeDependencies()回调都会被调用。典型的场景是当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。
- build()：此回调读者现在应该已经相当熟悉了，它主要是用于构建Widget子树的，会在如下场景被调用：

1. 在调用initState()之后。
2. 在调用didUpdateWidget()之后。
3. 在调用setState()之后。
4. 在调用didChangeDependencies()之后。
5. 在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。
- reassemble()：此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用。
- didUpdateWidget()：在widget重新构建时，Flutter framework会调用Widget
.canUpdate来检测Widget树中同一位置的新旧节点，然后决定是否需要更新，如果Widget.canUpdate返回true则会调用此回调。正如之前所述，Widget.canUpdate会在新旧widget的key和runtimeType同时相等时会返回true，也就是说在在新旧widget的key和runtimeType同时相等时didUpdateWidget()就会被调用。
- deactivate()：当State对象从树中被移除时，会调用此回调。在一些场景下，Flutter
framework会将State对象重新插到树中，如包含此State对象的子树在树的一个位置移动到另一个位置时（可以通过GlobalKey来实现）。如果移除后没有重新插入到树中则紧接着会调用dispose()方法。
- dispose()：当State对象从树中被永久移除时调用；通常在此回调中释放资源。


注意：在继承StatefulWidget重写其方法时，对于包含@mustCallSuper标注的父类方法，都要在子类方法中先调用父类方法。
 */