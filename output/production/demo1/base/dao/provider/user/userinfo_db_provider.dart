import 'package:flutter_demo/base/dao/base_db_provider.dart';
import 'package:flutter_demo/base/model/user.dart';
import 'package:flutter_demo/utils/code_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class UserInfoProvider extends BaseDbProvider {
  final String name = 'UserInfo';
  final String columnId = "_id";
  final String columnUserName = 'userName';
  final String columnData = 'data';

  int id;
  String userName;
  String data;

  UserInfoProvider();

  Map<String, dynamic> toMap(String userName, String data) {
    Map<String, dynamic> map = {columnUserName: userName, columnData: data};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  UserInfoProvider.fromMap(Map map) {
    id = map[columnId];
    userName = map[columnUserName];
    data = map[columnData];
  }

  @override
  tableName() {
    return name;
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        "$columnUserName text not null,$columnData text not null";
  }

  Future _getUserProvider(Database db, String userName) async {
    List<Map<String, dynamic>> maps = await db.query(name,
        columns: [columnId, columnUserName, columnData],
        where: "$columnUserName = ?",
        whereArgs: [userName]);
    if (maps.length > 0) {
      UserInfoProvider provider = UserInfoProvider.fromMap(maps.first);
      return provider;
    }
    return null;
  }

  ///插入数据库
  Future insert(String userName, String eventMapString) async {
    Database db = await getDataBase();
    var userProvider = await _getUserProvider(db, userName);
    if (userProvider != null) {
      await db
          .delete(name, where: "$columnUserName = ?", whereArgs: [userName]);
    }
    return await db.insert(name, toMap(userName, eventMapString));
  }

  ///获取事件数据
  Future<User> getUserInfo(String userName) async {
    Database db = await getDataBase();
    var userProvider = await _getUserProvider(db, userName);
    if (userProvider != null) {
      var mapData =
          await compute(CodeUtils.decodeMapResult, userProvider.data as String);
      return User.fromJson(mapData);
    }
    return null;
  }
}
