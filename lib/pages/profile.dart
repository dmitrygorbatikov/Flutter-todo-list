import 'package:auth/components/main_drawer.dart';
import 'package:auth/services/auth_service.dart';
import 'package:auth/services/user_service.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService authService = AuthService();
  UserService userService = UserService();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  var name;
  var surname;
  var email;
  var registerDate;

  @override
  void initState() {
    getProfile();

    super.initState();
  }

  getProfile() async {
    var profileData = await userService.profile();
    setState(() {
      name = profileData.name;
      surname = profileData.surname;
      email = profileData.email;
      registerDate = profileData.registerDate.toString();
    });
    return profileData;
  }

  updateProfile(BuildContext context) async {
    var status = await userService.updateProfile(
        nameController.text,
        surnameController.text,
        emailController.text,
        oldPasswordController.text,
        newPasswordController.text);

    print(status);

    if (status == 200) {
      setState(() {
        name = nameController.text == "" ? name : nameController.text;
        surname =
            surnameController.text == "" ? surname : surnameController.text;
        email = emailController.text == "" ? email : emailController.text;
      });
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect data'),
        ),
      );
    }

    // setState(() {
    //   name = profileData.name;
    //   surname = profileData.surname;
    //   email = profileData.email;
    //   registerDate = profileData.registerDate.toString();
    // });
    // return profileData;
  }

  showEditUserProfile(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                height: 450,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "${name.toString()}",
                            fillColor: Colors.grey[200],
                            filled: true),
                        onChanged: (text) {
                          nameController.text = text;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "${surname.toString()}",
                            fillColor: Colors.grey[200],
                            filled: true),
                        onChanged: (text) {
                          surnameController.text = text;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "${email.toString()}",
                            fillColor: Colors.grey[200],
                            filled: true),
                        onChanged: (text) {
                          emailController.text = text;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Old password",
                            fillColor: Colors.grey[200],
                            filled: true),
                        onChanged: (text) {
                          oldPasswordController.text = text;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "New password",
                            fillColor: Colors.grey[200],
                            filled: true),
                        onChanged: (text) {
                          newPasswordController.text = text;
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
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              updateProfile(context);
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditUserProfile(context);
        },
        child: const Icon(Icons.edit),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.grey[400],
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://image.flaticon.com/icons/png/512/149/149071.png',
                          ),
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${name.toString()} ${surname.toString()}",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  Text(
                    "${email.toString()}",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Text(
              "${registerDate.toString().substring(0, 10).split('-').reversed.join('/')}"),
        ],
      ),
    );
  }
}
