import 'package:flutter/material.dart';

class WidgetListPage extends StatelessWidget {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("widget demo"),
      ),
      body: Center(
          child: Scrollbar(
              child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 40),
          child: getTapList(context),
        ),
      ))),
    );
  }

  Column getTapList(BuildContext context) {
    Column tapListWidget = new Column(
      children: <Widget>[
        Tap(
          item: "to Text",
          bgColor: Colors.black12,
          callback: () {
            Navigator.pushNamed(context, "page_widget_text");
          },
        ),
        Tap(
          item: "to Button",
          bgColor: Colors.black26,
          callback: () {
            Navigator.pushNamed(context, "page_widget_button");
          },
        ),
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
        ),
        Tap(
          item: "to single child scroller",
          bgColor: Colors.black45,
          callback: () {
            Navigator.pushNamed(context, "page_scroller_single_child");
          },
        ),
        Tap(
            item: "to ListView",
            bgColor: Colors.black54,
            callback: () {
              Navigator.pushNamed(context, "page_scroller_listview");
            }),
        Tap(
          item: "to infinite",
          bgColor: Colors.black45,
          callback: () {
            Navigator.pushNamed(context, "page_scroller_infinite");
          },
        ),
        Tap(
            item: "to Custom Scroll View",
            bgColor: Colors.black38,
            callback: () {
              Navigator.pushNamed(
                  context, "page_scroller_custom_scroller_view");
            }),
        Tap(
          item: "inherited demo",
          bgColor: Colors.black26,
          callback: () {
            Navigator.pushNamed(context, "page_fun_inherited");
          },
        ),
        Tap(
          item: "Theme Demo",
          bgColor: Colors.black12,
          callback: () {
            Navigator.pushNamed(context, "page_fun_theme");
          },
        ),
        Tap(
          item: "Listener Demo",
          bgColor: Colors.blue,
          callback: () {
            Navigator.pushNamed(context, "page_event_listener");
          },
        ),
        Tap(
          item: "Gesture Demo",
          bgColor: Colors.lightBlue,
          callback: () {
            Navigator.pushNamed(context, "page_event_gesture");
          },
        ),
        Tap(
          item: "Gesture Recognizer Demo",
          bgColor: Colors.red,
          callback: () {
            Navigator.pushNamed(context, "page_event_gesture_recognizer");
          },
        ),
        Tap(
          item: "page_event_gesture_arena_member",
          bgColor: Colors.deepOrange,
          callback: () {
            Navigator.pushNamed(context, "page_event_gesture_arena_member");
          },
        ),
        Tap(
          item: "page event bus",
          bgColor: Colors.green,
          callback: () {
            Navigator.pushNamed(context, "page_event_bus");
          },
        ),
        Tap(
          item: "page notification",
          bgColor: Colors.deepOrange,
          callback: () {
            Navigator.pushNamed(context, "page_notification_demo");
          },
        ),
        Tap(
          item: "page scale anim",
          bgColor: Colors.teal,
          callback: () {
            Navigator.pushNamed(context, "page_scale_anim");
          },
        )
      ],
    );
    return tapListWidget;
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
