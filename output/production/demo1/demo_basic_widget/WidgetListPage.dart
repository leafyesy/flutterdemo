import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:demo1/notification/NotificationTestRoute.dart';

class WidgetListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initTapItemList(context);
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("widget demo"),
      ),
      body: _getListView(context),
    );
  }

  final List<TapItem> tapItemList = List();

  /// 构建数据
  void initTapItemList(BuildContext context) {
    tapItemList.add(new TapItem("to Text", () {
      Navigator.pushNamed(context, "page_widget_text");
    })); //文本显示
    tapItemList.add(TapItem("to Button", () {
      Navigator.pushNamed(context, "page_widget_button");
    })); //按钮
    tapItemList.add(TapItem("to Image", () {
      Navigator.pushNamed(context, "page_widget_image");
    })); //图片
    tapItemList.add(TapItem("to switch / checkbox", () {
      Navigator.pushNamed(context, "page_widget_switch_checkbox");
    })); //开关/复选框
    tapItemList.add(TapItem("to TextField", () {
      Navigator.pushNamed(context, "page_widget_text_field_demo");
    }));
    tapItemList.add(TapItem("to focus", () {
      Navigator.pushNamed(context, "page_widget_focus");
    }));
    tapItemList.add(TapItem("to form", () {
      Navigator.pushNamed(context, "page_widget_form");
    }));
    tapItemList.add(TapItem("to stack", () {
      Navigator.pushNamed(context, "page_widget_stack");
    }));
    tapItemList.add(TapItem("to padding", () {
      Navigator.pushNamed(context, "page_container_padding");
    }));
    tapItemList.add(TapItem("to constraint", () {
      Navigator.pushNamed(context, "page_container_constraint");
    }));
    tapItemList.add(TapItem("to decoration", () {
      Navigator.pushNamed(context, "page_container_decoration");
    }));
    tapItemList.add(TapItem("to transform", () {
      Navigator.pushNamed(context, "page_container_transform");
    }));
    tapItemList.add(TapItem("to Container", () {
      Navigator.pushNamed(context, "page_container_container");
    }));
    tapItemList.add(TapItem("to Scaffold", () {
      Navigator.pushNamed(context, "page_container_scaffold");
    }));
    tapItemList.add(TapItem("to Scaffold2", () {
      Navigator.pushNamed(context, "page_container_scaffold2");
    }));
    tapItemList.add(TapItem("to single child scroller", () {
      Navigator.pushNamed(context, "page_scroller_single_child");
    }));
    tapItemList.add(TapItem("to ListView", () {
      Navigator.pushNamed(context, "page_scroller_listview");
    }));
    tapItemList.add(TapItem("to infinite", () {
      Navigator.pushNamed(context, "page_scroller_infinite");
    }));
    tapItemList.add(TapItem("to Custom Scroll View", () {
      Navigator.pushNamed(context, "page_scroller_custom_scroller_view");
    }));
    tapItemList.add(TapItem("inherited demo", () {
      Navigator.pushNamed(context, "page_fun_inherited");
    }));
    tapItemList.add(TapItem("Theme Demo", () {
      Navigator.pushNamed(context, "page_fun_theme");
    }));
    tapItemList.add(TapItem("Listener Demo", () {
      Navigator.pushNamed(context, "page_event_listener");
    }));
    tapItemList.add(TapItem("Gesture Demo", () {
      Navigator.pushNamed(context, "page_event_gesture");
    }));
    tapItemList.add(TapItem("Gesture Recognizer", () {
      Navigator.pushNamed(context, "page_event_gesture_recognizer");
    }));
    tapItemList.add(TapItem("page_event_gesture_arena_member", () {
      Navigator.pushNamed(context, "page_event_gesture_arena_member");
    }));
    tapItemList.add(TapItem("page event bus", () {
      Navigator.pushNamed(context, "page_event_bus");
    }));
    tapItemList.add(TapItem("page notification", () {
      //Navigator.pushNamed(context, "page_notification_demo");
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
                return new FadeTransition(
                    //使用渐隐渐入过渡,
                    opacity: animation,
                    child: NotificationTestRoute() //路由B
                    );
              }));
    }));
    tapItemList.add(TapItem("page scale anim", () {
      Navigator.pushNamed(context, "page_scale_anim");
    }));
    tapItemList.add(TapItem("page hero anim", () {
      Navigator.pushNamed(context, "page_hero_anim");
    }));
    tapItemList.add(TapItem("page StaggerAnimationRoute", () {
      Navigator.pushNamed(context, "page_stagger_anim");
    }));
    tapItemList.add(TapItem("page Turn", () {
      Navigator.pushNamed(context, "page_turn");
    }));
    tapItemList.add(TapItem("page Custom Painter", () {
      Navigator.pushNamed(context, "page_custom_paint");
    }));
    tapItemList.add(TapItem("page File", () {
      Navigator.pushNamed(context, "page_file");
    }));
    tapItemList.add(TapItem("page_http_test", () {
      Navigator.pushNamed(context, "page_http_test");
    }));
  }

  ListView _getListView(BuildContext context) {
    var listView = ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          var tapItem = tapItemList[index];
          return ListTile(
            title: Text(tapItem.name),
            onTap: tapItem.callback,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 1, color: Colors.grey);
        },
        itemCount: tapItemList.length);
    return listView;
  }
}

class TapItem {
  String name;
  final Color c;
  GestureTapCallback callback;

  TapItem(this.name, this.callback, {this.c = Colors.white});
}
