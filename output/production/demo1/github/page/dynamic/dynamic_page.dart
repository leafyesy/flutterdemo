import 'package:flutter/material.dart';
import 'package:flutter_demo/base/model/Event.dart';
import 'package:flutter_demo/base/state/app_state.dart';
import 'package:flutter_demo/widget/pull/ye_pull_new_load_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:async';
import 'package:redux/redux.dart';
import 'dynamic_bloc.dart';

class DynamicPage extends StatefulWidget {
  DynamicPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DynamicPageState();
}

class DynamicPageState extends State<DynamicPage>
    with
        AutomaticKeepAliveClientMixin<DynamicPage>,
        //Flutter切换tab后保留tab状态 概述 Flutter中为了节约内存不会保存widget的状态,widget都是临时变量。当我们使用TabBar,TabBarView是我们就会发现,切换tab，initState又会被调用一次。

        WidgetsBindingObserver {
  final DynamicBloc dynamicBloc = DynamicBloc();

  bool _ignoring = true;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<void> requestRefresh() async {
    await dynamicBloc
        .requestRefresh(_getStore().state.userInfo?.login)
        .catchError((e) {
      print(e);
    });
    setState(() {
      _ignoring = false;
    });
  }

  _renderEventItem(Event e) {

  }

  Future<void> requestLoadMore() async {
    return await dynamicBloc.requestLoadMore(_getStore().state.userInfo?.login);
  }

  Store<AppState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var content = YePullLoadWidget(
      control: dynamicBloc.pullLoadWidgetControl,
      itemBuilder: (BuildContext context, int index) =>
          _renderEventItem(dynamicBloc.dataList[index]),
      onRefresh: requestRefresh,
      onLoadMore: requestLoadMore,
      refreshKey: refreshIndicatorKey,
      userIos: true,
    );
    return IgnorePointer(
      ignoring: _ignoring,
      child: content,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
