import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/base/base.dart';
import 'package:flutter_demo/base/page/error_page.dart';
import 'package:flutter_demo/github/base/init.dart';

void main() => runZoned(() {
      ErrorWidget.builder = (FlutterErrorDetails details) {
        Zone.current.handleUncaughtError(details.exception, details.stack);
        return ErrorPage(
            details.exception.toString() + "\n" + details.stack.toString(),
            details);
      };
      runApp(new MyApp());
    }, onError: (Object e, StackTrace s) {
      print(e);
      print(s);
    });

class MyApp extends StatelessWidget {
  MyApp() {
    Init.start();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new FlutterReduxApp(),
    );
  }
}
