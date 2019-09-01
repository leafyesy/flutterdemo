import 'package:flutter/material.dart';

class WidgetListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("widget demo"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Tap(
              item: "to Text",
              bgColor: Colors.black12,
              callback: () {
                Navigator.pushNamed(context, "page_widget_text");
              },
            ),
            new Tap(
              item: "to Button",
              bgColor: Colors.black26,
              callback: () {
                Navigator.pushNamed(context, "page_widget_button");
              },
            ),
            new Tap(
              item: "to Image",
              bgColor: Colors.black38,
              callback: () {
                Navigator.pushNamed(context, "page_widget_image");
              },
            ),
            new Tap(
              item: "to switch / checkbox",
              bgColor: Colors.black45,
              callback: () {
                Navigator.pushNamed(context, "page_widget_switch_checkbox");
              },
            ),
            new Tap(
              item: "to TextField",
              bgColor: Colors.black54,
              callback: () {
                Navigator.pushNamed(context, "page_widget_text_field_demo");
              },
            ),
            new Tap(
              item: "to focus",
              bgColor: Colors.black87,
              callback: () {
                Navigator.pushNamed(context, "page_widget_focus");
              },
            )
          ],
        ),
      ),
    );
  }
}

class Tap extends StatelessWidget {
  final Color bgColor;
  final String item;
  final GestureTapCallback callback;

  Tap({Key key, this.item, this.bgColor, this.callback}) : super(key: key);

  @override
  GestureDetector build(BuildContext context) {
    return new GestureDetector(
        onTap: callback,
        child: new Container(
          color: bgColor,
          width: double.infinity,
          height: 50,
          child: new Center(
              child: new Text(item,
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 32.0, color: Colors.white))),
        ));
  }
}
