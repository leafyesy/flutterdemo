import 'package:flutter/material.dart';


class NewRoute extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("new route"),
      ),
      body: new Center(
        child: new Text("center body"),
      ),

    );
  }

}

