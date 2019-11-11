import 'package:flutter/material.dart';

class NotificationTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationTestRouteState();
  }
}

class _NotificationTestRouteState extends State<NotificationTestRoute> {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(
      color: Colors.green,
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Notification Demo"),
        ),
        body: NotificationListener(
          onNotification: (notification) {
            //print(notification);
            switch (notification.runtimeType) {
              case ScrollStartNotification:
                print("开始滚动");
                break;
              case ScrollUpdateNotification:
                print("正在滚动");
                break;
              case ScrollEndNotification:
                print("滚动停止");
                break;
              case OverscrollNotification:
                print("滚动到边界");
                break;
            }
          },
          child: Scrollbar(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int p) =>
                      (p % 2 == 0 ? divider1 : divider2),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("$index"),
                    );
                  })),
        ));
  }
}

/*
Notification是Flutter中一个重要的机制，在Widget树中，每一个节点都可以分发通知，
通知会沿着当前节点（context）向上传递，所有父节点都可以通过NotificationListener来监听通知，
Flutter中称这种通知由子向父的传递为“通知冒泡”（Notification Bubbling），
这个和用户触摸事件冒泡是相似的，但有一点不同：通知冒泡可以中止，但用户触摸事件不行。

Flutter中很多地方使用了通知，如可滚动(Scrollable) Widget中滑动时就会分发ScrollNotification，
而Scrollbar正是通过监听ScrollNotification来确定滚动条位置的。
除了ScrollNotification，Flutter中还有SizeChangedLayoutNotification、KeepAliveNotification 、LayoutChangedNotification等。

自定义通知:

exmaple:
define a notification:
```
class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}
```
distribute notification:

Notification有一个dispatch(context)方法，它是用于分发通知的，
我们说过context实际上就是操作Element的一个接口，它与Element树上的节点是对应的，通知会从context对应的Element节点向上冒泡。

```
class NotificationRoute extends StatefulWidget {
  @override
  NotificationRouteState createState() {
    return new NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationRoute> {
  String _msg="";
  @override
  Widget build(BuildContext context) {
    //监听通知
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg+=notification.msg+"  ";
        });
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//          RaisedButton(
//           onPressed: () => MyNotification("Hi").dispatch(context),
//           child: Text("Send Notification"),
//          ),
            Builder(
              builder: (context) {
                return RaisedButton(
                  //按钮点击时分发通知
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: Text("Send Notification"),
                );
              },
            ),
            Text(_msg)
          ],
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}
```


 */
