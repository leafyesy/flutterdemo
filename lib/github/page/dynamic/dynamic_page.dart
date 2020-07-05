import 'package:flutter/material.dart';

import 'dynamic_bloc.dart';
class DynamicPage extends StatefulWidget{

  DynamicPage({Key key}):super(key:key);

  @override
  State<StatefulWidget> createState()  => _DynamicPageState();

}

class _DynamicPageState extends State<DynamicPage>{
  final DynamicBloc dynamicBloc = DynamicBloc();

  @override
  Widget build(BuildContext context) {
    //return
  }

}
