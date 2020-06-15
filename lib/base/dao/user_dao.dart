import 'package:flutter/material.dart';
import 'package:flutter_demo/base/config.dart';
import 'package:flutter_demo/base/net_config.dart';
import 'package:flutter_demo/base/dao/data_result.dart';
import 'package:flutter_demo/base/local/local_storage.dart';
import 'package:flutter_demo/base/net/http_manager.dart';
import 'package:flutter_demo/redux/user_redux.dart';
import 'package:redux/redux.dart';

class UserDao {
  static oauth(code, store) async {
    httpManager.clearAuthorization();
    var res = await httpManager.fetchData(
        "https://github.com/login/oauth/access_token?"
        "client_id=${NetConfig.CLIENT_ID}"
        "&client_secret=${NetConfig.CLIENT_SECRET}"
        "&code=$code",
        null,
        null,
        null);
    var resultData = null;
    if (res != null && res.result) {
      print("****${res.data}***");
      var result = Uri.parse("gsy://oauth?${res.data}");
      var token = result.queryParameters['access_token'];
      var _token = "token$token";
      await LocalStorage.putString(Config.TOKEN_KEY, _token);
      var resultData = await getUserInfo(null);
      if (Config.DEBUG) {
        print("user result:${resultData.result.toString()}");
        print(resultData);
        print(res.data.toString());
      }
      store.dispatch(new UpdateUserAction(resultData.data));
    }
    return new DataResult(resultData, res.result);
    //return UnimplementedError("");
  }

  ///获取用户详细信息
  static getUserInfo(userName, {needDb = false}) async {
    return UnimplementedError("");
  }

  ///获取本地登录用户信息
  static getUserInfoLocal() async {
    return UnimplementedError();
  }

  ///登录
  static login(userName, password, store) async {
    return UnimplementedError("");
  }

  ///初始化信息
  static initUserInfo(Store store) {
    return UnimplementedError("");
  }

  ///清除所有数据
  static clearAll(Store store) {
    return UnimplementedError("");
  }

  ///在header中提取stared count
  static getUserStaredCountNet(userName) async {
    return UnimplementedError("");
  }

  ///获取粉丝列表
  static getFollowerListDao(userName, page, {needDb = false}) async {
    return UnimplementedError("");
  }

  ///获取关注列表
  static getFollowedListDao(userName, page, {needDb = false}) async {
    return UnimplementedError();
  }

  ///获取用户相关通知
  static getNotifyDao(bool all, bool participating, page) async {
    return UnimplementedError();
  }

  ///设置单个通知已读
  static setNotificationAsReadDao(id) async {
    return UnimplementedError();
  }

  ///设置所有通知已读
  static setAllNotificationAsReadDao() async {
    return UnimplementedError();
  }

  ///检查用户关注状态
  static checkFollowDao(name) async {
    return UnimplementedError();
  }

  ///关注用户
  static doFollowDao(name, bool followed) async {
    return UnimplementedError();
  }

  ///组织成员
  static getMemberDao(userName, page) async {
    return UnimplementedError();
  }

  ///更新用户信息
  static updateUserDao(params, Store store) async {
    return UnimplementedError();
  }

  ///获取用户组织
  static getUserOrgsDao(userName, page, {needDb = false}) async {
    return UnimplementedError();
  }

  static searchTrendUserDao(String location,
      {String cursor, ValueChanged valueChanged}) async {
    return UnimplementedError();
  }
}
