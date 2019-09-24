import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class InfiniteListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfiniteListViewState();
  }
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "loading...";
  static int maxCount = 100;
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _loadMore();
  }

  @override
  Widget build(BuildContext context) {
    const Divider divider = Divider(
      height: 1,
      color: Colors.grey,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("InfiniteListView"),
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              title: Text("这是表头"),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    if (_words[index] == loadingTag) {
                      //判断数据是否达到上限
                      if (maxCount > _words.length - 1) {
                        //拉取更多数据
                        _loadMore();
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2.0)),
                        );
                      } else {
                        //返回最后一条
                        return Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Center(
                              child: Text("no more data!!!"),
                            ),
                          ),
                        );
                      }
                    }
                    return ListTile(
                      title: Text(_words[index] == null ? "" : _words[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return divider;
                  },
                  itemCount: _words.length),
            )
          ],
        ));
  }

  void _loadMore() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(
          _words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {
        //重新构建列表
      });
    });
  }
}
