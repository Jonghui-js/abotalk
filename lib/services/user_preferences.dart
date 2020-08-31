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

  get checkToken {
    return _prefs.getString('token');
  }

  set checkToken(String token) {
    _prefs.setString('token', token);
  }

  get userName {
    return _prefs.getString('userName');
  }

  set userName(String username) {
    _prefs.setString('userName', username);
  }

  get userType {
    return _prefs.getString('userType');
  }

  set userType(String usertype) {
    _prefs.setString('userType', usertype);
  }
}
