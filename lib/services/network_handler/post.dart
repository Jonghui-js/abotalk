import 'dart:convert';
import 'dart:io';
import 'package:abotalk/services/user_preferences.dart';
import 'package:http/http.dart' as http;

class PostNetworkHandler {
  String baseUrl = Platform.isIOS
      ? "http://127.0.0.1:5000/api/v1"
      : "http://10.0.2.2:5000/api/v1";

  String formater(String url) {
    return baseUrl + url;
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

  ///  Get single Post
  ///  HTTP method GET /api/v1/posts/:id
  ///  return Post
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
  ///  HTTP method GET /api/v1/posts/myposts/me
  ///  return List <Post>
  ///
  Future<dynamic> getMyPosts(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    final res =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    return json.decode(res.body);
  }

  ///  Get My Comments
  ///  HTTP method GET /api/v1/posts/mycomments/me
  ///  return List <Comment>
  ///
  Future<dynamic> getMyComments(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    final res =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    return json.decode(res.body);
  }

  ///  Delete Post
  ///  HTTP method DELETE /api/v1/posts/:id
  ///  return success:true
  ///
  Future<dynamic> deletePost(String url) async {
    final token = UserPreferences().checkToken;
    url = formater(url);
    final res = await http
        .delete(url, headers: {HttpHeaders.authorizationHeader: token});
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
    return json.decode(res.body);
  }
}
