import 'package:flutter/material.dart';
import 'demo_route/NewRoute.dart';
import 'demo_debug/DebugPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      //home: new HomePage(),
      home: new DebugPage(),
      routes: {
        "new_route": (context) => NewRoute(),
        "page_debug": (context) => DebugPage(),
      },
    );
  }
}
