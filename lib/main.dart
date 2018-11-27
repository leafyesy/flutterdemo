import 'package:demo1/HomePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return new RandomWords();
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new HomePage(),
    );
  }
}




