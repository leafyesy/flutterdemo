import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base/state/app_state.dart';
import 'package:flutter_demo/base/style/ye_style.dart';
import 'package:flutter_demo/github/res.dart';
import 'package:flutter_redux/flutter_redux.dart';

class WelcomePage extends StatefulWidget {
  static final String sName = "welcome";

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;
        double size = 200;
        return Material(
          child: new Container(
            color: YeColors.white,
            child: Stack(
              children: <Widget>[
                new Image(
                    fit: BoxFit.cover,//宽度充满
                    width: width,
                    height: height,
                    image: AssetImage(YeGitRes.welcome)),
//                Align(
//                  alignment: Alignment(0.0,0.3),
//                  child: DiffSca,
//                )
              ],
            ),
          ),
        );
      },
    );
  }
}
