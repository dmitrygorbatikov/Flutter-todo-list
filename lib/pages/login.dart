import 'package:auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthService authServices = AuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 48),
                ),
                SizedBox(
                  height: 60,
                ),
                Card(
                  child: Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                decoration: InputDecoration(hintText: "Email"),
                                onChanged: (text) {
                                  _emailController.text = text;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                obscureText: true,
                                decoration:
                                    InputDecoration(hintText: "Password"),
                                onChanged: (text) {
                                  _passwordController.text = text;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                height: 60.0,
                                width: 200,
                                child: MaterialButton(
                                    color: Colors.lightBlueAccent,
                                    child: Text(
                                      'Sing In',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      var status = await authServices.login(
                                          _emailController.text,
                                          _passwordController.text);

                                      if (status == 201) {
                                        Navigator.pushNamed(context, '/');
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Incorrect data'),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                    height: 60.0,
                                    width: 150.0,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/register');
                                      },
                                      child: const Text('Register'),
                                    ))),
                          ])),
                )
              ],
            ),
          ),
        )));
  }
}
