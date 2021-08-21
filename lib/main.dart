import 'package:auth/pages/home.dart';
import 'package:auth/pages/login.dart';
import 'package:auth/pages/profile.dart';
import 'package:auth/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? token;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
          token != null ? "${ModalRoute.of(context)?.settings.name}" : "/login",
      routes: {
        '/': (context) => HomePage(),
        "/login": (context) => Login(),
        "/register": (context) => Register(),
        "/profile": (context) => Profile()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
