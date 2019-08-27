import 'package:flutter/material.dart';
import 'package:demo1/demo_route/NewRoute.dart';

class OldRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _OldRoute();
  }
}

class _OldRoute extends State<OldRoute> {
  _toNextPage() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new NewRoute();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Old route"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Text("点击这里进入下一个界面"),
            new FlatButton(
                onPressed: _toNextPage(), child: new Text("GO To NEXT"))
          ],
        ),
      ),
    );
  }
}
