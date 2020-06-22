import 'package:flutter/material.dart';

///带图标输入框
class YeInputWidget extends StatefulWidget {
  final bool obscureText;
  final String hintText;
  final IconData iconData;
  final ValueChanged<String> onChanged;
  final TextStyle textStyle;
  final TextEditingController controller;

  YeInputWidget({Key key,
    this.obscureText = false,
    this.hintText,
    this.iconData,
    this.onChanged,
    this.textStyle,
    this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _YeInputWidgetState();
}

class _YeInputWidgetState extends State<YeInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          labelStyle: widget.textStyle,
          hintText: widget.hintText,
          icon: widget.iconData == null ? null : Icon(widget.iconData)
      ),
    );
  }
}
