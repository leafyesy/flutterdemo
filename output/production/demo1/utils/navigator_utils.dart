import 'package:flutter_demo/github/page/home/home_page.dart';
import 'package:flutter_demo/github/page/login.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class NavigatorUtils {
  static Future<T> showFDialog<T>(
      {@required BuildContext bcontext,
      bool barrierDismissible = true,
      WidgetBuilder builder}) {
    return showDialog(
        context: bcontext,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
            data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .copyWith(textScaleFactor: 1),
            child: new SafeArea(child: builder(bcontext)),
          );
        });
  }

  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }
}
