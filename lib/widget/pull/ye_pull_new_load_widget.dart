import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base/localization/def_localizations.dart';
import 'package:flutter_demo/github/res.dart';
import 'package:flutter_demo/widget/pull/custom_bouncing_scroll_physics.dart';
import 'package:flutter_demo/widget/pull/ye_flare_pull_controller.dart';
import 'package:flutter_demo/widget/pull/ye_refesh_sliver.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const double iosRefreshHeight = 140;
const double iosRefreshIndicatorExtent = 100;

class YePullLoadWidget extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final RefreshCallback onLoadMore;
  final RefreshCallback onRefresh;
  final YePushLoadWidgetControl control;

  final ScrollController scrollController;

  final bool userIos;
  final Key refreshKey;

  YePullLoadWidget(
      {Key key,
      this.itemBuilder,
      this.onLoadMore,
      this.onRefresh,
      this.control,
      this.scrollController,
      this.userIos = false,
      this.refreshKey});

  @override
  State<StatefulWidget> createState() {
    return _YePullLoadWidgetState();
  }
}

class _YePullLoadWidgetState extends State<YePullLoadWidget>
    with YeFlarePullController {
  final GlobalKey<CupertinoSliverRefreshControlState> sliverRefreshKey =
      GlobalKey<CupertinoSliverRefreshControlState>();

  ScrollController _scrollController;
  bool isRefreshing = false;
  bool isLoadMoring = false;

  bool playAuto = false;

  @override
  Widget build(BuildContext context) {
    if (widget.userIos) {
      return new NotificationListener(
          onNotification: (ScrollNotification notification) {
            sliverRefreshKey.currentState
                .notifyScrollNotification(notification);
            return false;
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: const CustomBouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
              refreshHeight: iosRefreshHeight,
            ),
            slivers: [
              CupertinoSliverRefreshControl(
                key: sliverRefreshKey,
                refreshIndicatorExtent: iosRefreshIndicatorExtent,
                refreshTriggerPullDistance: iosRefreshHeight,
                onRefresh: handleRefresh,
                builder: buildSimpleRefreshIndicator,
              )
            ],
          ));
    }
  }

  @override
  ValueNotifier<bool> isActive = ValueNotifier<bool>(true);

  @override
  bool get getPlayAuto => playAuto;

  @override
  double get refreshTriggerPullDistance => iosRefreshHeight;

  @override
  void initState() {
    _scrollController = widget.scrollController ?? new ScrollController();
    VoidCallback scrollListener = () {
      if (_scrollController == null) {
        return;
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (widget.control.needLoadMore) {}
      }
    };
    _scrollController.addListener(scrollListener);
    widget.control.addListener(() {
      setState(() {
        try {
          Future.delayed(Duration(seconds: 2), () {
            _scrollController.notifyListeners();
          });
        } catch (e) {
          print(e);
        }
      });
    });
    super.initState();
  }

  int _getListCount() {
    int length = widget.control.dataList.length;
    if (widget.control.needHeader) {
      return length + (length > 0 ? 2 : 1);
    } else {
      if (length == 0) {
        return 1;
      }
      return length + (length > 0 ? 1 : 0);
    }
  }

  _getItem(int index) {
    if (!widget.control.needHeader &&
        index == widget.control.dataList.length &&
        widget.control.dataList.length != 0) {
      return _buildProgressIndicator();
    } else if (widget.control.needHeader &&
        index == _getListCount() - 1 &&
        widget.control.dataList.length != 0) {
      return _buildProgressIndicator();
    } else if (!widget.control.needHeader &&
        widget.control.dataList.length == 0) {
      return _buildEmpty();
    } else {
      return widget.itemBuilder(context, index);
    }
  }

  _lockToAwait() async {
    doDelayed() async {
      await Future.delayed(Duration(seconds: 1)).then((value) async {
        if (widget.control.isLoading) {
          return await doDelayed();
        } else {
          return null;
        }
      });
    }

    await doDelayed();
  }

  @protected
  Future<Null> handleRefresh() async {
    if (widget.control.isLoading) {
      if (isRefreshing) {
        return null;
      }
      await _lockToAwait();
    }
    widget.control.isLoading = true;
    isRefreshing = true;
    await widget.onRefresh?.call();
    isRefreshing = false;
    widget.control.isLoading = false;
    return null;
  }

  @protected
  Future<Null> handleLoadMore() async {
    if (widget.control.isLoading) {
      if (isLoadMoring) {
        return null;
      }
      await _lockToAwait();
    }
    isLoadMoring = true;
    widget.control.isLoading = true;
    await widget.onLoadMore?.call();
    isLoadMoring = false;
    widget.control.isLoading = false;
    return null;
  }

  Widget _buildEmpty() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: () {},
            child: new Image(
              image: AssetImage(YeGitRes.logo),
              width: 70.0,
              height: 70.0,
            ),
          ),
          Container(
            child: Text(
              DefLocalizations.i18n(context).app_empty,
              style: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 44, 44, 44)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    Widget bottomWidget = (widget.control.needLoadMore)
        ? new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new SpinKitRotatingCircle(color: Theme.of(context).primaryColor),
              new Container(
                width: 5.0,
              ),
              new Text(
                DefLocalizations.i18n(context).load_more_text,
                style: TextStyle(
                    color: Color(0xFF121917),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        : new Container();
    return new Padding(
      padding: EdgeInsets.all(20.0),
      child: new Center(
        child: bottomWidget,
      ),
    );
  }

  Widget buildSimpleRefreshIndicator(
      BuildContext context,
      RefreshIndicatorMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent) {
    pulledExtentFlare = pulledExtent * 0.6;
    playAuto = refreshState == RefreshIndicatorMode.refresh;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: pulledExtent > iosRefreshHeight ? pulledExtent:iosRefreshHeight,
        child: FlareActor(
          "images/flare/loading_world_now.flr",
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          controller: this,
          animation: "Earth Moving",
        ),
      ),
    );
  }
}

class YePushLoadWidgetControl extends ChangeNotifier {
  List _dataList = new List();

  List get dataList => _dataList;
  bool _needLoadMore = true;
  bool _needHeader = true;
  bool isLoading = false;

  set dataList(List value) {
    _dataList.clear();
    if (value != null) {
      _dataList.addAll(value);
      notifyListeners();
    }
  }

  addList(List value) {
    if (value != null) {
      _dataList.addAll(value);
      notifyListeners();
    }
  }

  set needLoadMore(value) {
    _needLoadMore = value;
    notifyListeners();
  }

  get needLoadMore => _needLoadMore;

  set needHeader(value) {
    _needHeader = value;
    notifyListeners();
  }

  get needHeader => _needHeader;
}
