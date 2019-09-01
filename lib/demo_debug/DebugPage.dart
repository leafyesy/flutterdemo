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
                  //debugDumpApp();//断点
                  //debugDumpRenderTree();//渲染层
                  //debugDumpLayerTree();//层

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


 启动时间:

  进入Flutter引擎时.
  展示应用第一帧时.
  初始化Flutter框架时.
  完成Flutter框架初始化时.

 flutter run --trace-startup --profile
  {
  "engineEnterTimestampMicros": 96025565262,
  "timeToFirstFrameMicros": 2171978,
  "timeToFrameworkInitMicros": 514585,
  "timeAfterFrameworkInitMicros": 1657393
  }

  跟踪Dart代码性能:

  Timeline.startSync('interesting function');
  // iWonderHowLongThisTakes();
  Timeline.finishSync();


  应用程序性能图:

  请将MaterialApp构造函数的showPerformanceOverlay参数设置为true


  Material grid:

  MaterialApp 构造函数 有一个debugShowMaterialGrid参数， 当在调试模式设置为true

 */