import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/config/app_navigator.dart';
import 'package:wanandroidflutter/config/app_router.dart';
import 'package:wanandroidflutter/net/request_urls.dart';
import 'package:wanandroidflutter/net/wan_android_api.dart';
import 'package:wanandroidflutter/r.dart';
import 'package:wanandroidflutter/utils/debug_log.dart';
import 'package:wanandroidflutter/utils/screen_adapter.dart';
import 'package:wanandroidflutter/utils/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool agreement = false;

  @override
  void initState() {
    super.initState();

    log(WanAndroidApi.isAuth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('登录'),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
              AppNavigator.navigateTo(context, RouterName.registerPage);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: Text('注册'),
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: Screen.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: aHeight(60),
                bottom: aHeight(40),
              ),
              child: Image.asset(
                Img.LAUNCH_IMAGE,
                width: aHeight(150),
                height: aHeight(150),
                fit: BoxFit.cover,
              ),
            ),
            Form(
              autovalidate: true,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: aWidth(40)),
                    child: TextFormField(
                      controller: _usernameTextController,
                      decoration: const InputDecoration(
                        hintText: '请输入用户名',
                        labelText: '用户名',
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String value) {
                        return value.length <= 0 ? '请输入有效的用户名' : null;
                      },
                      textInputAction: TextInputAction.unspecified,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: aHeight(20),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: aWidth(40)),
                    child: TextFormField(
                      controller: _passwordTextController,
                      decoration: const InputDecoration(
                        hintText: '请输入密码',
                        labelText: '密码',
                        icon: Icon(Icons.sentiment_satisfied),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String value) {
                        return value.length < 6 ? '密码须要大于6位' : null;
                      },
                      textInputAction: TextInputAction.unspecified,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: aWidth(40),
                vertical: aHeight(20),
              ),
              child: RaisedButton(
                onPressed: () {
                  _submit();
                },
                child: Center(
                  child: Text(
                    '登录',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: aWidth(30)),
              child: Row(
                children: <Widget>[
                  Checkbox(
                      value: agreement,
                      onChanged: (value) {
                        setState(() {
                          agreement = value;
                        });
                      }),
                  Text(
                    '我同意该用户协议',
                    style: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Theme.of(context).primaryColor)).caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      if (!agreement) {
        showToast(message: '请同意用户协议');
        return;
      }

      WanAndroidApi.postFrom<Map>(
        URL_LOGIN,
        data: FormData.from({
          'username': _usernameTextController.text,
          'password': _passwordTextController.text,
        }),
      ).then((data) {
        showToast(message: '登录成功');
        AppNavigator.pop(context);
      }).catchError((error) {
        showToast(message: error.toString());
      });
    } else {
      showToast(message: '请确认输入是否有误');
    }
  }
}
