import 'package:flutter/material.dart';
import 'package:flutter_demo/base/anim/animated_background.dart';
import 'package:flutter_demo/base/config.dart';
import 'package:flutter_demo/base/local/local_storage.dart';
import 'package:flutter_demo/base/localization/def_localizations.dart';
import 'package:flutter_demo/base/state/app_state.dart';
import 'package:flutter_demo/base/style/ye_style.dart';
import 'package:flutter_demo/redux/login_reducer.dart';
import 'package:flutter_demo/utils/navigator_utils.dart';
import 'package:flutter_demo/widget/particle/particles_widget.dart';
import 'package:flutter_demo/widget/ye_flex_button.dart';
import 'package:flutter_demo/widget/ye_input_edit_text.dart';
import 'package:flutter_redux/flutter_redux.dart';
import "package:fluttertoast/fluttertoast.dart";
import '../res.dart';

class LoginPage extends StatefulWidget {
  static const sName = "login";

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> with LoginBLoC {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        //触摸收起键盘
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Stack(children: <Widget>[
            Positioned.fill(child: AnimationBackground()),
            Positioned.fill(child: ParticlesWidget(numberOfParticles: 10)),
            _centerLoginButton()
          ]),
        ),
      ),
    );
  }

  Widget _centerLoginButton() {
    return Center(
      //防止overflow的现象
      child: SafeArea(
          child: SingleChildScrollView(
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          color: Colors.white,
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Padding(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    image: AssetImage(YeGitRes.logo),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  YeInputWidget(
                    hintText:
                        DefLocalizations.i18n(context).login_username_hint_text,
                    controller: userController,
                    //obscureText: true,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  YeInputWidget(
                    hintText:
                        DefLocalizations.i18n(context).login_password_hint_text,
                    controller: passwordController,
                    obscureText: true,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: YeFlexButton(
                            onPress: () {
                              //loginIn();
                              NavigatorUtils.goHome(context);
                            },
                            textColor: YeColors.white,
                            color: YeColors.actionBlue,
                            text: DefLocalizations.i18n(context).login_text,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  )
                ],
              ),
              padding:
                  EdgeInsets.only(left: 30, top: 40, right: 30, bottom: 0)),
        ),
      )),
    );
  }
}

mixin LoginBLoC on State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var _userName = "";
  var _password = "";

  @override
  void initState() {
    super.initState();
    initParam();
  }

  @override
  void dispose() {
    super.dispose();
    userController.removeListener(_usernameChange);
    passwordController.removeListener(_passwordChange);
  }

  void _usernameChange() {
    _userName = userController.text;
  }

  void _passwordChange() {
    _password = passwordController.text;
  }

  initParam() async {
    _userName = await LocalStorage.getString(Config.USER_NAME_KEY);
    _password = await LocalStorage.getString(Config.PW_KEY);
    userController.addListener(_usernameChange);
    passwordController.addListener(_passwordChange);
    userController.value = TextEditingValue(text: _userName ?? "");
    passwordController.value = TextEditingValue(text: _password ?? "");
  }

  loginIn() async {
    if (_userName == null || _userName.isEmpty) {
      Fluttertoast.showToast(
          msg: DefLocalizations.i18n(context).login_username_hint_text);
      return;
    }
    if (_password == null || _password.isEmpty) {
      Fluttertoast.showToast(
          msg: DefLocalizations.i18n(context).login_password_hint_text);
      return;
    }
    //去执行登录
    StoreProvider.of<AppState>(context)
        .dispatch(LoginAction(context, _userName, _password));
  }
}
