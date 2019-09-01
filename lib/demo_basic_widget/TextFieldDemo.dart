import 'package:flutter/material.dart';

class TextFieldDemo extends StatefulWidget {
  @override
  _TextFieldState createState() {
    return _TextFieldState();
  }
}


class _TextFieldState extends State<TextFieldDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("TextField Demo"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            decoration: InputDecoration(
                labelText: "用户名",
                hintText: "用户名或邮箱",
                prefixIcon: Icon(Icons.person)
            ),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "您的登录密码",
                prefixIcon: Icon(Icons.lock)
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }

}
/*
const TextField({
  ...
  TextEditingController controller,
    编辑框的控制器，通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件。
    大多数情况下我们都需要显式提供一个controller来与文本框交互。如果没有提供controller，则TextField内部会自动创建一个。


  FocusNode focusNode,
    用于控制TextField是否占有当前键盘的输入焦点。它是我们和键盘交互的一个handle。

  InputDecoration decoration = const InputDecoration(),
    用于控制TextField的外观显示，如提示文本、背景颜色、边框等。

  TextInputType keyboardType,
    用于设置该输入框默认的键盘输入类型
    text=>文本
    multiline=>多行文本，需和maxLines配合使用(设为null或大于1)
    number=>数字；会弹出数字键盘
    phone=>优化后的电话号码输入键盘；会弹出数字键盘并显示"* #"
    datetime=>优化后的日期输入键盘；Android上会显示“: -”
    emailAddress=>优化后的电子邮件地址；会显示“@ .”
    url=>优化后的url输入键盘； 会显示“/ .”

  TextInputAction textInputAction,
    键盘动作按钮图标(即回车键位图标)

  TextStyle style,
    正在编辑的文本样式。

  TextAlign textAlign = TextAlign.start,
    输入框内编辑文本在水平方向的对齐方式。

  bool autofocus = false,
    是否自动获取焦点。

  bool obscureText = false,
    是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换

  int maxLines = 1,
    输入框的最大行数，默认为1；如果为null，则无行数限制。

  int maxLength,
  bool maxLengthEnforced = true,
    maxLength代表输入框文本的最大长度，设置后输入框右下角会显示输入的文本计数。
    maxLengthEnforced决定当输入文本长度超过maxLength时是否阻止输入，为true时会阻止输入，为false时不会阻止输入但输入框会变红。


  ValueChanged<String> onChanged,
    输入框内容改变时的回调函数；注：内容改变事件也可以通过controller来监听。

  VoidCallback onEditingComplete,
  ValueChanged<String> onSubmitted,
    这两个回调都是在输入框输入完成时触发，比如按了键盘的完成键（对号图标）或搜索键（🔍图标）。
    不同的是两个回调签名不同，onSubmitted回调是ValueChanged<String>类型，它接收当前输入内容做为参数，而onEditingComplete不接收参数。


  List<TextInputFormatter> inputFormatters,
    用于指定输入格式；当用户输入内容改变时，会根据指定的格式来校验。

  bool enabled,
    如果为false，则输入框会被禁用，禁用状态不接收输入和事件，同时显示禁用态样式（在其decoration中定义）。

  this.cursorWidth = 2.0,
  this.cursorRadius,
  this.cursorColor,
    这三个属性是用于自定义输入框光标宽度、圆角和颜色的。

  ...
})

使用controller获取内容
```
TextEditingController _unameController=new TextEditingController();

TextField(
    autofocus: true,
    controller: _unameController, //设置controller
    ...
)

print(_unameController.text)
```

监听文本变化

1.
```
TextField(
    autofocus: true,
    onChanged: (v) {
      print("onChange: $v");
    }
)
```
2.
```
@override
void initState() {
  //监听输入改变
  _unameController.addListener((){
    print(_unameController.text);
  });
}
```

控制焦点

FocusNode和FocusScopeNode来控制







 */