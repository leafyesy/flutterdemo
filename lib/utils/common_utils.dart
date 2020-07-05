import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_demo/base/localization/def_localizations.dart';
import 'package:flutter_demo/base/localization/def_string_base.dart';
import 'package:flutter_demo/base/style/ye_style.dart';
import 'package:flutter_demo/utils/navigator_utils.dart';
import 'package:flutter_demo/widget/spin_kit_cube_grid.dart';
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
    return NavigatorUtils.showFDialog(
        bcontext: context,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            child: WillPopScope(
                child: Center(
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: SpinKitCubeGrid(
                            color: YeColors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Container(
                          child: Text(
                            DefLocalizations.i18n(context).loading_text,
                            style: TextStyle(
                                color: YeColors.textColorWhite, fontSize: 18.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onWillPop: () {
                  return Future.value(false);
                }),
          );
        });
  }

  static getThemeData(Color color) {
    return ThemeData(primaryColor: color, platform: TargetPlatform.android);
  }
}
