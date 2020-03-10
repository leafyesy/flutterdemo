import 'package:flutter/material.dart';
import 'demo_basic_widget/WidgetListPage.dart';
import 'RouteConfig.dart';
import 'MainPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      color: Colors.white,
      home: MainPage(),
      routes: RouteConfig().getRouteMap(),
    );
  }
}
