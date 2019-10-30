import 'package:flutter/material.dart';

class ScaleAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimationRouteState();
  }
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 0.0, end: 400.0).animate(controller);
    animation.addListener(() {
      setState(() => {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("scaleAnimDemo"),
        ),
        body: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 300,
                alignment: Alignment.center,
                color: Colors.grey,
                child: Center(
                  child: Image.asset("images/home_photo_type_1.png",
                      width: animation.value, height: animation.value),
                )
//                Center(
//                  child: Image.asset(
//                    "images/home_photo_type_1.png",
//                    color: Colors.teal,
//                    //width: animation != null ? animation.value : 100,
//                    //height: animation != null ? animation.value : 100,
//                    height: 200,
//                    width: 200,
//                  ),
//                )
                ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _getBtnWidget("点我开始", () {
                    //开始动画
                    debugPrint("点我开始");
                    controller.forward(from: 0);
                  }),
                  _getBtnWidget("点我停止", () {
                    //开始动画
                    debugPrint("点我停止");
                    controller.stop(canceled: false);
                  }),
                ],
              ),
            )
          ],
        ));
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }

  Widget _getBtnWidget(String btnName, GestureTapCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Center(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          btnName,
          style: TextStyle(fontSize: 20, backgroundColor: Colors.orange),
        ),
      )),
    );
  }
}
