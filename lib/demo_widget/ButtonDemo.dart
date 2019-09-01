import 'package:flutter/material.dart';

class ButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Button Demo"),
      ),
      body: new Column(
        children: <Widget>[
          new RaisedButton(
            child: new Text("RaisedButton"),
            onPressed: () {
              print(">>>RaisedButton<<<");
            },
          ),
          new FlatButton(
            child: new Text("FlatButton"),
            onPressed: () {
              print(">>>FlatButton<<<");
            },
          ),
          new OutlineButton(
            child: new Text("OutlineButton"),
            onPressed: () {
              print(">>>OutlineButton<<<");
            },
          ),
          new IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () {
                print(">>>IconButton<<<");
              })
        ],
      ),
    );
  }
}
