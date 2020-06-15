import 'package:flustars/flustars.dart';

class LocalStorage {
  static putString(String key, String value) async {
    SpUtil.putString(key, value);
  }

  static getString(String key) async {
    SpUtil.getString(key);
  }

  static remove(String key) async {
    SpUtil.remove(key);
  }
}
