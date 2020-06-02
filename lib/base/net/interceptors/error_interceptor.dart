import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo/base/net/code.dart';
import 'package:flutter_demo/base/net/result_data.dart';

//是否需要提示
const NO_TIP_KEY = "noTip";

/// 如果判断没有网络
/// 使用没有网络的Error ResultData
class ErrorInterceptor extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptor(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(new ResultData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "", false),
          false,
          Code.NETWORK_ERROR));
    }
    return options;
  }
}
