import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/base/event/http_error_event.dart';
import 'package:flutter_demo/base/event/event.dart';
import 'package:flutter_demo/base/localization/def_localizations.dart';
import 'package:flutter_demo/base/localization/ye_localizations_delegate.dart';
import 'package:flutter_demo/base/model/user.dart';
import 'package:flutter_demo/base/net/code.dart';
import 'package:flutter_demo/base/state/app_state.dart';
import 'package:flutter_demo/base/style/ye_style.dart';
import 'package:flutter_demo/github/page/welcome/welcome_page.dart';
import 'package:flutter_demo/github/routes.dart';
import 'package:flutter_demo/utils/common_utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:redux/redux.dart';

class FlutterReduxApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp>
    with HttpErrorListener {
  //创建一个全局使用的store
  final store = new Store<AppState>(appReducer,

      ///中间件 拦截器
      middleware: middleware,

      ///初始化数据
      initialState: new AppState(
          userInfo: User.empty(),
          isLogin: false,
          themeData: CommonUtils.getThemeData(YeColors.primaryDarkValue),
          locale: Locale('zh', 'CH')));

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: new StoreBuilder<AppState>(builder: (context, store) {
        store.state.platformLocale = WidgetsBinding.instance.window.locale;
        return new MaterialApp(

            ///多语言实现代理
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              YeLocalizationsDelegate.delegate
            ],
            supportedLocales: [
              store.state.locale
            ],
            theme: store.state.themeData,
            routes: Routes.getRoutes(context, this),
            initialRoute: WelcomePage.sName);
      }),
    );
  }
}

mixin HttpErrorListener on State<FlutterReduxApp> {
  StreamSubscription stream;

  BuildContext _context;

  setContext(BuildContext context) {
    this._context = context;
  }

  @override
  void initState() {
    super.initState();
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
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
