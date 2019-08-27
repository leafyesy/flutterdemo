import 'package:flutter/material.dart';

class DebugPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DebugPageState();
  }
}

class _DebugPageState extends State<DebugPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("debug title"),
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlatButton(
                onPressed: () {
                  //debugDumpApp();
                  //debugDumpRenderTree();
                  debugDumpLayerTree();
                },
                child: new Text("点我调试"))
          ],
        ),
      ),
    );
  }
}

/*
  当调试布局问题时，关键要看的是size和constraints字段.约束沿着树向下传递，尺寸向上传递。


 */