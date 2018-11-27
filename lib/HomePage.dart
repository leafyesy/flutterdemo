import 'package:demo1/HomeItemPhotoType.dart';
import 'package:demo1/PagerDemo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        title: const Text('ID_PHOTO'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildGridViewExtent(),
          new Text('hhh'),
//          new PagerDemo()
        ],
      ));

  Widget _buildGridViewExtent() {
    return new GridView.extent(
        //for usable to column
        shrinkWrap: true,
        maxCrossAxisExtent: 150.0,
        padding: const EdgeInsets.all(20.0),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        children: <Widget>[
          new HomeItemPhotoType(),
          new HomeItemPhotoType(),
          new HomeItemPhotoType(),
          new HomeItemPhotoType(),
          new HomeItemPhotoType(),
        ]);
  }
}
