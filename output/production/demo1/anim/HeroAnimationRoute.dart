import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:demo1/anim/HeroAnimationRouteB.dart';

class HeroAnimationRoute extends StatelessWidget {
  List<String> dataList = ["hahha", "hehe", "xixi", "heihei"];

  @override
  Widget build(BuildContext context) {
    Divider divider = new Divider(
      height: 1,
      color: Colors.red,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("HeroAnimationRoute"),
      ),
      body: Container(
        child:
        InkWell(
          child: Hero(
              tag: "avatar",
              child: Image.asset("images/home_photo_type_1.png")),
          onTap: () {
            Navigator.push(context, PageRouteBuilder(pageBuilder:
                (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("原图"),
                  ),
                  body: HeroAnimationRouteB(),
                ),
              );
            }));
          },
        ),

//        ListView.separated(
//            itemBuilder: (context, index) => InkWell(
//                  child: Hero(
//                      tag: "avatar" + index.toString(),
//                      child: Image.asset("images/home_photo_type_1.png")),
//                  onTap: () {
//                    Navigator.push(context, PageRouteBuilder(pageBuilder:
//                        (BuildContext context, Animation animation,
//                            Animation secondaryAnimation) {
//                      return FadeTransition(
//                        opacity: animation,
//                        child: Scaffold(
//                          appBar: AppBar(
//                            title: Text("原图"),
//                          ),
//                          body: HeroAnimationRouteB(),
//                        ),
//                      );
//                    }));
//                  },
//                ),
//            separatorBuilder: (context, index) => divider,
//            itemCount: dataList.length),
      ),
    );
  }
}
