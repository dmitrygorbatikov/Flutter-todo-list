import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:auth/models/user_model.dart';

class UserService {
  final String baseUrl = "http://localhost:5000/user";

  profile() async {
    String profileUrl = this.baseUrl;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var res = await http.get(Uri.parse(profileUrl),
        headers: {'token': sharedPreferences.getString("token").toString()});
    var jsonResponse = json.decode(res.body);

    var data = User.fromJson(jsonResponse);

    return data;
  }
}
