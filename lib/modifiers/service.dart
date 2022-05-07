import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:riverpod_one/modifiers/user_helper.dart';

Future<List<Users>> fetchData() async {
  const String url = "https://mohitkoley.github.io/userjson/users.json";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List users = json.decode(response.body);
    return users.map((user) => Users.fromJson(user)).toList();
  } else {
    throw Exception(response.statusCode.toString());
  }
}
