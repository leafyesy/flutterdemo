import 'package:flutter/material.dart';

class MyCountHomePage extends StatefulWidget {
  final String title;

  MyCountHomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _MyCountHomePageState();
  }
}

class _MyCountHomePageState extends State<MyCountHomePage> {
  int _counter = 0;

  _increment() {
    setState(() {
      //该方法会通知Flutter框架有数据改变
      //有状态发生了改变，Flutter框架收到通知后，会执行build方法来根据新的状态重新构建界面，
      // Flutter 对此方法做了优化，使重新执行变的很快，所以你可以重新构建任何需要更新的东西，而无需分别去修改各个widget。
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("You have pushed the button this many times:"),
            new Text('$_counter')
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _increment,
        tooltip: "increment",
        child: new Icon(Icons.add),
      ),
    );
  }

  @override
  void didUpdateWidget(MyCountHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);

  }



}

/*
开发思路:
为什么要将build方法放在State中，而不是放在StatefulWidget中？

1. 状态访问不便

试想一下，如果我们的Stateful widget 有很多状态，而每次状态改变都要调用build方法，由于状态是保存在State中的，
如果将build方法放在StatefulWidget中，那么构建时读取状态将会很不方便，试想一下，如果真的将build方法放在StatefulWidget中的话，
由于构建用户界面过程需要依赖State，所以build方法将必须加一个State参数，大概是下面这样：
--------------------------------------------------------------------------------
    Widget build(BuildContext context, State state){
          //state.counter
          ...
    }

--------------------------------------------------------------------------------
这样的话就只能将State的所有状态声明为公开的状态，这样才能在State类外部访问状态，
但将状态设置为公开后，状态将不再具有私密性，这样依赖，对状态的修改将会变的不可控。
将build()方法放在State中的话，构建过程则可以直接访问状态，这样会很方便。

2. 继承StatefulWidget不便

例如，Flutter中有一个动画widget的基类AnimatedWidget，它继承自StatefulWidget类。
AnimatedWidget中引入了一个抽象方法build(BuildContext context)，继承自AnimatedWidget的动画widget都要实现这个build方法。
现在设想一下，如果StatefulWidget 类中已经有了一个build方法，
正如上面所述，此时build方法需要接收一个state对象，这就意味着AnimatedWidget必须将自己的State对象(记为_animatedWidgetState)提供给其子类，
因为子类需要在其build方法中调用父类的build方法，代码可能如下：

--------------------------------------------------------------------------------
class MyAnimationWidget extends AnimatedWidget{
    @override
    Widget build(BuildContext context, State state){
      //由于子类要用到AnimatedWidget的状态对象_animatedWidgetState，
      //所以AnimatedWidget必须通过某种方式将其状态对象_animatedWidgetState
      //暴露给其子类
      super.build(context, _animatedWidgetState)
    }
}
--------------------------------------------------------------------------------
这样很显然是不合理的，因为
 - AnimatedWidget的状态对象是AnimatedWidget内部实现细节，不应该暴露给外部。
 - 如果要将父类状态暴露给子类，那么必须得有一种传递机制，而做这一套传递机制是无意义的，因为父子类之间状态的传递和子类本身逻辑是无关的。

综上所述，可以发现，对于StatefulWidget，将build方法放在State中，可以给开发带来很大的灵活性。

 */
