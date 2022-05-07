import 'dart:convert';

import 'package:riverpod_one/model/model.dart';
import "package:http/http.dart" as http;

class Service {
  Future<List<User>> fetchData() async {
    String url = "https://jsonplaceholder.typicode.com/posts/";
    return Future.delayed(Duration(seconds: 2), () async {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = userFromJson(response.body);
        return data;
      } else {
        throw Exception(response.statusCode.toString());
      }
    });
  }
}
