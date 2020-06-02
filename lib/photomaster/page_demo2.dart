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

  Widget _pageItem(){
    return new Image.asset("images/home_photo_type_1.png");
  }


}
