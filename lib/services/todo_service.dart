import 'package:auth/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TodoService {
  final String baseUrl = "http://localhost:5000/todo";

  getTodos() async {
    String getTodosUrl = this.baseUrl;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Response res = await get(Uri.parse(getTodosUrl),
        headers: {'token': sharedPreferences.getString("token").toString()});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  addTodo(String title, String description) async {
    String addTodosUrl = this.baseUrl;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"title": title, "description": description};
    Response res = await post(Uri.parse(addTodosUrl),
        body: body,
        headers: {'token': sharedPreferences.getString("token").toString()});
    var jsonResponse = json.decode(res.body);

    return jsonResponse;
  }

  updateTodo(String title, String description, int id) async {
    String updateTodosUrl = this.baseUrl;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"title": title, "description": description};
    Response res = await put(
        Uri.parse("${updateTodosUrl.toString()}/${id.toString()}"),
        body: body,
        headers: {'token': sharedPreferences.getString("token").toString()});
    // var jsonResponse = json.decode(res.body);

    return res.statusCode;
  }

  deleteTodo(int id) async {
    String deleteTodosUrl = this.baseUrl;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Response res = await delete(
        Uri.parse("${deleteTodosUrl.toString()}/${id.toString()}"),
        headers: {'token': sharedPreferences.getString("token").toString()});
    var jsonResponse = json.decode(res.body);

    print(jsonResponse);

    return jsonResponse;
  }
}
