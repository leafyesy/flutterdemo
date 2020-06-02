import 'package:flutter_demo/base/dao/user_dao.dart';
import 'package:flutter_demo/base/model/user.dart';
import 'package:flutter_demo/redux/middleware/epic_store.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_demo/base/state/user_state.dart';

final UserReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateLoaded),
]);

User _updateLoaded(User user, action) {
  user = action.userInfo;
  return user;
}

class UpdateUserAction {
  final User userInfo;

  UpdateUserAction(this.userInfo);
}

class FetchUserAction {}

class UserInfoMiddleware implements MiddlewareClass<UserState> {
  @override
  call(Store<UserState> store, action, next) {
    if (action is UpdateUserAction) {
      print("*****************UserInfoMiddleware******************");
    }
    next(action);
  }
}

Stream<dynamic> userInfoEpic(
    Stream<dynamic> actions, EpicStore<UserState> store) {
  // Use the async* function to make easier
  Stream<dynamic> _loadUserInfo() async* {
    print("*************************");
    var res = await UserDao.getUserInfo(null);
    yield UpdateUserAction(res.data);
  }

  return actions
      .whereType<FetchUserAction>()
      .debounce(((_) => TimerStream(true, const Duration(microseconds: 10))))
      .switchMap((action) => _loadUserInfo());
}
