import 'package:flutter/material.dart';

class AdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AdPageSate();
  }
}

class AdPageSate extends State<AdPage> {

  final PageController _pageController = new PageController();
  double _currentPage = 0.0;

  @override
  Widget build(BuildContext context) {
//    var container = new Container(
//        width: double.infinity,
//        height: double.infinity,
//        alignment: Alignment.topCenter,
//        child: new LayoutBuilder(
//            builder: (context, constraints) => new NotificationListener(
//              onNotification: (ScrollNotification note) {
//                setState(() {
//                  _currentPage = _pageController.page;
//                });
//              },
//              child: new PageView.custom(
//                physics: const PageScrollPhysics(
//                    parent: const BouncingScrollPhysics()),
//                controller: _pageController,
//                childrenDelegate: new SliverChildBuilderDelegate(
//                      (context, index) => new _SimplePage(
//                    '$index',
//                    parallaxOffset: constraints.maxWidth / 2.0 * (index - _currentPage),
//                  ),
//                  childCount: 10,
//                ),
//              ),
//            )),
//    );
    return new LayoutBuilder(
        builder: (context, constraints) => new NotificationListener(
          onNotification: (ScrollNotification note) {
            setState(() {
              _currentPage = _pageController.page;
            });
          },
          child: new PageView.custom(
            physics: const PageScrollPhysics(
                parent: const BouncingScrollPhysics()),
            controller: _pageController,
            childrenDelegate: new SliverChildBuilderDelegate(
                  (context, index) => new _SimplePage(
                '$index',
                parallaxOffset: constraints.maxWidth / 2.0 * (index - _currentPage),
              ),
              childCount: 10,
            ),
          ),
        ));
  }
}

class _SimplePage extends StatelessWidget {
  _SimplePage(this.data, {Key key, this.parallaxOffset = 0.0})
      : super(key: key);

  final String data;
  final double parallaxOffset;

  @override
  Widget build(BuildContext context) => new Center(
    child: new Center(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            data,
            style: const TextStyle(fontSize: 60.0),
          ),
          new SizedBox(height: 40.0),
          new Transform(
            transform:
            new Matrix4.translationValues(parallaxOffset, 0.0, 0.0),
            child: const Text('Yet another line of text'),
          ),
        ],
      ),
    ),
  );
}

/*
container
 /// The top left corner.
? static const Alignment topLeft = Alignment(-1.0, -1.0);
? /// The center point along the top edge.
? static const Alignment topCenter = Alignment(0.0, -1.0);
? /// The top right corner.
? static const Alignment topRight = Alignment(1.0, -1.0);
? /// The center point along the left edge.
? static const Alignment centerLeft = Alignment(-1.0, 0.0);
? /// The center point, both horizontally and vertically.
? static const Alignment center = Alignment(0.0, 0.0);
? /// The center point along the right edge.
? static const Alignment centerRight = Alignment(1.0, 0.0);
? /// The bottom left corner.
? static const Alignment bottomLeft = Alignment(-1.0, 1.0);
? /// The center point along the bottom edge.
 */
