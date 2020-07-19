import '../config.dart';

class Address {
  ///github host 地址
  static const String host = "https://api.github.com/";

  static const String hostWeb = "https://github.com";

  static const String graphicHost = "https://ghchart.rshah.org";

  static const String updateUrl = "https://www.pgyer.com/guqa";

  static getAuthorization() {
    return "${host}authorizations";
  }

  static search(q, sort, order, type, page, [pageSize = Config.PAGE_SIZE]) {
    if (type == 'user') {
      return "${host}search/users?q=$q&page=$page&per_page=$pageSize";
    }
    sort ??= "best%20match";
    order ??= "desc";
    page ??= 1;
    pageSize ??= Config.PAGE_SIZE;
    return "${host}search/repositories?q=$q&sort=$sort&order=$order&page"
        "=$page&per_page=$pageSize";
  }
}
