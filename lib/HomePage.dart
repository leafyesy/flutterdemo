import 'package:demo1/HomeItemPhotoType.dart';
import 'package:demo1/PageDemo2.dart';
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
        verticalDirection: VerticalDirection.down,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildGridViewExtent(),
          new Container(
              color: Color.fromARGB(255, 33, 33, 33),
              height: 100.0,
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: new PageDemo2()),
//          new PagerDemo()
        ],
      ));

  Widget _buildGridViewExtent() {
    return new GridView.extent(
        //for usable to column
        controller: ScrollController(keepScrollOffset: false),
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
