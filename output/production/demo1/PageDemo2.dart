import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageDemo2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PageDemo2();
  }
}

class _PageDemo2 extends State<PageDemo2> {
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);

  void fetchData() {
    Future.wait([Future.delayed(new Duration(seconds: 3))]).then((data) {
      print(data);
    });
    Stream.fromFutures([
      // 1秒后返回结果
      Future.delayed(new Duration(seconds: 1), () {
        return "hello 1";
      }),
      // 抛出一个异常
      Future.delayed(new Duration(seconds: 2), () {
        throw AssertionError("Error");
      }),
      // 3秒后返回结果
      Future.delayed(new Duration(seconds: 3), () {
        return "hello 3";
      })
    ]).listen((data) {
      print(data);
    }, onError: (e) {
      print(e.message);
    }, onDone: () {});
  }

  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new PageView.builder(
      onPageChanged: _pageChange,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        return index == 1 ? _pageItem() : _pageItem();
      },
      itemCount: 2,
    );
  }

  Widget _pageItem() {
    return new Image.asset("images/home_photo_type_1.png");
  }
}
