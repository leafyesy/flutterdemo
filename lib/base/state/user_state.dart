import 'package:flutter/material.dart';
import 'package:flutter_demo/base/model/user.dart';
import 'package:flutter_demo/redux/locale_reducer.dart';
import 'package:flutter_demo/redux/login_reducer.dart';
import 'package:flutter_demo/redux/theme_data_reducer.dart';
import 'package:flutter_demo/redux/middleware/epic_middleware.dart';
import 'package:flutter_demo/redux/user_redux.dart';
import 'package:redux/redux.dart';

class UserState {
  User userInfo;

  ThemeData themeData;

  ///语言
  Locale locale;

  ///平台默认语言
  Locale platformLocale;

  bool isLogin;

  UserState({this.userInfo, this.themeData, this.locale, this.isLogin});
}

UserState appReducer(UserState state, action) {
  return UserState(
    userInfo: UserReducer(state.userInfo, action),
    themeData: ThemeDataReducer(state.themeData, action),
    locale: LocaleReducer(state.locale, action),
    isLogin: LoginReducer(state.isLogin, action),
  );
}

final List<Middleware<UserState>> middleware = [
  EpicMiddleware<UserState>(loginEpic),
  EpicMiddleware<UserState>(userInfoEpic),
  EpicMiddleware<UserState>(oauthEpic),
  UserInfoMiddleware(),
  LoginMiddleware(),
];
