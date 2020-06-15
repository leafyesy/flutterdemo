import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_demo/base/net/code.dart';
import 'package:flutter_demo/base/net/result_data.dart';
import 'package:flutter_demo/base/net/interceptors/error_interceptor.dart';
import 'package:flutter_demo/base/net/interceptors/header_interceptor.dart';
import 'package:flutter_demo/base/net/interceptors/logs_interceptor.dart';
import 'package:flutter_demo/base/net/interceptors/response_interceptor.dart';
import 'package:flutter_demo/base/net/interceptors/token_interceptor.dart';

class HttpManager {
  static const CONNECT_TYPE_JSON = "application/json";
  static const CONNECT_TYPE_FORM = "application/x-www-from-urlencoded";

  Dio _dio = new Dio();

  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();

  HttpManager() {
    _dio.interceptors.add(_tokenInterceptors);
    _dio.interceptors.add(new HeaderInterceptor());
    _dio.interceptors.add(new LogsInterceptor());
    _dio.interceptors.add(new ResponseInterceptor());
    _dio.interceptors.add(new ErrorInterceptor(_dio));
  }

  ///发起网络请求
  ///[url] 链接
  ///[params] 参数
  ///[header] 请求头
  ///[options] 配置
  ///[noTip] 是否弹出提示
  ///[method] 请求方式 默认 get
  Future<ResultData> fetchData(
      url, params, Map<String, dynamic> header, Options options,
      {noTip = false, method = "get"}) async {
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }
    if (options == null) {
      options = new Options(method: method);
    }
    options.headers = headers;
    resultError(DioError e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_ERROR;
      }
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: options);
    } on DioError catch (e) {
      print(e);
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }

  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  getAuthorization() {
    _tokenInterceptors.getAuthorization();
  }
}

final HttpManager httpManager = new HttpManager();
