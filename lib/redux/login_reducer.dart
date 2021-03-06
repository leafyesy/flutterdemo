import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/base/dao/sql_manager.dart';
import 'package:flutter_demo/base/dao/user_dao.dart';
import 'package:flutter_demo/redux/middleware/epic_store.dart';
import 'package:flutter_demo/utils/common_utils.dart';
import 'package:flutter_demo/utils/navigator_utils.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_demo/base/state/app_state.dart';

final LoginReducer = combineReducers<bool>([
  TypedReducer<bool, LoginSuccessAction>(_loginResult),
  TypedReducer<bool, LogoutAction>(_logoutResult),
]);

bool _loginResult(bool result, LoginSuccessAction action) {
  if (action.success) {
    NavigatorUtils.goHome(action.context);
  }
  return action.success;
}

bool _logoutResult(bool result, LogoutAction action) {
  return true;
}

class LoginSuccessAction {
  final BuildContext context;
  final bool success;

  LoginSuccessAction(this.context, this.success);
}

class LogoutAction {
  final BuildContext context;

  LogoutAction(this.context);
}

class LoginAction {
  final BuildContext context;
  final String username;
  final String password;

  LoginAction(this.context, this.username, this.password);
}

class OAuthAction {
  final BuildContext context;
  final String code;

  OAuthAction(this.context, this.code);
}

class LoginMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    if (action is LogoutAction) {
      UserDao.clearAll(store);
      SqlManager.close();
      NavigatorUtils.goLogin(action.context);
    }
    next(action);
  }
}

Stream<dynamic> loginEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  Stream<dynamic> _loginIn(
      LoginAction action, EpicStore<AppState> store) async* {
    print("loginReducer:start login");
    CommonUtils.showLoadingDialog(action.context);
    var res = await UserDao.login(
        action.username.trim(), action.password.trim(), store);
    Navigator.pop(action.context);
    yield LoginSuccessAction(action.context, (res != null && res.result));
  }

  return actions
      .whereType<LoginAction>()
      .switchMap((action) => _loginIn(action, store));
}

Stream<dynamic> oauthEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  Stream<dynamic> _loginIn(
      OAuthAction action, EpicStore<AppState> store) async* {
    CommonUtils.showLoadingDialog(action.context);
    var res = await UserDao.oauth(action.code, store);
    Navigator.pop(action.context);
    yield LoginSuccessAction(action.context, (res != null && res.result));
  }

  return actions
      .whereType<OAuthAction>()
      .switchMap((action) => _loginIn(action, store));
}
