import 'package:flutter/material.dart';
import 'MyDrawer.dart';

class ScaffoldDemo2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaffoldDemo2State();
  }
}

class _ScaffoldDemo2State extends State<ScaffoldDemo2>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      switch (_tabController.index) {
//        case 1:;
//        case 2:;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ScaffoldDemo2"),
        centerTitle: true,
        bottom: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      drawer: MyDrawer(),
      body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                e,
                textScaleFactor: 5,
              ),
            );
          }).toList()),
    );
  }
}
