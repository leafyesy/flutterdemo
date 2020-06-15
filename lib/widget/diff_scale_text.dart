import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as Math;

class DiffScaleText extends StatefulWidget {
  String text;
  TextStyle textStyle;

  DiffScaleText({Key key, this.text, this.textStyle});

  @override
  State<StatefulWidget> createState() {
    return _DiffScaleTextState();
  }
}

class _DiffScaleTextState extends State<DiffScaleText>
    with TickerProviderStateMixin //和Single的区别:支持创建多个 TickerProvider
{
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animationController.addListener(() {
      print("animation value:${_animationController.value}");
    });
    _animationController.addStatusListener((status) {
      //这里处理状态
      if (status == AnimationStatus.dismissed) {
        print("animation dissmissed:${_animationController.value}");
      } else if (status == AnimationStatus.forward) {
        print("animation forward:${_animationController.value}");
      } else if (status == AnimationStatus.completed) {
        print("animation completed:${_animationController.value}");
      } else if (status == AnimationStatus.reverse) {
        print("animation reverse:${_animationController.value}");
      }
    });
  }

  @override
  void didUpdateWidget(DiffScaleText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      //内容不一致
      if (!_animationController.isAnimating) {
        _animationController.value = 0;
        _animationController.forward(); //动画执行
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    //组件不可用
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        widget.textStyle == null ? TextStyle(fontSize: 30) : widget.textStyle;
    return AnimatedBuilder(
      animation: _animationController,
      //每次controller值改变都会回到builder 重新生成view
      builder: (context, child) {
        return RepaintBoundary(
          child: CustomPaint(
            child: Text(
              widget.text,
              style: style.merge(TextStyle(color: Color(0x00000000))),
              //让Text的文字不可见,使用foregroundPainter来进行绘画
              maxLines: 1,
              textDirection: TextDirection.ltr,
            ),
            foregroundPainter: _DiffText(
                text: widget.text,
                style: style,
                progress: _animationController.value),
          ),
        );
      },
    );
  }
}

class _DiffText extends CustomPainter {
  final String text;
  final TextStyle style;
  final double progress;
  String _oldText;
  List<_TextLayoutInfo> _textLayoutInfoList = [];
  List<_TextLayoutInfo> _oldTextLayoutInfoList = [];
  Alignment alignment;

  _DiffText(
      {this.text,
      this.style,
      this.progress = 1,
      this.alignment = Alignment.center})
      : assert(text != null),
        assert(style != null);

  @override
  void paint(Canvas canvas, Size size) {
    double percent = Math.max(0, Math.min(1, progress));
    if (_textLayoutInfoList.length == 0) {
      calculateLayoutInfo(text, _textLayoutInfoList);
    }
    canvas.save();
    if (_oldTextLayoutInfoList != null && _oldTextLayoutInfoList.length > 0) {
      for (_TextLayoutInfo _oldTextLayoutInfo in _oldTextLayoutInfoList) {
        if (_oldTextLayoutInfo.needMove) {
          double p = percent * 2;
          p = p > 1 ? 1 : p;
          drawText(
              canvas,
              _oldTextLayoutInfo.text,
              1,
              1,
              Offset(
                  _oldTextLayoutInfo.offsetX -
                      (_oldTextLayoutInfo.offsetX - _oldTextLayoutInfo.toX) * p,
                  _oldTextLayoutInfo.offsetY),
              _oldTextLayoutInfo);
        } else {
          drawText(
              canvas,
              _oldTextLayoutInfo.text,
              1 - percent,
              percent,
              Offset(_oldTextLayoutInfo.offsetX, _oldTextLayoutInfo.offsetY),
              _oldTextLayoutInfo);
        }
      }
    } else {
      //no oldText
      percent = 1;
    }
    for (_TextLayoutInfo _textLayoutInfo in _textLayoutInfoList) {
      if (!_textLayoutInfo.needMove) {
        drawText(
            canvas,
            _textLayoutInfo.text,
            percent,
            percent,
            Offset(_textLayoutInfo.offsetX, _textLayoutInfo.offsetY),
            _textLayoutInfo);
      }
    }
    canvas.restore();
  }

  void drawText(Canvas canvas, String text, double textScaleFactor,
      double alphaFactor, Offset offset, _TextLayoutInfo textLayoutInfo) {
    var textPaint = Paint();
    if (alphaFactor == 1) {
      textPaint.color = textLayoutInfo.color;
    } else {
      textPaint.color = textLayoutInfo.color
          .withAlpha((textLayoutInfo.color.alpha * alphaFactor).floor());
    }
    var textPainter = TextPainter(
        text: TextSpan(
            text: text,
            style: style.merge(TextStyle(
                color: null,
                foreground: textPaint,
                textBaseline: TextBaseline.ideographic))),
        textDirection: TextDirection.ltr)
      ..textAlign = TextAlign.center
      ..textScaleFactor = textScaleFactor
      ..textDirection = TextDirection.ltr
      ..layout();
    textPainter.paint(
        canvas,
        Offset(offset.dx,
            offset.dy + (textLayoutInfo.height - textPainter.height) / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is _DiffText) {
      String oldFrameText = oldDelegate.text;
      if (oldFrameText == text) {
        this._oldText = oldDelegate._oldText;
        this._oldTextLayoutInfoList = oldDelegate._oldTextLayoutInfoList;
        this._textLayoutInfoList = oldDelegate._textLayoutInfoList;
        if (this.progress == oldDelegate.progress) {
          return false;
        }
      } else {
        this._oldText = oldDelegate.text;
        calculateLayoutInfo(text, _textLayoutInfoList);
        calculateLayoutInfo(_oldText, _oldTextLayoutInfoList);
        calculateMove();
      }
    }
    return true;
  }

  int colorIndex = 0;

  //颜色库
  var colorList = [
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.yellowAccent,
    Colors.green,
    Colors.cyanAccent,
    Colors.blue,
    Colors.purple
  ];

  void calculateLayoutInfo(String text, List<_TextLayoutInfo> list) {
    list.clear();
    TextPainter painter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
        maxLines: 1);
    painter.layout();
    colorIndex = 0;
    for (int i = 0; i < text.length; i++) {
      var forCaret =
          painter.getOffsetForCaret(TextPosition(offset: i), Rect.zero);
      var offsetX = forCaret.dx;
      if (i > 0 && offsetX == 0) {
        break;
      }
      Color colorValue;
      if (style.color == null) {
        colorValue = colorList[colorIndex++ % colorList.length];
      } else {
        colorValue = style.color;
      }
      var textLayoutInfo = _TextLayoutInfo()
        ..text = text.substring(i, i + 1) //取出每个字符
        ..offsetX = offsetX
        ..offsetY = forCaret.dy
        ..width = 0
        ..height = painter.height
        ..color = colorValue
        ..baseline =
            painter.computeDistanceToActualBaseline(TextBaseline.ideographic);
      list.add(textLayoutInfo);
    }
  }

  void calculateMove() {
    if (!listNoEmpty(_oldTextLayoutInfoList)) return;
    if (!listNoEmpty(_textLayoutInfoList)) return;
    for (_TextLayoutInfo oldText in _oldTextLayoutInfoList) {
      for (_TextLayoutInfo text in _textLayoutInfoList) {
        if (!text.needMove && !oldText.needMove && text.text == oldText.text) {
          text.fromX = oldText.offsetX;
          oldText.toX = text.offsetX;
          text.needMove = true;
          oldText.needMove = true;
        }
      }
    }
  }

  bool listNoEmpty(list) {
    return list != null && list.length > 0;
  }
}

class _TextLayoutInfo {
  String text;
  double offsetX;
  double offsetY;
  double baseline;
  double width;
  double height;
  double fromX = 0;
  double toX = 0;
  bool needMove = false;
  Color color;

  @override
  String toString() {
    return '_TextLayoutInfo{text: $text, offsetX: $offsetX, offsetY: $offsetY, baseline: $baseline, width: $width, height: $height, fromX: $fromX, toX: $toX, needMove: $needMove}';
  }
}
