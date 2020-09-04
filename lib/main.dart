import 'package:abotalk/redux/AppState.dart';
import 'package:abotalk/redux/Reducer.dart';
import 'package:abotalk/screens/Home/HomeScreen.dart';
import 'package:abotalk/screens/Sign/SingInScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'services/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  final _initialState = AppState(msg: '');
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  runApp(MyApp(store: _store));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  MyApp({this.store});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: widget.store,
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  fontFamily: 'DoHyeon',
                  primaryColor: Colors.white,
                  primarySwatch: Colors.orange),
              home: UserPreferences().checkAuth ? HomeScreen() : SignInScreen(),
            );
          }),
    );
  }
}
