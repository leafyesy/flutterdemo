import 'package:flutter_demo/base/localization/def_string_base.dart';
import 'package:flutter_demo/github/language/rd_string_base.dart';

class CnString extends DefStringBase {
  @override
  String get network_error => "网络错误";

  @override
  String get network_error_401 => "网络错误 401";

  @override
  String get network_error_403 => "网络错误 403";

  @override
  String get network_error_404 => "网络错误 404";

  @override
  String get network_error_422 => "网络错误 422";

  @override
  String get network_error_timeout => "连接超时";

  @override
  String get network_error_unknown => "未知错误";

  @override
  String get github_refused => "拒绝";

  @override
  String get login_password_hint_text => "请输入登录密码";

  @override
  String get login_username_hint_text => "请输入用户名";

  @override
  String get login_text => "登录";

  @override
  String get login_warming_password_empty => "登录密码不能为空";

  @override
  String get login_warming_username_empty => "用户名不能为空";

  @override
  String get loading_text => "加载中...";

  @override
  String get load_more_text => "加载更多...";

  @override
  String get app_empty => "没有内容!";
}
