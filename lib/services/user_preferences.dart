import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();
  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get checkAuth {
    return _prefs.getBool('isAuth') ?? false;
  }

  set checkAuth(bool value) {
    _prefs.setBool('isAuth', value);
  }
}
