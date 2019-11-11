import 'package:flutter/material.dart';

class SingleChildScrollViewDemo extends StatelessWidget {
  String str = "hello world";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Single Child Scroll View Demo'),
      ),
      body: Scrollbar(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: str
                .split("")
                .map((c) => Text(
                      c,
                      textScaleFactor: 2.0,
                    ))
                .toList(),
          ),
        ),
      )),
    );
  }
}
