import 'package:flutter_demo/base/dao/user_dao.dart';
import 'package:flutter_demo/base/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'dart:io';
import 'dart:async';

class SqlManager {
  static const _VERSION = 1;
  static const _NAME = "gys_github_app_flutter.db";

  static Database _database;

  static init() async {
    var databasePath = await getDatabasesPath();
    var userRes = await UserDao.getUserInfoLocal();
    String dbName = _NAME;
    if (userRes != null && userRes.result) {
      User user = userRes.data;
      if (user != null && user.login != null) {
        dbName = user.login + " " + _NAME;
      }
    }
    String path;
    if (Platform.isIOS) {
      path = databasePath + "/" + dbName;
    } else {
      path = databasePath + dbName;
    }
    _database = await openDatabase(path,
        version: _VERSION, onCreate: (Database db, int version) async {});
  }

  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return (res?.length ?? 0) > 0;
  }

  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  static close() {
    _database?.close();
    _database = null;
  }
}
