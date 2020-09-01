import 'dart:convert';
import 'dart:io';
import 'package:abotalk/services/user_preferences.dart';
import 'package:http/http.dart' as http;

///  HTTP request
///
class NetworkHandler {
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
    print(url);
    final res =
        await http.post(url, body: JsonEncoder().convert(body), headers: {
      "Content-Type": 'application/json',
    });

    return json.decode(res.body);
  }

  ///  Logout
  ///  HTTP method Post /api/v1/auth/logout
  ///  return success: true, data:
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

  ///  Get all Posts
  ///  HTTP method GET /api/v1/posts
  ///  return List <Post>
  ///
  Future<dynamic> getPosts(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);

    final res = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    return json.decode(res.body);
  }

  ///  Get all Posts
  ///  HTTP method GET /api/v1/posts
  ///  return List <Post>
  ///
  Future<dynamic> getPost(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    final res = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    return json.decode(res.body);
  }

  ///  Create Post
  ///  HTTP method POST /api/v1/posts
  ///  return success: true, data: <Post>
  ///
  Future<dynamic> createPost(String url, Map<String, String> body) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    var res = await http.post(url, body: JsonEncoder().convert(body), headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": 'application/json',
    });
    return json.decode(res.body);
  }

  ///  Update Post
  ///  HTTP method POST /api/v1/posts/:id
  ///  return success: true, data: <Post>
  ///

  Future<dynamic> updatePost(String url, Map<String, String> body) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    var res = await http.post(url, body: JsonEncoder().convert(body), headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": 'application/json',
    });
    return json.decode(res.body);
  }

  ///  Get My Posts
  ///  HTTP method GET /api/v1/posts
  ///  return List <Post>
  ///
  Future<dynamic> getMyPosts(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    final res =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    return json.decode(res.body);
  }

  ///  Get My Posts
  ///  HTTP method GET /api/v1/posts
  ///  return List <Post>
  ///
  Future<dynamic> getMyComments(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    final res =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    print(res.body);
    return json.decode(res.body);
  }

  ///  Get My Posts
  ///  HTTP method DELETE /api/v1/posts/:id
  ///  return List <Post>
  ///
  Future<dynamic> deletePost(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    final res = await http
        .delete(url, headers: {HttpHeaders.authorizationHeader: token});
    print(res.body);

    return json.decode(res.body);
  }

  ///  Get Comments
  ///  HTTP method Get /api/v1/posts/comments/:id
  ///  return List <Comment>
  ///
  Future<dynamic> getComments(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    final res = await http
        .delete(url, headers: {HttpHeaders.authorizationHeader: token});
    print(res.body);

    return json.decode(res.body);
  }

  ///  Create Comment
  ///  HTTP method POST /api/v1/posts/comments/:id
  ///  return success: true, data: <Post>
  ///
  Future<dynamic> createComment(String url, Map<String, String> body) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    var res = await http.post(url, body: JsonEncoder().convert(body), headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": 'application/json',
    });
    print(res.body);
    return json.decode(res.body);
  }

  ///  Create Comment
  ///  HTTP method POST /api/v1/posts/comments/:id
  ///  return success: true, data: <Post>

  Future<dynamic> updateUser(String url, Map<String, String> body) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    var res = await http.post(url, body: JsonEncoder().convert(body), headers: {
      HttpHeaders.authorizationHeader: token,
      "Content-Type": 'application/json',
    });
    print(res.body);
    return json.decode(res.body);
  }
}
