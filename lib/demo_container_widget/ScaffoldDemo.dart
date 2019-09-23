import 'package:flutter/material.dart';

class ScaffoldDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaffoldDemoState();
  }
}

class _ScaffoldDemoState extends State<ScaffoldDemo> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scaffold Demo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text("Business")),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text("School")),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAdd,
        child: Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.topLeft,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
}


/*
AppBar

this.leading //导航栏最左边widget 常见位抽屉或者返回按钮
this.automaticallyImplyLeading = true;//如果leading为null 是否自动实现默认的leading按钮
this.title //标题
this.actions //导航栏右侧菜单
this.bottom//导航栏底部菜单,通常为tab按钮
this.elevation = 4.0 //导航栏阴影
this.centerTitle //标题是否居中
this.backgroundColor


关于左侧菜单

打开抽屉的方法在ScaffoldState中,通过Scaffold.of(context)可以获取父级最近的scaffold widget的State对象
.原理可以参考后续的Element和BuildContext.

Flutter还有一种通用的获取StatefullWidget对象的state方法:通过Globalkey 来获取

方法:
```
1.给目标StatefulWidget添加GrobalKey

static GlobalKey<ScaffoldState> _globalKey = new GlobalKey( ;

Scaffold(
  key:_globalKey,
)

2. 通过globalKey来获取state对象
_globalKey.currentState.openDrawer()



TabBar



```












 */