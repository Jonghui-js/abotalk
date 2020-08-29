import 'package:abotalk/screens/Sign/SingInScreen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right: 20, left: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                ),
                              )))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.mail,
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right: 20, left: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                ),
                              )))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.check,
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right: 20, left: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Blood Type',
                                ),
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
                              margin: EdgeInsets.only(right: 20, left: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                ),
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
                              margin: EdgeInsets.only(right: 20, left: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Repeat Password',
                                ),
                              )))
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
                        onPressed: () {},
                        color: Colors.orange[700],
                        child: Text(
                          'SIGN UP',
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
                            return SignInScreen();
                          },
                        ),
                      );
                    },
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: '이미 계정이 있으신가요? ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'SIGN IN',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
