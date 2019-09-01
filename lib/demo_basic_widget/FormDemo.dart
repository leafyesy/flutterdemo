import 'package:flutter/material.dart';

class FormDemo extends StatefulWidget {
  @override
  _FormDemoState createState() {
    return _FormDemoState();
  }
}

class _FormDemoState extends State<FormDemo> {
  GlobalKey _globalKey = new GlobalKey<FormState>();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _pswController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _globalKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _userNameController,
                decoration: InputDecoration(
                    labelText: "user name",
                    hintText: "user name or email",
                    icon: Icon(Icons.email)),
                validator: (v) {
                  return v.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                autofocus: false,
                controller: _pswController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "password",
                    hintText: "please input password",
                    icon: Icon(Icons.add)),
                validator: (v) {
                  return v.trim().length > 6 ? null : "密码要大于6位";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 58.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                          padding: const EdgeInsets.all(10),
                          child: Text("login"),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,

                          onPressed: () {
                            if ((_globalKey.currentState as FormState)
                                .validate()) {
                              print("验证通过提交数据\n");
                            }
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
Form({
  @required Widget child,
  bool autovalidate = false,
    是否自动校验输入内容；当为true时，每一个子FormField内容发生变化时都会自动校验合法性，并直接显示错误信息。否则，需要通过调用FormState.validate()来手动校验。

  WillPopCallback onWillPop,
    决定Form所在的路由是否可以直接返回（如点击返回按钮），该回调返回一个Future对象，如果Future的最终结果是false，则当前路由不会返回；如果为true，则会返回到上一个路由。此属性通常用于拦截返回按钮。

  VoidCallback onChanged,
    Form的任意一个子FormField内容发生变化时会触发此回调。
})

FormField

Form的子孙元素必须是FormField类型，FormField是一个抽象类，定义几个属性，FormState内部通过它们来完成操作，FormField部分定义如下：

```
const FormField({
  ...
  FormFieldSetter<T> onSaved, //保存回调
  FormFieldValidator<T>  validator, //验证回调
  T initialValue, //初始值
  bool autovalidate = false, //是否自动校验。
})
```
为了方便使用，Flutter提供了一个TextFormField widget，它继承自FormField类，也是TextField的一个包装类，所以除了FormField定义的属性之外，它还包括TextField的属性。

FormState

FormState为Form的State类，可以通过Form.of()或GlobalKey获得。我们可以通过它来对Form的子孙FormField进行统一操作。我们看看其常用的三个方法：

- FormState.validate()：调用此方法后，会调用Form子孙FormField的validate回调，如果有一个校验失败，则返回false
，所有校验失败项都会返回用户返回的错误提示。
- FormState.save()：调用此方法后，会调用Form子孙FormField的save回调，用于保存表单内容
- FormState.reset()：调用此方法后，会将子孙FormField的内容清空。





 */
