import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));
String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  String username;
  final String email;
  final String urlAvatar;

  Users({required this.username, required this.email, required this.urlAvatar});

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      username: json["username"],
      email: json["email"],
      urlAvatar: json["urlAvatar"]);

  Map<String, dynamic> toJson() =>
      {"username": username, "email": email, "urlAvatar": urlAvatar};
}
