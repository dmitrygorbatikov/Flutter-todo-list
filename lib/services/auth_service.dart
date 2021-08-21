import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = "http://localhost:5000/auth";

  login(String email, String password) async {
    String loginUrl = "${this.baseUrl}/login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"email": email, "password": password};
    var jsonResponse;
    var res = await http.post(Uri.parse(loginUrl), body: body);

    if (res.statusCode == 201) {
      jsonResponse = json.decode(res.body);
      if (jsonResponse != null) {}
      sharedPreferences.setString("token", jsonResponse['token']);
    }
    return res.statusCode;
  }

  register(
    String name,
    String surname,
    String email,
    String password,
  ) async {
    String registerUrl = "${this.baseUrl}/register";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "name": name,
      "surname": surname,
      "email": email,
      "password": password
    };
    var jsonResponse;
    var res = await http.post(Uri.parse(registerUrl), body: body);

    if (res.statusCode == 201) {
      jsonResponse = json.decode(res.body);
      if (jsonResponse != null) {}
      sharedPreferences.setString("token", jsonResponse['token']);
    }
    return res.statusCode;
  }

  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("token");
  }
}
