import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:auth/models/user_model.dart';

class UserService {
  final String baseUrl = "http://localhost:5000/user";

  profile() async {
    String profileUrl = this.baseUrl;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Response res = await get(Uri.parse(profileUrl),
        headers: {'token': sharedPreferences.getString("token").toString()});
    var jsonResponse = json.decode(res.body);
    print(jsonResponse);

    var data = User.fromJson(jsonResponse);

    return data;
  }

  updateProfile(String name, String surname, String email, String oldPassword,
      String newPassword) async {
    String addTodosUrl = this.baseUrl;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "name": name,
      "surname": surname,
      "email": email,
      "oldPassword": oldPassword,
      "newPassword": newPassword
    };

    Response res = await put(Uri.parse(addTodosUrl),
        body: body,
        headers: {'token': sharedPreferences.getString("token").toString()});

    return res.statusCode;
  }
}
