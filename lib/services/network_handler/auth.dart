import 'dart:convert';
import 'dart:io';
import 'package:abotalk/services/user_preferences.dart';
import 'package:http/http.dart' as http;

///  HTTP request
///
class AuthNetworkHandler {
  String baseUrl = Platform.isIOS
      ? "http://127.0.0.1:5000/api/v1"
      : "http://10.0.2.2:5000/api/v1";

  String formater(String url) {
    return baseUrl + url;
  }

  ///  Create User Account
  ///  HTTP method POST /api/v1/auth/register
  ///  return success: true, data: Map <User>
  ///
  Future<dynamic> register(String url, Map<String, String> body) async {
    url = formater(url);
    final res =
        await http.post(url, body: JsonEncoder().convert(body), headers: {
      "Content-Type": 'application/json',
    });

    return json.decode(res.body);
  }

  ///  Login
  ///  HTTP method Post /api/v1/auth/login
  ///  return success: true, token: token
  ///
  Future<dynamic> login(String url, Map<String, String> body) async {
    url = formater(url);

    final res =
        await http.post(url, body: JsonEncoder().convert(body), headers: {
      "Content-Type": 'application/json',
    });

    return json.decode(res.body);
  }

  ///  Logout
  ///  HTTP method Post /api/v1/auth/logout
  ///  return success: true
  ///
  Future<dynamic> logout(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    final res =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    return json.decode(res.body);
  }

  ///  Get current user info
  ///  HTTP method Get /api/v1/auth/me
  ///  return success: true, data: Map<User>
  ///
  Future<dynamic> getMe(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    final res =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});

    return json.decode(res.body);
  }

  ///  Get Users Blood Type to implement pie-chart
  ///  HTTP method GET /api/v1/main
  ///  return Map <UsersType>
  ///
  Future<Map<String, dynamic>> getUsersType(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    final res =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    return json.decode(res.body);
  }

  ///  Update User
  ///  HTTP method PUT /api/v1/auth/updateuser
  ///  return success: true, data: <User>

  Future<dynamic> updateUser(String url, Map<String, String> body) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    var res = await http.put(url, body: JsonEncoder().convert(body), headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": 'application/json',
    });

    return json.decode(res.body);
  }
}
