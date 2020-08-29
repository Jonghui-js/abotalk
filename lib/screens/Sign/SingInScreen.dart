import 'package:abotalk/screens/Sign/SignUpScreen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                        Icons.email,
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right: 20, left: 10),
                              child: TextField(
                                decoration: InputDecoration(hintText: 'Email'),
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
                        onPressed: () {},
                        color: Colors.orange[700],
                        child: Text(
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
