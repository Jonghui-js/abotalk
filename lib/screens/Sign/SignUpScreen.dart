import 'package:abotalk/screens/Sign/local_widget/AboTalkBanner.dart';
import 'package:abotalk/services/network_handler/auth.dart';
import 'package:abotalk/screens/Sign/SingInScreen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:abotalk/redux/AppState.dart';
import 'package:abotalk/redux/Actions.dart';
import 'package:abotalk/share/color.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthNetworkHandler authNetworkHandler = AuthNetworkHandler();
  final _globalKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _password1Controller = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  String selectedType;
  String errorMsg = '';
  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AboTalkBanner(),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: _globalKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(errorMsg,
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
                              const Icon(
                                Icons.person,
                              ),
                              Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 20, left: 10),
                                      child: TextFormField(
                                        controller: _usernameController,
                                        decoration: InputDecoration(
                                          hintText: '10자 이내로 입력하세요',
                                        ),
                                      )))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.mail,
                              ),
                              Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 20, left: 10),
                                      child: TextFormField(
                                        controller: _emailController,
                                        decoration:
                                            InputDecoration(hintText: 'Email'),
                                        validator: (value) {
                                          bool emailValid = RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value);
                                          if (value.isEmpty)
                                            return '이메일을 입력해주세요';
                                          if (!emailValid)
                                            return '유효한 이메일 형식이 아닙니다.';

                                          return null;
                                        },
                                      )))
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.check),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 20, left: 10),
                                  child: DropdownButtonFormField(
                                    items: bloodTypeList
                                        .map((e) => DropdownMenuItem(
                                            child: Text(e.toUpperCase()),
                                            value: e))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedType = value;
                                      });
                                    },
                                    value: selectedType,
                                    hint: Text('혈액형을 선택해주세요'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.lock,
                              ),
                              Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 20, left: 10),
                                      child: TextFormField(
                                        controller: _password1Controller,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value.isEmpty)
                                            return '비밀번호를 입력해주세요';
                                          if (value.length < 8)
                                            return '8자 이상 입력해주세요';

                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                        ),
                                      )))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.lock,
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 20, left: 10),
                                  child: TextFormField(
                                    controller: _password2Controller,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value.isEmpty) return '비밀번호를 입력해주세요';
                                      if (value.length < 8)
                                        return '8자 이상 입력해주세요';
                                      if (_password1Controller.text != value)
                                        return '비밀번호가 일치하지 않습니다.';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Repeat Password',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
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
                                      "username": _usernameController.text,
                                      "email": _emailController.text,
                                      "blood": selectedType,
                                      "password": _password1Controller.text
                                    };

                                    var res = await authNetworkHandler.register(
                                        '/auth/register', data);

                                    if (res['success']) {
                                      StoreProvider.of<AppState>(context)
                                          .dispatch(CheckMsg(
                                              '${_emailController.text}로 \n메일을 보냈습니다. 확인해주세요.'));
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return SignInScreen();
                                          },
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        errorMsg = res['msg'];
                                        circular = false;
                                      });
                                    }
                                  }
                                },
                                color: Colors.orange[700],
                                child: circular
                                    ? const CircularProgressIndicator(
                                        backgroundColor: Colors.orange,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.black),
                                      )
                                    : const Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return SignInScreen();
                                  },
                                ),
                              );
                            },
                            child: Center(
                              child: RichText(
                                text: const TextSpan(
                                    text: '이미 계정이 있으신가요? ',
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: 'SIGN IN',
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
        });
  }
}
