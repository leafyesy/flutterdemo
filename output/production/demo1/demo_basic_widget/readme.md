# Widget

### 概念

Flutter中几乎所有的对象都是一个Widget!!!

与原生开发中“控件”不同的是，Flutter中的widget的概念更广泛，它不仅可以表示UI元素，也可以表示一些功能性的组件

如：用于手势检测的 GestureDetector widget、用于应用主题数据传递的Theme等等。

### widget和element

在Flutter中，Widget的功能是“描述一个UI元素的配置数据”，它就是说，Widget其实并不是表示最终绘制在设备屏幕上的显示元素，而只是显示元素的一个配置数据。
实际上，Flutter中真正代表屏幕上显示元素的类是Element，也就是说Widget只是描述Element的一个配置，有关Element的详细介绍我们将在本书后面的高级部分深入介绍，
读者现在只需要知道，Widget只是UI元素的一个配置数据，并且一个Widget可以对应多个Element，这是因为同一个Widget对象可以被添加到UI树的不同部分，
而真正渲染时，UI树的每一个Element节点都会对应一个Widget对象。总结一下：

- Widget实际上就是Element的配置数据，Widget树实际上是一个配置树，而真正的UI渲染树是由Element构成；不过，由于Element是通过Widget生成，所以它们之间有对应关系，所以在大多数场景，我们可以宽泛地认为Widget树就是指UI控件树或UI渲染树。

- 一个Widget对象可以对应多个Element对象。这很好理解，根据同一份配置（Widget），可以创建多个实例（Element）。


widget实现

```
@immutable
abstract class Widget extends DiagnosticableTree {//继承 诊断树 提供调试信息
  const Widget({ this.key });
  final Key key;//这个key属性类似于React/Vue中的key，主要的作用是决定是否在下一次build时复用旧的widget，决定的条件在canUpdate()方法中。

    /**
    //正如前文所述“一个Widget可以对应多个Element”；
    //Flutter Framework在构建UI树时，会先调用此方法生成对应节点的Element对象。此方法是Flutter Framework隐式调用的，在我们开发过程中基本不会调用到。
    **/
  @protected
  Element createElement();

  @override
  String toStringShort() {
    return key == null ? '$runtimeType' : '$runtimeType-$key';
  }
    /**
    复写父类的方法，主要是设置诊断树的一些特性。
    **/
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.dense;
  }
    /**
    是一个静态方法，它主要用于在Widget树重新build时复用旧的widget，其实具体来说，
    应该是：是否用新的Widget对象去更新旧UI树上所对应的Element对象的配置；
    通过其源码我们可以看到，只要newWidget与oldWidget的runtimeType和key同时相等时就会用newWidget去更新Element对象的配置，
    否则就会创建新的Element
    **/
  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
}

```

有关Key和Widget复用的细节将会在本书后面高级部分深入讨论，读者现在只需知道，
为Widget显式添加key的话可能（但不一定）会使UI在重新构建时变的高效，读者目前可以先忽略此参数。本书后面的示例中，我们只在构建列表项UI时会显式指定Key。

### Stateless Widget

在之前的章节中，我们已经简单介绍过StatelessWidget，StatelessWidget相对比较简单，它继承自Widget，重写了createElement()方法：

```
@override
StatelessElement createElement() => new StatelessElement(this);
```
StatelessElement 间接继承自Element类，与StatelessWidget相对应（作为其配置数据）。

StatelessWidget用于不需要维护状态的场景，它通常在build方法中通过嵌套其它Widget来构建UI，在构建过程中会递归的构建其嵌套的Widget。我们看一个简单的例子：

```
class Echo extends StatelessWidget {
  const Echo({
    Key key,
    @required this.text,
    this.backgroundColor:Colors.grey,
  }):super(key:key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}
```

### Stateful Widget

和StatelessWidget一样，StatefulWidget也是继承自widget类，并重写了createElement()方法，不同的是返回的Element 对象并不相同；
另外StatefulWidget类中添加了一个新的接口createState()，下面我们看看StatefulWidget的类定义：

```
abstract class StatefulWidget extends Widget {
  const StatefulWidget({ Key key }) : super(key: key);

  @override
  StatefulElement createElement() => new StatefulElement(this);

  @protected
  State createState();
}
```

- StatefulElement 间接继承自Element类，与StatefulWidget相对应（作为其配置数据）。StatefulElement中可能会多次调用createState()来创建状态(State)对象。
- createState() 用于创建和Stateful widget相关的状态，它在Stateful widget的生命周期中可能会被多次调用。例如，当一个Stateful widget同时插入到widget树的多个位置时，Flutter framework就会调用该方法为每一个位置生成一个独立的State实例，其实，本质上就是一个StatefulElement对应一个State实例。

### State

一个StatefulWidget类会对应一个State类，State表示与其对应的StatefulWidget要维护的状态，State中的保存的状态信息可以：

1. 在widget build时可以被同步读取。
2. 在widget生命周期中可以被改变，当State被改变时，可以手动调用其setState()方法通知Flutter framework状态发生改变，Flutter
framework在收到消息后，会重新调用其build方法重新构建widget树，从而达到更新UI的目的。!!!

State中有两个常用属性：

1. widget，它表示与该State实例关联的widget实例，由Flutter framework动态设置。注意，这种关联并非永久的，因为在应用声明周期中，UI树上的某一个节点的widget实例在重新构建时可能会变化，但State
2. 实例只会在第一次插入到树中时被创建，当在重新构建时，如果widget被修改了，Flutter framework会动态设置State.widget为新的widget实例。

context，它是BuildContext类的一个实例，表示构建widget的上下文，它是操作widget在树中位置的一个句柄，它包含了一些查找、遍历当前Widget树的一些方法。每一个widget都有一个自己的context对象。

> 对于BuildContext读者现在可以先作了解，随着本书后面内容的展开，也会用到Context的一些方法，读者可以通过具体的场景对其有个直观的认识。关于BuildContext更多的内容，我们也将在后面高级部分再深入介绍。


### State生命周期

理解State的生命周期对flutter开发非常重要，为了加深读者印象，本节我们通过一个实例来演示一下State的生命周期。

详见 StateLifecycleDemo

### 状态管理

如何决定使用哪种管理方法？以下原则可以帮助你决定：

- 如果状态是用户数据，如复选框的选中状态、滑块的位置，则该状态最好由父widget管理。
- 如果状态是有关界面外观效果的，例如颜色、动画，那么状态最好由widget本身来管理。
- 如果某一个状态是不同widget共享的则最好由它们共同的父widget管理。

### 全局状态管理

当应用中包括一些跨widget（甚至跨路由）的状态需要同步时，上面介绍的方法很难胜任了。比如，我们有一个设置页，里面可以设置应用语言，但是我们为了让设置实时生效，我们期望在语言状态发生改变时，我们的APP Widget能够重新build一下，但我们的APP Widget和设置页并不在一起。正确的做法是通过一个全局状态管理器来处理这种“相距较远”的widget之间的通信。目前主要有两种办法：

- 实现一个全局的事件总线，将语言状态改变对应为一个事件，然后在APP Widget所在的父widgetinitState 方法中订阅语言改变的事件，当用户在设置页切换语言后，我们触发语言改变事件，然后APP
Widget那边就会收到通知，然后重新build一下即可。
- 使用redux这样的全局状态包，读者可以在pub上查看其详细信息。
本书后面事件处理一章中会实现一个全局事件总线。

#### 基础widget
Text：该 widget 可让您创建一个带格式的文本。
Row、 Column： 这些具有弹性空间的布局类Widget可让您在水平（Row）和垂直（Column）方向上创建灵活的布局。其设计是基于web开发中的Flexbox布局模型。
Stack： 取代线性布局 (译者语：和Android中的FrameLayout相似)，Stack允许子 widget 堆叠， 你可以使用 Positioned 来定位他们相对于Stack的上下左右四条边的位置。Stacks是基于Web开发中的绝对定位（absolute positioning )布局模型设计的。
Container： Container 可让您创建矩形视觉元素。container 可以装饰一个BoxDecoration, 如 background、一个边框、或者一个阴影。 Container 也可以具有边距（margins）、填充(padding)和应用于其大小的约束(constraints)。另外， Container可以使用矩阵在三维空间中对其进行变换。


#### Material widget

Flutter提供了一套丰富的Material widget，可帮助您构建遵循Material Design的应用程序。Material应用程序以MaterialApp widget开始， 该widget在应用程序的根部创建了一些有用的widget，比如一个Theme，它配置了应用的主题。 是否使用MaterialApp完全是可选的，但是使用它是一个很好的做法。在之前的示例中，我们已经使用过多个Material widget了，如：Scaffold、AppBar、FlatButton等。要使用Material widget，需要先引入它：
```
import 'package:flutter/material.dart';
```

#### Cupertino widget
Flutter也提供了一套丰富的Cupertino风格的widget，尽管目前还没有Material widget那么丰富，但也在不断的完善中。值得一提的是在Material widget库中，有一些widget可以根据实际运行平台来切换表现风格，比如MaterialPageRoute，在路由切换时，如果是Android系统，它将会使用Android系统默认的页面切换动画(从底向上)，如果是iOS系统时，它会使用iOS系统默认的页面切换动画（从右向左）。由于在前面的示例中还没有Cupertino widget的示例，我们实现一个简单的Cupertino页面：
```
//导入cupertino widget库

import 'package:flutter/cupertino.dart';

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
      child: Center(
        child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text("Press"),
            onPressed: () {}
        ),
      ),
    );
  }
}

```















