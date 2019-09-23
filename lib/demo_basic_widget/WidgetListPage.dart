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
//            Tap(
//              item: "to Text",
//              bgColor: Colors.black12,
//              callback: () {
//                Navigator.pushNamed(context, "page_widget_text");
//              },
//            ),
//            Tap(
//              item: "to Button",
//              bgColor: Colors.black26,
//              callback: () {
//                Navigator.pushNamed(context, "page_widget_button");
//              },
//            ),
            Tap(
              item: "to Image",
              bgColor: Colors.black38,
              callback: () {
                Navigator.pushNamed(context, "page_widget_image");
              },
            ),
            Tap(
              item: "to switch / checkbox",
              bgColor: Colors.black45,
              callback: () {
                Navigator.pushNamed(context, "page_widget_switch_checkbox");
              },
            ),
            Tap(
              item: "to TextField",
              bgColor: Colors.black54,
              callback: () {
                Navigator.pushNamed(context, "page_widget_text_field_demo");
              },
            ),
            Tap(
              item: "to focus",
              bgColor: Colors.black87,
              callback: () {
                Navigator.pushNamed(context, "page_widget_focus");
              },
            ),
            Tap(
              item: "to form",
              bgColor: Colors.black54,
              callback: () {
                Navigator.pushNamed(context, "page_widget_form");
              },
            ),
            Tap(
              item: "to stack",
              bgColor: Colors.black87,
              callback: () {
                Navigator.pushNamed(context, "page_widget_stack");
              },
            ),
            Tap(
              item: "to padding",
              bgColor: Colors.black54,
              callback: () {
                Navigator.pushNamed(context, "page_container_padding");
              },
            ),
            Tap(
              item: "to constraint",
              bgColor: Colors.black45,
              callback: () {
                Navigator.pushNamed(context, "page_container_constraint");
              },
            ),
            Tap(
              item: "to decoration",
              bgColor: Colors.black38,
              callback: () {
                Navigator.pushNamed(context, "page_container_decoration");
              },
            ),
            Tap(
                item: "to transform",
                bgColor: Colors.black26,
                callback: () {
                  Navigator.pushNamed(context, "page_container_transform");
                }),
            Tap(
              item: "to Container",
              bgColor: Colors.black12,
              callback: () {
                Navigator.pushNamed(context, "page_container_container");
              },
            ),
            Tap(
              item: "to Scaffold",
              bgColor: Colors.black26,
              callback: () {
                Navigator.pushNamed(context, "page_container_scaffold");
              },
            ),
            Tap(
              item: "to Scaffold2",
              bgColor: Colors.black38,
              callback: () {
                Navigator.pushNamed(context, "page_container_scaffold2");
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
