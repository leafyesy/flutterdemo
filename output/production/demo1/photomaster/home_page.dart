import 'package:flutter/material.dart';
import 'home_item_photo_type.dart';
import 'page_demo2.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State {
  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        title: Text('ID_PHOTO'),
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

  //获取头部总的图标的个数
  List<Widget> getHomeItemList() {
    return <Widget>[
      new HomeItemPhotoType(),
      new HomeItemPhotoType(),
      new HomeItemPhotoType(),
      new HomeItemPhotoType(),
      new HomeItemPhotoType(),
      new HomeItemPhotoType()
    ];
  }

  Widget _buildGridViewExtent() {
    return new GridView.extent(
        //for usable to column
        controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        maxCrossAxisExtent: 150.0,
        padding: const EdgeInsets.all(20.0),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        children: getHomeItemList());
  }
}
