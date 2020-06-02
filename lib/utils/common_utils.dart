import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_demo/utils/navigator_utils.dart';
import 'package:redux/redux.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CommonUtils {
  static final double MILLIS_LIMIT = 1000.0;
  static final double SECONDS_LIMIT = 60 * MILLIS_LIMIT;
  static final double MINUTES_LIMIT = 60 * SECONDS_LIMIT;
  static final double HOURS_LIMIT = 24 * MILLIS_LIMIT;
  static final double DYS_LIMIT = 30 * HOURS_LIMIT;

  static String getDateStr(DateTime date) {
    if (date == null || date.toString() == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }

  static Future<Null> showLoadingDialog(BuildContext context) {
    return NavigatorUtils.showFDialog(context: context);
  }

  static getThemeData(Color color) {
    return ThemeData(primaryColor: color, platform: TargetPlatform.android);
  }
}
