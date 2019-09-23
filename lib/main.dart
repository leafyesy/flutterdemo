import 'package:flutter/material.dart';
import 'demo_route/NewRoute.dart';
import 'demo_debug/DebugPage.dart';
import 'demo_basic_widget/ParentWidgetC.dart';
import 'demo_basic_widget/TextDemo.dart';
import 'demo_basic_widget/WidgetListPage.dart';
import 'demo_basic_widget/ButtonDemo.dart';
import 'demo_basic_widget/ImageDemo.dart';
import 'demo_basic_widget/SwitchAndCheckBoxTestRoute.dart';
import 'demo_basic_widget/TextFieldDemo.dart';
import 'demo_basic_widget/FocusTestRoute.dart';
import 'demo_basic_widget/FormDemo.dart';
import 'demo_basic_widget/StackDemo.dart';
import 'demo_container_widget/PaddingDemo.dart';
import 'demo_container_widget/ConstrainDemo.dart';
import 'demo_container_widget/DecorationBoxDemo.dart';
import 'demo_container_widget/TransformDemo.dart';
import 'demo_container_widget/ContainerDemo.dart';
import 'demo_container_widget/ScaffoldDemo.dart';
import 'demo_container_widget/ScaffoldDemo2.dart';

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
        "page_widget_stack": (context) => StackDemo(),
        "page_container_padding": (context) => PaddingDemo(),
        "page_container_constraint": (context) => ConstraintDemo(),
        "page_container_decoration": (context) => DecoratedBoxDemo(),
        "page_container_transform": (context) => TransformDemo(),
        "page_container_container": (context) => ContainerDemo(),
        "page_container_scaffold": (context) => ScaffoldDemo(),
        "page_container_scaffold2": (context) => ScaffoldDemo2(),
      },
    );
  }
}
