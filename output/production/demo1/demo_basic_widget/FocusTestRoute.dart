import 'package:flutter/material.dart';

class FocusTestRoute extends StatefulWidget {
  @override
  _FocusTextRouteState createState() {
    return _FocusTextRouteState();
  }
}

class _FocusTextRouteState extends State<FocusTestRoute> {
  FocusNode node1 = new FocusNode();
  FocusNode node2 = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("FocusText Demo"),
      ),
      body: new Padding(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              focusNode: node1,
              decoration: InputDecoration(labelText: "node1"),
            ),
            TextField(
              autofocus: false,
              focusNode: node2,
              decoration: InputDecoration(labelText: "node2"),
            ),
            Builder(
              builder: (context) {
                return Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text("move focus"),
                      onPressed: () {
                        if (null == focusScopeNode) {
                          focusScopeNode = FocusScope.of(context);
                        }
                        focusScopeNode.requestFocus(node2);
                      },
                    ),
                    RaisedButton(
                      child: Text("close Keyboard"),
                      onPressed: () {
                        node1.unfocus();
                        node2.unfocus();
                      },
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
