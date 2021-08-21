import 'package:flutter/material.dart';
import 'package:auth/services/auth_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService authServices = AuthService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(
              height: 60,
            ),
            Card(
              child: Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(hintText: "Name"),
                        onChanged: (text) {
                          _nameController.text = text;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(hintText: "Surname"),
                        onChanged: (text) {
                          _surnameController.text = text;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                        decoration: InputDecoration(hintText: "Password"),
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
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              var status = await authServices.register(
                                  _nameController.text,
                                  _surnameController.text,
                                  _emailController.text,
                                  _passwordController.text);

                              if (status == 201) {
                                Navigator.pushNamed(context, '/');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
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
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Text('Login'),
                            ))),
                  ])),
            )
          ],
        ),
      ),
    )));
  }
}
