import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        title: Text('ID_PHOTO'),
      ),
      body: new Column(
        verticalDirection: VerticalDirection.down,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Listener(
            child: new Container(
              color: Color.fromARGB(255, 255, 255, 255),
              height: 50.0,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text("base widget"),
            ),
            onPointerUp: (ev) => Navigator.pushNamed(context, "base_fun"),
          ),
          Listener(
            child: new Container(
                color: Color.fromARGB(255, 200, 200, 200),
                height: 50.0,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("ID Photo")),
            onPointerUp: (ev) => Navigator.pushNamed(context, "id_photo"),
          ),
        ],
      ));
}
