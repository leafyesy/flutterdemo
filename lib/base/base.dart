import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/base/event/http_error_event.dart';
import 'package:flutter_demo/base/event/event.dart';
import 'package:flutter_demo/base/localization/def_localizations.dart';
import 'package:flutter_demo/base/model/user.dart';
import 'package:flutter_demo/base/net/code.dart';
import 'package:flutter_demo/base/state/app_state.dart';
import 'package:flutter_demo/base/style/ye_style.dart';
import 'package:flutter_demo/utils/common_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

class FlutterReduxApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State {
  final store = new Store<AppState>(appReducer,
      middleware: middleware,
      initialState: new AppState(
          userInfo: User.empty(),
          isLogin: false,
          themeData: CommonUtils.getThemeData(YeColors.primaryDarkValue),
          locale: Locale('zh', 'CH')));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

mixin HttpErrorListener on State<FlutterReduxApp> {
  StreamSubscription stream;

  BuildContext _context;

  @override
  void initState() {
    super.initState();
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        showToast(DefLocalizations.i18n(_context).network_error);
        break;
      case 401:
        showToast(DefLocalizations.i18n(_context).network_error_401);
        break;
      case 403:
        showToast(DefLocalizations.i18n(_context).network_error_403);
        break;
      case 404:
        showToast(DefLocalizations.i18n(_context).network_error_404);
        break;
      case 422:
        showToast(DefLocalizations.i18n(_context).network_error_422);
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        showToast(DefLocalizations.i18n(_context).network_error_timeout);
        break;
      case Code.GITHUB_API_REFUSED:
        //Github API 异常
        showToast(DefLocalizations.i18n(_context).github_refused);
        break;
      default:
        showToast(DefLocalizations.i18n(_context).network_error_unknown +
            " " +
            message);
        break;
    }
  }

  showToast(String message,
      {gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_LONG}) {
    Fluttertoast.showToast(
        msg: message, gravity: gravity, toastLength: toastLength);
  }
}
