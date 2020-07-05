import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String sName = "home";

  @override
  State<StatefulWidget> createState() => _HomePageStatus();
}

class _HomePageStatus extends State<HomePage> {

  final GlobalKey<DynamicPageState> dynamicKey = new GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Text("home");
  }
}
