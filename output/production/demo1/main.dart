import 'package:flutter/material.dart';
import 'demo_route/OldRoute.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      //home: new HomePage(),
      home: new OldRoute(),
    );
  }
}
