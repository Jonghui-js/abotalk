import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseUrl = "http://127.0.0.1:5000/api/v1";
  var log = Logger();

  String formater(String url) {
    return baseUrl + url;
  }

  Future<dynamic> get(String url) async {
    url = formater(url);
    print(url);

    var res = await http.get(url);
    log.i(res.body);
    log.i(res.statusCode);
    // return res;
  }

  Future<dynamic> register(String url, Map<String, String> body) async {
    url = formater(url);
    print(url);
    var res = await http.post(url, body: JsonEncoder().convert(body), headers: {
      "Content-Type": 'application/json',
    });

    return json.decode(res.body);
  }

  Future<dynamic> login(String url, Map<String, String> body) async {
    url = formater(url);
    print(url);
    var res = await http.post(url, body: JsonEncoder().convert(body), headers: {
      "Content-Type": 'application/json',
    });

    return json.decode(res.body);
  }
}
