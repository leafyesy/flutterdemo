import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_demo/base/config.dart';

class LogsInterceptor extends InterceptorsWrapper {
  static List<Map> sHttpResponse = new List<Map>();
  static List<String> sResponseHttpUrl = new List<String>();

  static List<Map<String, dynamic>> sHttpRequest =
      new List<Map<String, dynamic>>();

  static List<String> sRequestHttpUrl = new List<String>();
  static List<Map<String, dynamic>> sHttpError =
      new List<Map<String, dynamic>>();
  static List<String> sHttpErrorUrl = new List<String>();

  @override
  onRequest(RequestOptions options) async {
    if (Config.DEBUG) {
      print("request url:${options.path}");
      print("request headers:${options.headers.toString()}");
      if (options.data != null) {
        print("request args:${options.data.toString()}");
      }
    }
    try {
      addLogic(sRequestHttpUrl, options.path ?? " ");
      var data;
      if (options.data is Map) {
        data = options.data;
      } else {
        data = Map<String, dynamic>();
      }
      var map = {
        "header:": {options.headers},
      };
      if (options.method == "POST") {
        map["data"] = data;
      }
      addLogic(sHttpRequest, map);
    } catch (e) {
      print(e);
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    if (Config.DEBUG) {
      if (response != null) {
        print("response args:${response.toString()}");
      }
    }
    if (response.data is Map || response.data is List) {
      try {
        var data = Map<String, dynamic>();
        data['data'] = response.data;
        addLogic(sResponseHttpUrl, response?.request?.uri?.toString ?? "");
        addLogic(sHttpResponse, data);
      } catch (e) {
        print(e);
      }
    } else if (response.data != null) {
      try {
        String data = response.data.toString();
        addLogic(sRequestHttpUrl, response?.request?.uri?.toString() ?? "");
        addLogic(sHttpResponse, json.decode(data));
      } catch (e) {
        print(e);
      }
    }
    return response;
  }

  @override
  onError(DioError err) async {
    if (Config.DEBUG) {
      print("request exception:${err.toString()}");
      print("request exception info:${err.response?.toString() ?? ""}");
    }
    try {
      addLogic(sHttpErrorUrl, err.request.path ?? "null");
      var error = Map<String, dynamic>();
      error["error"] = err.message;
      addLogic(sHttpError, error);
    } catch (e) {
      print(e);
    }
    return err;
  }

  static addLogic(List list, data) {
    if (list.length > 20) {
      list.removeAt(0);
    }
    list.add(data);
  }
}
