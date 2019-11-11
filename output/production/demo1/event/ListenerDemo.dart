import 'package:flutter/material.dart';

class ListenerDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListenerState();
  }
}

class _ListenerState extends State<ListenerDemo> {
  PointerEvent _event;
  String pointerStyle = "no event";

  void _setCurPointerInfo(String style, PointerEvent ev) {
    setState(() {
      pointerStyle = style;
      this._event = ev;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listener Demo"),
      ),
      body: Listener(
        child: Container(
          width: 300.0,
          height: 300.0,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Pointer DX:" +
                    ((_event == null) ? "0" : _event.position.dx.toString()),
              ),
              Text(
                "Pointer DY:" +
                    ((_event == null) ? "0" : _event.position.dy.toString()),
              ),
              Text("Pointer Event Style:$pointerStyle")
            ],
          ),
        ),
        onPointerDown: (ev) => _setCurPointerInfo("onPointerDown", ev),
        onPointerCancel: (ev) => _setCurPointerInfo("onPointerCancel", ev),
        onPointerMove: (ev) => _setCurPointerInfo("onPointerMove", ev),
        onPointerUp: (ev) => _setCurPointerInfo("onPointerUp", ev),
      ),
    );
  }
}

/*
Listener({
  Key key,
  this.onPointerDown, //手指按下回调
  this.onPointerMove, //手指移动回调
  this.onPointerUp,//手指抬起回调
  this.onPointerCancel,//触摸事件取消回调
  this.behavior = HitTestBehavior.deferToChild, //在命中测试期间如何表现
  Widget child
})

PointerEvent:

- position：它是鼠标相对于当对于全局坐标的偏移。
- delta：两次指针移动事件（PointerMoveEvent）的距离。
- pressure：按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，如果手机不支持，则始终为1。
- orientation：指针移动方向，是一个角度值。

behavior:

决定子Widget如何响应命中测试，它的值类型为HitTestBehavior，这是一个枚举类，有三个枚举值：

deferToChild：子widget会一个接一个的进行命中测试，如果子Widget中有测试通过的，则当前Widget通过，
这就意味着，如果指针事件作用于子Widget上时，其父(祖先)Widget也肯定可以收到该事件。

opaque：在命中测试时，将当前Widget当成不透明处理(即使本身是透明的)，最终的效果相当于当前Widget的整个区域都是点击区域。举个例子：

```
Listener(
    child: ConstrainedBox(
        constraints: BoxConstraints.tight(Size(300.0, 150.0)),
        child: Center(child: Text("Box A")),
    ),
    //behavior: HitTestBehavior.opaque,
    onPointerDown: (event) => print("down A")
),
```

上例中，只有点击文本内容区域才会触发点击事件，因为 deferToChild 会去子widget判断是否命中测试，
而该例中子widget就是 Text("Box A") 。
如果我们想让整个300×150的矩形区域都能点击我们可以将behavior设为HitTestBehavior.opaque。
注意，该属性并不能用于在Widget树中拦截（忽略）事件，它只是决定命中测试时的Widget大小。

translucent：当点击Widget透明区域时，可以对自身边界内及底部可视区域都进行命中测试，
这意味着点击顶部widget透明区域时，顶部widget和底部widget都可以接收到事件，例如：
```
Stack(
  children: <Widget>[
    Listener(
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(Size(300.0, 200.0)),
        child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue)),
      ),
      onPointerDown: (event) => print("down0"),
    ),
    Listener(
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(Size(200.0, 100.0)),
        child: Center(child: Text("左上角200*100范围内非文本区域点击")),
      ),
      onPointerDown: (event) => print("down1"),
      //behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
    )
  ],
)
```

上例中，当注释掉最后一行代码后，在左上角200*100范围内非文本区域点击时（顶部Widget透明区域），
控制台只会打印“down0”，也就是说顶部widget没有接收到事件，而只有底部接收到了。
当放开注释后，再点击时顶部和底部都会接收到事件，此时会打印：

down1 / down0

忽略PointerEvent:

假如我们不想让某个子树响应PointerEvent的话，我们可以使用IgnorePointer和AbsorbPointer，
这两个Widget都能阻止子树接收指针事件，不同之处在于AbsorbPointer本身会参与命中测试，而IgnorePointer本身不会参与，
这就意味着AbsorbPointer本身是可以接收指针事件的(但其子树不行)，而IgnorePointer不可以。一个简单的例子如下：

```
Listener(
  child: AbsorbPointer(
    child: Listener(
      child: Container(
        color: Colors.red,
        width: 200.0,
        height: 100.0,
      ),
      onPointerDown: (event)=>print("in"),
    ),
  ),
  onPointerDown: (event)=>print("up"),
)
```
点击Container时，由于它在AbsorbPointer的子树上，所以不会响应指针事件，所以日志不会输出"in"，
但AbsorbPointer本身是可以接收指针事件的，所以会输出"up"。如果将AbsorbPointer换成IgnorePointer，那么两个都不会输出。


 */
