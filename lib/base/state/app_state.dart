import 'package:flutter/material.dart';
import 'package:flutter_demo/base/model/user.dart';
import 'package:flutter_demo/redux/locale_reducer.dart';
import 'package:flutter_demo/redux/login_reducer.dart';
import 'package:flutter_demo/redux/theme_data_reducer.dart';
import 'package:flutter_demo/redux/middleware/epic_middleware.dart';
import 'package:flutter_demo/redux/user_redux.dart';
import 'package:redux/redux.dart';

class AppState {
  User userInfo;

  ThemeData themeData;

  ///语言
  Locale locale;

  ///平台默认语言
  Locale platformLocale;

  bool isLogin;

  AppState({this.userInfo, this.themeData, this.locale, this.isLogin});
}

AppState appReducer(AppState state, action) {
  return AppState(
    userInfo: UserReducer(state.userInfo, action),
    themeData: ThemeDataReducer(state.themeData, action),
    locale: LocaleReducer(state.locale, action),
    isLogin: LoginReducer(state.isLogin, action),
  );
}

final List<Middleware<AppState>> middleware = [
  EpicMiddleware<AppState>(loginEpic),
  EpicMiddleware<AppState>(userInfoEpic),
  EpicMiddleware<AppState>(oauthEpic),
  UserInfoMiddleware(),
  LoginMiddleware(),
];
