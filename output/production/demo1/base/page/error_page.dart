import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base/net/interceptors/logs_interceptor.dart';
import 'package:flutter_demo/base/style/ye_style.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorPage extends StatefulWidget {
  final String errorMessage;
  final FlutterErrorDetails details;

  ErrorPage(this.errorMessage, this.details);

  @override
  State<StatefulWidget> createState() {
    return _ErrorPageState();
  }
}

class _ErrorPageState extends State<ErrorPage> {
  static List<Map<String, dynamic>> sErrorStack = new List();
  static List<String> sErrorName = new List();

  final TextEditingController textEditingController =
      new TextEditingController();

  addError(FlutterErrorDetails details) {
    try {
      var map = Map<String, dynamic>();
      map['error'] = details.toString();
      LogsInterceptor.addLogic(
          sErrorName, details.exception.runtimeType.toString());
      LogsInterceptor.addLogic(sErrorName, map);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; //屏幕宽度
    return Container(
      color: YeColors.primaryValue,
      child: new Center(
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: width,
          decoration: new BoxDecoration(
            color: Colors.white.withAlpha(30),
            gradient:
                RadialGradient(tileMode: TileMode.mirror, radius: 0.1, colors: [
              Colors.white.withAlpha(10),
              YeColors.primaryValue.withAlpha(100),
            ]),
            borderRadius: BorderRadius.all(Radius.circular(width / 2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new SizedBox(
                height: 11,
              ),
              Material(
                child: Text(
                  "Error...",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                color: YeColors.primaryValue,
              ),
              new SizedBox(
                height: 40,
              ),
              new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new FlatButton(
                      color: YeColors.white,
                      onPressed: () {
                        _press();
                      },
                      child: Text("Report"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _press() {
    String content = widget.errorMessage;
    textEditingController.text = content;

    ///开始把错误上报
    Fluttertoast.showToast(msg: "错误上报");
  }
}
