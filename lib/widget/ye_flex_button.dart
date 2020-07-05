import 'package:flutter/material.dart';

class YeFlexButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPress;
  final double fontSize;
  final int maxLines;
  final MainAxisAlignment mainAxisAlignment;

  YeFlexButton(
      {Key key,
      this.text,
      this.color,
      this.textColor,
      this.onPress,
      this.fontSize = 20,
      this.maxLines,
      this.mainAxisAlignment = MainAxisAlignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: () {
        onPress?.call();
      },
      padding:
          EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
      textColor: textColor,
      color: color,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.center,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}

///讲解MainAxisAlignment/CrossAxisAlignment
///row 水平排列 column 垂直排列
///分别为主轴/对称轴
///MainAxisAlignment 主轴:表示和控件方向一致的轴
/// start:开始位置
/// end:结束位置
/// center:中间位置
/// spaceBetween:将主轴空白位置进行均分,排列子元素,首尾没有空隙
/// spaceAround:将主轴空白区域均分,使中间各个子控件距离相等,首尾子控件间距为中间子控件间距的一半
/// spaceEvenly:将主轴空白区域均分,使各个子控件间距相等
///
///CrossAxisAlignment 对称:表示和控件方向垂直相交的轴
/// start:将子控件放在交叉轴的起始位置
/// end:将子控件放在交叉轴的结束位置
/// center:将子控件放在交叉轴的中间位置
/// stretch:使子控件填满交叉轴
///
///
/// row可以使用verticalDirection来控制交叉轴的起始位置及排列方向
///