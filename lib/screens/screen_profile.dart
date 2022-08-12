import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rainbow/screens/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenProfile extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(user!.email!),
        Text(user!.displayName!),
        CircleAvatar(
          backgroundImage: NetworkImage(user!.photoURL!),
          radius: 20,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.red),
          onPressed: () {
            signout(context);
          },
          child: Text('Log Out'),
        ),
      ],
    )));
  }
}

signout(context) async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
  final _sharedPreference = await SharedPreferences.getInstance();
  await _sharedPreference.clear();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ScreenLogin()), (route) => false);
}
