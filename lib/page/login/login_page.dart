import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/config/app_navigator.dart';
import 'package:wanandroidflutter/config/app_router.dart';
import 'package:wanandroidflutter/model/user_model.dart';
import 'package:wanandroidflutter/r.dart';
import 'package:wanandroidflutter/utils/toast.dart';
import 'package:wanandroidflutter/widget/loading_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CancelToken _cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 60,
                bottom: 40,
              ),
              child: Image.asset(
                Img.LAUNCH_IMAGE,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Form(
              autovalidate: true,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: _usernameTextController,
                      decoration: const InputDecoration(
                        hintText: '请输入用户名',
                        labelText: '用户名',
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
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: _passwordTextController,
                      decoration: const InputDecoration(
                        hintText: '请输入密码',
                        labelText: '密码',
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
                horizontal: 40,
                vertical: 20,
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cancelToken.cancel();
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      LoadingDialog.show(context);
      UserModel.instance
          .login(_usernameTextController.text, _passwordTextController.text,
              cancelToken: _cancelToken)
          .then((data) {
        showToast(message: '登录成功');
        LoadingDialog.dismiss(context);
        AppNavigator.pop();
      }).catchError((error) {
        LoadingDialog.dismiss(context);
        showToast(message: error.toString());
      });
    } else {
      showToast(message: '请输入正确的用户名和密码');
    }
  }
}
