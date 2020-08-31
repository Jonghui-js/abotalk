import 'package:abotalk/services/network_handler.dart';
import 'package:abotalk/redux/Actions.dart';
import 'package:abotalk/redux/AppState.dart';
import 'package:abotalk/screens/Home/HomeScreen.dart';
import 'package:abotalk/screens/Sign/SignUpScreen.dart';
import 'package:abotalk/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  final _globalKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorMsg = '';
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          // resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  alignment: Alignment.bottomLeft,
                  height: 250,
                  child: Text(
                    'ABO+\nTALK',
                    style: TextStyle(fontSize: 50, fontFamily: 'BlackHanSans'),
                  ),
                  decoration: BoxDecoration(color: Colors.orange),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(state.msg,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.email,
                            ),
                            Expanded(
                                child: Container(
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration:
                                          InputDecoration(hintText: 'Email'),
                                      validator: (value) {
                                        bool emailValid = RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value);
                                        if (value.isEmpty) return '이메일을 입력해주세요';
                                        if (!emailValid)
                                          return '유효한 이메일 형식이 아닙니다.';

                                        return null;
                                      },
                                    )))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.lock,
                            ),
                            Expanded(
                                child: Container(
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return '비밀번호를 입력해주세요';
                                        if (value.length < 8)
                                          return '8자 이상 입력해주세요';

                                        return null;
                                      },
                                      decoration:
                                          InputDecoration(hintText: 'Password'),
                                    ))),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 60,
                            child: RaisedButton(
                              onPressed: () async {
                                if (_globalKey.currentState.validate()) {
                                  setState(() {
                                    circular = true;
                                  });

                                  Map<String, String> data = {
                                    "email": _emailController.text,
                                    "password": _passwordController.text
                                  };

                                  var res = await networkHandler.login(
                                      '/auth/login', data);

                                  if (res['success']) {
                                    UserPreferences().checkAuth = true;
                                    UserPreferences().checkToken = res['token'];

                                    var userdata =
                                        await networkHandler.getMe('/auth/me');
                                    UserPreferences().userType =
                                        userdata['data']['blood'];
                                    UserPreferences().userName =
                                        userdata['data']['username'];

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return HomeScreen();
                                        },
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      StoreProvider.of<AppState>(context)
                                          .dispatch(CheckMsg(res['error']));
                                      // errorMsg = res['error'];
                                      circular = false;
                                    });
                                  }
                                }
                              },
                              color: Colors.orange[700],
                              child: circular
                                  ? CircularProgressIndicator(
                                      backgroundColor: Colors.orange[700],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.black),
                                    )
                                  : Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return SignUpScreen();
                                },
                              ),
                            );
                          },
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                  text: '아직 계정이 없으신가요? ',
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'SIGN UP',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
