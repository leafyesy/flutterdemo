import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'demo_route/NewRoute.dart';
import 'demo_debug/DebugPage.dart';
import 'demo_basic_widget/ParentWidgetC.dart';
import 'demo_basic_widget/TextDemo.dart';
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
import 'demo_scroll_widget/SingleChildScrollViewDemo.dart';
import 'demo_scroll_widget/ListViewDemo.dart';
import 'demo_scroll_widget/InfiniteListView.dart';
import 'demo_scroll_widget/CustomScrollViewDemo.dart';

import 'demo_function_widget/InheritedWidgetDemo.dart';
import 'demo_function_widget/ThemeDemo.dart';
import 'event/ListenerDemo.dart';
import 'event/GestureDetectorTestRoute.dart';
import 'event/GestureRecognizerTestRoute.dart';
import 'event/GestureArenaMemberTestRoute.dart';
import 'event/EventBusDemo.dart';

import 'notification/NotificationTestRoute.dart';
import 'anim/ScaleAnimationRoute.dart';
import 'anim/HeroAnimationRoute.dart';
import 'anim/StaggerAnimationRoute.dart';

import 'demo_custom_widget/TurnBoxRoute.dart';
import 'demo_custom_widget/CustomPaintRoute.dart';

import 'demo_file/FileOperationRoute.dart';
import 'demo_http/HttpTestRoute.dart';
import 'demo_basic_widget/WidgetListPage.dart';

class RouteConfig {
  Map<String, WidgetBuilder> routeMap = new Map();

  Map<String, WidgetBuilder> getRouteMap() {
    return {
      //基础组件和基础功能
      "base_fun": (context) => WidgetListPage(),
      "new_route": (context) => NewRoute(),
      "page_debug": (context) => DebugPage(),
      "page_widget_text": (context) => TextDemo(),
      "page_widget_parent_widget_c": (context) => ParentWidgetC(),
      "page_widget_button": (context) => ButtonDemo(),
      "page_widget_image": (context) => ImageDemo(),
      "page_widget_switch_checkbox": (context) => SwitchAndCheckBoxTestRoute(),
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
      "page_scroller_single_child": (context) => SingleChildScrollViewDemo(),
      "page_scroller_listview": (context) => ListViewDemo(),
      "page_scroller_infinite": (context) => InfiniteListView(),
      "page_scroller_custom_scroller_view": (context) => CustomScrollViewDemo(),
      "page_fun_inherited": (context) => InheritedWidgetTestRoute(),
      "page_fun_theme": (context) => ThemeDemo(),
      "page_event_listener": (context) => ListenerDemo(),
      "page_event_gesture": (context) => GestureDetectorTestRoute(),
      "page_event_gesture_recognizer": (context) =>
          GestureRecognizerTestRoute(),
      "page_event_gesture_arena_member": (context) =>
          GestureArenaMemberTestRoute(),
      "page_event_bus": (context) => EventBusDemo(),
      "page_notification_demo": (context) => NotificationTestRoute(),
      "page_scale_anim": (context) => ScaleAnimationRoute(),
      "page_hero_anim": (context) => HeroAnimationRoute(),
      "page_stagger_anim": (context) => StaggerAnimationRoute(),
      "page_turn": (context) => TurnBoxRoute(),
      "page_custom_paint": (context) => CustomPaintRoute(),
      "page_file": (context) => FileOperationRoute(),
      "page_http_test": (context) => HttpTestRoute(),
      //---------------基础组件和基础功能
      "id_photo": (context) => HomePage(),
    };
  }
}
