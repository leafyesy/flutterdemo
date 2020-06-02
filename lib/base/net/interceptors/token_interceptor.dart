import 'dart:async';
import 'package:flutter_demo/base/config.dart';
import 'package:flutter_demo/base/local/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo/base/net/graphql.dart';

class TokenInterceptors extends InterceptorsWrapper {
  String _token;

  @override
  Future onRequest(RequestOptions options) async {
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
        initClient(_token);
      }
    }
    options.headers['Authorization'] = _token;
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson['token'] != null) {
        _token = 'token' + responseJson['token'];
        await LocalStorage.save(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  clearAuthorization() {
    this._token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
    releaseClient();
  }

  getAuthorization() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token == null) {
      String basic = await LocalStorage.get(Config.USER_BASIC_CODE);
      if (basic == null) {
        //提示输入账号密码
      } else {
        return "Basic $basic";
      }
    } else {
      this._token = token;
      return token;
    }
  }
}
