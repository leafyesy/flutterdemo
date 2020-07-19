import 'package:flutter_demo/base/config.dart';
import 'package:flutter_demo/widget/pull/ye_pull_new_load_widget.dart';

class DynamicBloc {
  final YePullLoadWidgetControl pullLoadWidgetControl =
      YePullLoadWidgetControl();

  int _page = 1;

  requestRefresh(String userName, {doNextFlag = true}) async {
    pageReset();
  }

  requestLoadMore(String userName) async {
    pageUp();
  }

  pageReset() {
    _page = 1;
  }

  pageUp() {
    _page++;
  }

  getLoadMoreStatus(res) {
    return (res != null &&
        res.data != null &&
        res.data.length == Config.PAGE_SIZE);
  }

  doNext(res) async {}

  int getDataLength() {
    return pullLoadWidgetControl.dataList.length;
  }

  changeLoadMoreStatus(bool needLoadMore) {
    pullLoadWidgetControl.needLoadMore = needLoadMore;
  }

  changeNeedHeaderStatus(bool needHeader) {
    pullLoadWidgetControl.needHeader = needHeader;
  }

  refreshData(res) {
    if (res != null) {
      pullLoadWidgetControl.dataList = res.data;
    }
  }

  loadMoreData(res) {
    if (res != null) {
      pullLoadWidgetControl.addList(res.data);
    }
  }

  ///清理数据
  clearData() {
    refreshData([]);
  }

  ///列表数据
  get dataList => pullLoadWidgetControl.dataList;

  void dispose() {
    pullLoadWidgetControl.dispose();
  }
}
