import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base/state/app_state.dart';
import 'package:flutter_demo/base/style/ye_style.dart';
import 'package:flutter_demo/github/res.dart';
import 'package:flutter_demo/utils/navigator_utils.dart';
import 'package:flutter_demo/widget/diff_scale_text.dart';
import 'package:flutter_demo/widget/radius_button.dart';
import 'package:flutter_redux/flutter_redux.dart';

class WelcomePage extends StatefulWidget {
  static final String sName = "";

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  static const String _FIRST_TEXT = "WELCOME TO FLUTTER";

  static const String _SECOND_TEXT = "LET'S GO";

  String text = "-";

  bool isShowEntry = false;

  void _delayChange(String text, int time, afterDelay) {
    Future.delayed(Duration(milliseconds: time), () {
      setState(() {
        this.text = text;
        afterDelay();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _delayChange(_FIRST_TEXT, 2000, () {
      _delayChange(_SECOND_TEXT, 2000, () {
        isShowEntry = true;
      });
    });
  }

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
                    fit: BoxFit.cover, //宽度充满
                    width: width,
                    height: height,
                    image: AssetImage(YeGitRes.welcome)),
                Align(
                  alignment: Alignment(0.0, 0.0),
                  child: DiffScaleText(
                    text: text,
                    textStyle: TextStyle(fontSize: 30),
                  ),
                ),
                new Align(
                  alignment: Alignment.bottomCenter,
                  child: new Container(
                    width: size,
                    height: size,
                    child: new FlareActor("static/file/flare_flutter_logo_.flr",
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fill,
                        animation: "Placeholder"),
                  ),
                ),
                if (isShowEntry) getEntryButton()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getEntryButton() {
    return Align(
        alignment: Alignment(0, 0.9),
        child: GestureDetector(
          onTap: () {
            //进入home
            NavigatorUtils.goLogin(context);
            //NavigatorUtils.goHome(context);
          },
          child: RadiusButton(Colors.orange, 150, 60, 30, text: "ENTRY"),
        ));
  }
}
