import 'package:flutter/material.dart';
import 'package:demo1/event/EventBus.dart';

class EventBusDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EventBusDemoState();
  }
}

class _EventBusDemoState extends State<EventBusDemo> {
  final String _eventFirstName = "first_name";

  EventCallback firstClickCallback = (arg) {
    print("bus on:" + arg);
  };

  @override
  void initState() {
    super.initState();
    debugPrint("initState start");
    bus.on(_eventFirstName, firstClickCallback);
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint("deactivate start");
    bus.off(_eventFirstName);
  }

  void emitFirst() {
    debugPrint("点击了first click start");
    bus.emit(_eventFirstName, "firstClick");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EventBus Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Text("first click"),
            onTap: () => emitFirst(),
          )
        ],
      ),
    );
  }
}
/*
事件总线通常用于Widget之间状态共享，但关于Widget之间状态共享也有一些专门的Package如redux，
这和web框架Vue/React是一致的。通常情况下事件总线是足以满足业务需求的，
如果你决定使用redux的话，一定要想清楚业务是否真的有必要用它，防止“化简为繁”、过度设计。
 */
