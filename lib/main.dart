import 'package:flutter/material.dart';
import 'demo_route/NewRoute.dart';
import 'demo_debug/DebugPage.dart';
import 'demo_widget/ParentWidgetC.dart';
import 'demo_widget/TextDemo.dart';
import 'demo_widget/WidgetListPage.dart';
import 'demo_widget/ButtonDemo.dart';
import 'demo_widget/ImageDemo.dart';
import 'demo_widget/SwitchAndCheckBoxTestRoute.dart';
import 'demo_widget/TextFieldDemo.dart';
import 'demo_widget/FocusTestRoute.dart';
import 'demo_widget/FormDemo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new WidgetListPage(),
      routes: {
        "new_route": (context) => NewRoute(),
        "page_debug": (context) => DebugPage(),
        "page_widget_text": (context) => TextDemo(),
        "page_widget_parent_widget_c": (context) => ParentWidgetC(),
        "page_widget_button": (context) => ButtonDemo(),
        "page_widget_image": (context) => ImageDemo(),
        "page_widget_switch_checkbox": (context) =>
            SwitchAndCheckBoxTestRoute(),
        "page_widget_text_field_demo": (context) => TextFieldDemo(),
        "page_widget_focus": (context) => FocusTestRoute(),
        "page_widget_form": (context) => FormDemo(),
      },
    );
  }
}
