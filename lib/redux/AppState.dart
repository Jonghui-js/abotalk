import 'package:flutter/material.dart';

class AppState {
  // bool isAuth;
  String msg;
  //dynamic userInfo;

  AppState({
    //  @required this.isAuth,
    this.msg,
  });

  AppState.fromAppState(AppState another) {
    //  isAuth = another.isAuth;
    msg = another.msg;
  }

  //String get currentContent => currentChallenge;

  //factory AppState.initial() {
  //  return AppState(content: null);
  // }
}
