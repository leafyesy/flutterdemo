import 'package:flutter/material.dart';

class OldRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _OldRoute();
  }
}

class _OldRoute extends State<OldRoute> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Old route"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("点击这里进入下一个界面"),
            new FlatButton(
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.pushNamed(context, "new_route");
//                  Navigator.push(context,
//                      new MaterialPageRoute(builder: (context) {
//                    return new NewRoute();
//                  }));
                },
                child: new Text("GO To NEXT"))
          ],
        ),
      ),
    );
  }
}

/*
-->MaterialPageRoute<--

MaterialPageRoute继承自PageRoute类，PageRoute类是一个抽象类，表示占有整个屏幕空间的一个模态路由页面，它还定义了路由构建及切换时过渡动画的相关接口及属性。
MaterialPageRoute 是Material组件库的一个Widget，它可以针对不同平台，实现与平台页面切换动画风格一致的路由切换动画：

MaterialPageRoute({
    WidgetBuilder builder,//一个WidgetBuilder类型的回调函数，它的作用是构建路由页面的具体内容，返回值是一个widget。我们通常要实现此回调，返回新路由的实例
    RouteSettings settings,//包含路由的配置信息，如路由名称、是否初始路由（首页）。
    bool maintainState = true,//默认情况下，当入栈一个新路由时，原来的路由仍然会被保存在内存中，
    如果想在路由没用的时候释放其所占用的所有资源，可以设置maintainState为false。
    bool fullscreenDialog = false,//表示新的路由页面是否是一个全屏的模态对话框，
    在iOS中，如果fullscreenDialog为true，新页面将会从屏幕底部滑入（而不是水平方向）。
  })


-->Navigator<--
一个路由管理的widget，它通过一个栈来管理一个路由widget集合。通常当前屏幕显示的页面就是栈顶的路由。Navigator提供了一系列方法来管理路由栈

常用:
Future push(BuildContext context, Route route)
将给定的路由入栈（即打开新的页面），返回值是一个Future对象，用以接收新路由出栈（即关闭）时的返回数据。

bool pop(BuildContext context, [ result ])
将栈顶路由出栈，result为页面关闭时返回给上一个页面的数据。

命名路由:所谓命名路由（Named Route）即给路由起一个名字，然后可以通过路由名字直接打开新的路由。这为路由管理带来了一种直观、简单的方式

路由表:
要想使用命名路由，我们必须先提供并注册一个路由表（routing table），这样应用程序才知道哪个名称与哪个路由Widget对应。路由表的定义如下：
```
Map<String, WidgetBuilder> routes;
```
它是一个Map， key 为路由的名称，是个字符串；value是个builder回调函数，用于生成相应的路由Widget。
我们在通过路由名称入栈新路由时，应用会根据路由名称在路由表中找到对应的WidgetBuilder回调函数，然后调用该回调函数生成路由widget并返回。

注册路由表:
我们需要先注册路由表后，我们的Flutter应用才能正确处理命名路由的跳转。
注册方式很简单，我们回到之前“计数器”的示例，然后在MyApp类的build方法中找到MaterialApp，添加routes属性，代码如下

通过路由名打开新路由页:
```
Future pushNamed(BuildContext context, String routeName,{Object arguments})
```

-->命名路由参数<---

我们先注册一个路由：
```
routes:{
   "new_page":(context)=>EchoRoute(),
  } ,
```
在路由页通过RouteSetting对象获取路由参数：

```
class EchoRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var args=ModalRoute.of(context).settings.arguments
    //...省略无关代码
  }
}
```
打开路由时传递参数
```
Navigator.of(context).pushNamed("new_page", arguments: "hi");
```



 */
