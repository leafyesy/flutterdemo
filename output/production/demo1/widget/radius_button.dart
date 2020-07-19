import 'package:flutter/material.dart';

class RadiusButton extends StatefulWidget {
  final Color color;
  final double height;
  final double width;
  final double radius;

  String text;

  TextStyle textStyle;

  RadiusButton(this.color, this.width, this.height, this.radius,
      {this.text, this.textStyle}) {
    if (textStyle == null) {
      textStyle = TextStyle(
        fontSize: 20,
        color: Colors.white,
      );
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _RadiusButtonState();
  }
}

class _RadiusButtonState extends State<RadiusButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: Container(
            color: widget.color,
            height: widget.height,
            width: widget.width,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.text,
                style: widget.textStyle,
              ),
            )));
  }
}
