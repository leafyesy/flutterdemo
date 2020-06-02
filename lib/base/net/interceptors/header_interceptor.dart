import 'dart:async';
import 'package:dio/dio.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  @override
  Future onRequest(RequestOptions options) async {
    options.connectTimeout = CONNECT_TIMEOUT;
    options.receiveTimeout = RECEIVE_TIMEOUT;
    return options;
  }
}
