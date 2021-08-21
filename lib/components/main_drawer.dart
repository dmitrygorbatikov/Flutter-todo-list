import 'package:auth/services/auth_service.dart';
import 'package:auth/services/user_service.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  AuthService authService = AuthService();
  UserService userService = UserService();

  var name;
  var surname;
  var email;

  getProfile() async {
    var profileData = await userService.profile();
    setState(() {
      name = profileData.name;
      surname = profileData.surname;
      email = profileData.email;
    });
    return profileData;
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
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
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 18),
              ),
              onTap: null,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              authService.logout();
              Navigator.pushNamed(context, '/login');
            },
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18),
              ),
              onTap: null,
            ),
          )
        ],
      ),
    );
  }
}
