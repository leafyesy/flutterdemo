import 'package:flutter/material.dart';
import 'package:flutter_demo/base/anim/animated_background.dart';
import 'package:flutter_demo/widget/particle/particles_widget.dart';

class LoginPage extends StatefulWidget {
  static const sName = "login";

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        //触摸收起键盘
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Stack(children: <Widget>[
            Positioned.fill(child: AnimationBackground()),
            Positioned.fill(child: ParticlesWidget(numberOfParticles:10))
          ]),
        ),
      ),
    );
  }
}
