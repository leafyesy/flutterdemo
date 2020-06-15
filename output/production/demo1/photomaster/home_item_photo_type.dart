import 'package:flutter/material.dart';

class HomeItemPhotoType extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Item();
  }
}

class Item extends State<HomeItemPhotoType> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Image.asset('images/home_photo_type_1.png'),
        new Text('1cun')
      ],
    );
  }
}
