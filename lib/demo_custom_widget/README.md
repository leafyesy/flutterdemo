
# 自定义Widget
当Flutter提供的现有Widget无法满足我们的需求，或者我们为了共享代码需要封装一些通用Widget，这时我们就需要自定义Widget。在Flutter中自定义Widget有三种方式：通过组合其它Widget、自绘和实现RenderObject，本节我们先分别介绍一下这三种方式的特点，后面章节中则详细介绍它们的细节。
## 1.组合其它Widget

这种方式是通过拼装其它低级别的Widget来组合成一个高级别的Widget，例如我们之前介绍的Container就是一个组合Widget，它是由DecoratedBox、ConstrainedBox、Transform、Padding、Align等组成。

在Flutter中，组合的思想非常重要，Flutter提供了非常多的基础Widget，而我们的界面开发都是按照需要组合这些Widget来实现各种不同的布局。

## 2.自绘

如果遇到无法通过系统提供的现有Widget实现的UI时，如我们需要一个渐变圆形进度条，而Flutter提供的CircularProgressIndicator并不支持在显示精确进度时对进度条应用渐变色（其valueColor 属性只支持执行旋转动画时变化Indicator的颜色），这时最好的方法就是通过自定义Widget绘制逻辑来画出我们期望的外观。Flutter中提供了CustomPaint和Canvas供我们自绘UI外观。

## 3.实现RenderObject

Flutter提供的任何具有UI外观的Widget，如文本Text、Image都是通过相应的RenderObject渲染出来的，如Text是由RenderParagraph渲染，而Image是由RenderImage渲染。RenderObject是一个抽象类，它定义了一个抽象方法paint(...):

```$xslt
void paint(PaintingContext context, Offset offset)
```

PaintingContext代表Widget的绘制上下文，通过PaintingContext.canvas可以获得Canvas，绘制逻辑主要是通过Canvas API来实现。子类需要实现此方法以实现自身的绘制逻辑，如RenderParagraph需要实现文本绘制逻辑，而RenderImage需要实现图片绘制逻辑。

可以发现，RenderObject中最终也是通过Canvas来绘制的，那么通过实现RenderObject的方式和上面介绍的通过CustomPaint和Canvas自绘的方式有什么区别？其实答案很简单，CustomPaint只是为了方便开发者封装的一个代理类，它直接继承自SingleChildRenderObjectWidget，通过RenderCustomPaint的paint方法将Canvas和画笔Painter(需要开发者实现，后面章节介绍)连接起来实现了最终的绘制（绘制逻辑在Painter中）。


### CustomPaint

```$xslt
const CustomPaint({
  Key key,
  this.painter, //背景画笔，会显示在子节点后面;
  this.foregroundPainter,//前景画笔，会显示在子节点前面
  this.size = Size.zero, //当child为null时，代表默认绘制区域大小，如果有child则忽略此参数，画布尺寸则为child尺寸。如果有child但是想指定画布为特定大小，可以使用SizeBox包裹CustomPaint实现。
  this.isComplex = false, //是否复杂的绘制，如果是，Flutter会应用一些缓存策略来减少重复渲染的开销。
  this.willChange = false, //和isComplex配合使用，当启用缓存时，该属性代表在下一帧中绘制是否会改变。
  Widget child, //子节点，可以为空
})
```
注:
如果CustomPaint有子节点，为了避免子节点不必要的重绘并提高性能，通常情况下都会将子节点包裹在RepaintBoundary Widget中，这样会在绘制时创建一个新的绘制层（Layer），其子Widget将在新的Layer上绘制，而父Widget将在原来Layer上绘制，也就是说RepaintBoundary 子Widget的绘制将独立于父Widget的绘制，RepaintBoundary会隔离其子节点和CustomPaint本身的绘制边界。


```$xslt
CustomPaint(
  size: Size(300, 300), //指定画布大小
  painter: MyPainter(),
  child: RepaintBoundary(child:...)), 
)
```

|API名称 | 功能 | 
| ---------- | ------ | 
| drawLine | 画线 | 
| drawPoint | 画点 |
| drawPath | 画路径 | 
| drawImage | 画图像 | 
| drawRect | 画矩形 | 
| drawCircle | 画圆 | 
| drawOval | 画椭圆 |
| drawArc | 画圆弧 |

性能:
绘制是比较昂贵的操作，所以我们在实现自绘控件时应该考虑到性能开销，下面是两条关于性能优化的建议：

尽可能的利用好shouldRepaint返回值；在UI树重新build时，控件在绘制前都会先调用该方法以确定是否有必要重绘；假如我们绘制的UI不依赖外部状态，那么就应该始终返回false，因为外部状态改变导致重新build时不会影响我们的UI外观；如果绘制依赖外部状态，那么我们就应该在shouldRepaint中判断依赖的状态是否改变，如果已改变则应返回true来重绘，反之则应返回false不需要重绘。

绘制尽可能多的分层；在上面五子棋的示例中，我们将棋盘和棋子的绘制放在了一起，这样会有一个问题：由于棋盘始终是不变的，用户每次落子时变的只是棋子，但是如果按照上面的代码来实现，每次绘制棋子时都要重新绘制一次棋盘，这是没必要的。优化的方法就是将棋盘单独抽为一个Widget，并设置其shouldRepaint回调值为false，然后将棋盘Widget作为背景。然后将棋子的绘制放到另一个Widget中，这样落子时只需要绘制棋子。