import 'package:flutter/material.dart';

class WillPopScopeDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WillPopScopeDemoState();
  }
}

class _WillPopScopeDemoState extends State<WillPopScopeDemo> {
  DateTime _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Will Pop Scope"),
        ),
        body: Container(),
      ),
    );
  }
}
