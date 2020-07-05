import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

class _CupertionSliverRefresh extends SingleChildRenderObjectWidget {
  final double refreshIndicatorLayoutExtent;
  final bool hasLayoutExtent;

  const _CupertionSliverRefresh(
      {Key key,
      this.refreshIndicatorLayoutExtent,
      this.hasLayoutExtent,
      Widget child})
      : assert(refreshIndicatorLayoutExtent != null),
        assert(refreshIndicatorLayoutExtent >= 0.0),
        assert(hasLayoutExtent != null),
        super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCupertionSliverRefresh();
  }

  @override
  Future<void> updateRenderObject(BuildContext context,
      covariant _RenderCupertionSliverRefresh renderObject) async {
    renderObject
      ..refreshIndicatorLayoutExtent = refreshIndicatorLayoutExtent
      ..hasLayoutExtent = hasLayoutExtent;
  }
}

class _RenderCupertionSliverRefresh extends RenderSliver
    with RenderObjectWithChildMixin<RenderBox> {
  double _refreshIndicatorExtent;
  bool _hasLayoutExtent;
  double layoutExtentOffsetCompensation = 0.0;

  double get refreshIndicatorLayoutExtent => _refreshIndicatorExtent;

  bool get hasLayoutExtent => _hasLayoutExtent;

  _RenderCupertionSliverRefresh({
    @required double refreshIndicatorExtent,
    @required bool hasLayoutExtent,
    RenderBox child,
  })  : assert(refreshIndicatorExtent != null),
        assert(refreshIndicatorExtent >= 0.0),
        assert(hasLayoutExtent != null),
        super() {
    _refreshIndicatorExtent = refreshIndicatorExtent;
    _hasLayoutExtent = hasLayoutExtent;
    this.child = child;
  }

  set refreshIndicatorLayoutExtent(double value) {
    assert(value != null);
    assert(value >= 0.0);
    if (value == _refreshIndicatorExtent) return;
    _refreshIndicatorExtent = value;
    markNeedsLayout();
  }

  set hasLayoutExtent(bool value) {
    assert(value != null);
    if (value == _hasLayoutExtent) return;
    _hasLayoutExtent = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    assert(constraints.axisDirection == AxisDirection.down);
    assert(constraints.growthDirection == GrowthDirection.forward);
    final double layoutExtent =
        (_hasLayoutExtent ? 1.0 : 0.0) * _refreshIndicatorExtent;
    if (layoutExtent != layoutExtentOffsetCompensation) {
      geometry = SliverGeometry(
        scrollOffsetCorrection: layoutExtent - layoutExtentOffsetCompensation,
      );
      layoutExtentOffsetCompensation = layoutExtent;
      return;
    }
    final bool active = constraints.overlap < 0.0 || layoutExtent > 0.0;
    final double overscrolledExtent =
        constraints.overlap < 0.0 ? constraints.overlap.abs() : 0.0;
    child.layout(
        constraints.asBoxConstraints(
          maxExtent: layoutExtent + overscrolledExtent,
        ),
        parentUsesSize: true);
    if (active) {
      geometry = SliverGeometry(
        scrollExtent: layoutExtent,
        paintOrigin: -overscrolledExtent - constraints.scrollOffset,
        paintExtent: max(
          max(child.size.height, layoutExtent) - constraints.scrollOffset,
          0.0,
        ),
        maxPaintExtent: max(
            max(child.size.height, layoutExtent) - constraints.scrollOffset,
            0.0),
        layoutExtent: max(layoutExtent - constraints.scrollOffset, 0.0),
      );
    } else {
      geometry = SliverGeometry.zero;
    }
  }

  @override
  void paint(PaintingContext paintingContext, Offset offset) {
    if (constraints.overlap < 0.0 ||
        constraints.scrollOffset + child.size.height > 0) {
      paintingContext.paintChild(child, offset);
    }
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {}
}

///刷新指示器模式
enum RefreshIndicatorMode {
  inactive,
  drag,
  armed,
  refresh,
  done,
}

typedef RefreshControlIndicatorBuilder = Widget Function(
    BuildContext context,
    RefreshIndicatorMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent);

typedef RefreshCallback = Future<void> Function();

class CupertinoSliverRefreshControl extends StatefulWidget {
  static const double _defaultRefreshTriggerPullDistance = 100.0;
  static const double _defaultRefreshIndicatorExtent = 60.0;

  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final RefreshCallback onRefresh;
  final RefreshControlIndicatorBuilder builder;

  const CupertinoSliverRefreshControl({
    Key key,
    this.refreshTriggerPullDistance = _defaultRefreshTriggerPullDistance,
    this.refreshIndicatorExtent = _defaultRefreshIndicatorExtent,
    this.onRefresh,
    this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CupertinoSliverRefreshControlState();
  }

  static Widget buildSimpleRefreshIndicator(
      BuildContext context,
      RefreshIndicatorMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent) {
    const Curve opacityCurve = Interval(0.4, 0.8, curve: Curves.easeInOut);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: refreshState == RefreshIndicatorMode.drag
            ? Opacity(
                opacity: opacityCurve.transform(
                    min(pulledExtent / refreshTriggerPullDistance, 1.0)),
                child: const Icon(
                  CupertinoIcons.down_arrow,
                  color: CupertinoColors.inactiveGray,
                  size: 36.0,
                ),
              )
            : Opacity(
                opacity: opacityCurve
                    .transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
                child: const CupertinoActivityIndicator(
                  radius: 14.0,
                ),
              ),
      ),
    );
  }
}

class CupertinoSliverRefreshControlState
    extends State<CupertinoSliverRefreshControl> {
  static const double _inactiveResetOverscrollFraction = 0.1;
  RefreshIndicatorMode refreshState;
  Future<void> refreshTask;
  double latestIndicatorBoxExtent = 0.0;
  bool hasSliverLayoutExtent = false;
  bool needRefresh = false;
  bool draging = false;

  @override
  void initState() {
    super.initState();
    refreshState = RefreshIndicatorMode.inactive;
  }

  RefreshIndicatorMode transitionNextState() {
    RefreshIndicatorMode nextState;
    void goToDone() {
      nextState = RefreshIndicatorMode.done;
      if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
        setState(() {
          hasSliverLayoutExtent = false;
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          setState(() {
            hasSliverLayoutExtent = false;
          });
        });
      }
    }

    switch (refreshState) {
      case RefreshIndicatorMode.inactive:
        if (latestIndicatorBoxExtent <= 0) {
          return RefreshIndicatorMode.inactive;
        } else {
          nextState = RefreshIndicatorMode.drag;
        }
        continue drag;
      drag:
      case RefreshIndicatorMode.drag:
        if (latestIndicatorBoxExtent == 0) {
          return RefreshIndicatorMode.inactive;
        } else if (latestIndicatorBoxExtent <
            widget.refreshTriggerPullDistance) {
          return RefreshIndicatorMode.drag;
        } else {
          if (widget.onRefresh != null) {
            HapticFeedback.mediumImpact();
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              needRefresh = true;
              setState(() {
                hasSliverLayoutExtent = true;
              });
            });
          }
          return RefreshIndicatorMode.armed;
        }
        break;
      case RefreshIndicatorMode.armed:
        if (refreshState == RefreshIndicatorMode.armed && !needRefresh) {
          goToDone();
          continue done;
        }
        if (latestIndicatorBoxExtent > widget.refreshIndicatorExtent) {
          return RefreshIndicatorMode.armed;
        } else {
          if (draging) {
            goToDone();
            continue done;
          }
          nextState = RefreshIndicatorMode.refresh;
        }
        continue refresh;
      refresh:
      case RefreshIndicatorMode.refresh:
        if (needRefresh) {
          if (widget.onRefresh != null && refreshTask == null) {
            HapticFeedback.mediumImpact();
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              refreshTask = widget.onRefresh()
                ..whenComplete(() {
                  if (mounted) {
                    setState(() {
                      refreshTask = null;
                      needRefresh = false;
                    });
                    refreshState = transitionNextState();
                  }
                });
              setState(() {
                hasSliverLayoutExtent = true;
              });
            });
          }
          return RefreshIndicatorMode.refresh;
        } else {
          goToDone();
        }
        continue done;
      done:
      case RefreshIndicatorMode.done:
        if (latestIndicatorBoxExtent >
            widget.refreshTriggerPullDistance *
                _inactiveResetOverscrollFraction) {
          return RefreshIndicatorMode.done;
        } else {
          nextState = RefreshIndicatorMode.inactive;
        }
        break;
    }
    return nextState;
  }

  void notifyScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (refreshState == RefreshIndicatorMode.armed) {
        draging = false;
      }
    } else if (notification is UserScrollNotification) {
      if (notification.direction != null) {
        draging = notification.direction != ScrollDirection.idle;
//        if(notification.direction != ScrollDirection.idle){
//          draging = true;
//        }else{
//          draging = false;
//        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _CupertionSliverRefresh(
        refreshIndicatorLayoutExtent: widget.refreshIndicatorExtent,
        hasLayoutExtent: hasSliverLayoutExtent,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constrints) {
            latestIndicatorBoxExtent = constrints.maxHeight;
            refreshState = transitionNextState();
            if (widget.builder != null && latestIndicatorBoxExtent > 0) {
              return widget.builder(
                  context,
                  refreshState,
                  latestIndicatorBoxExtent,
                  widget.refreshTriggerPullDistance,
                  widget.refreshIndicatorExtent);
            }
            return Container();
          },
        ));
  }
}
