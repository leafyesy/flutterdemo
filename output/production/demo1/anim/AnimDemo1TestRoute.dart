import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';

class AnimDemo1TestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimDemo1TestRouteState();
  }
}

class _AnimDemo1TestRouteState extends State<AnimDemo1TestRoute> {
  void initAnim() {
    AnimationController controller =
        AnimationController(vsync: MyTickerProvider());
    final Animation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeOut);
    Animation<int> alpha = new IntTween(begin: 0, end: 255).animate(curve);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anim Demo1"),
      ),
      body: Container(),
    );
  }
}

class MyTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(onTick) {
    return null;
  }
}
