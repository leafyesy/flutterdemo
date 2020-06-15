import 'package:flutter/material.dart';
import 'package:flutter_demo/base/base.dart';
import 'package:flutter_demo/github/page/home/home_page.dart';
import 'package:flutter_demo/github/page/login.dart';
import 'package:flutter_demo/github/page/welcome/welcome_page.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(
      BuildContext context, HttpErrorListener l) {
    return {
      WelcomePage.sName: (context) {
        l.setContext(context);
        return WelcomePage();
      },
      HomePage.sName: (context) {
        l.setContext(context);
        return HomePage();
      },
      LoginPage.sName:(context){
        l.setContext(context);
        return LoginPage();
      }
    };
  }
}
