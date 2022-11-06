import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rainbow/screens/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ScreenProfile extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  ScreenProfile({super.key});
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
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            signout(context);
          },
          child: const Text('Log Out'),
        ),
      ],
    )));
  }
}

signout(context) async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
  final sharedPreference = await SharedPreferences.getInstance();
  await sharedPreference.clear();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const ScreenLogin()),
      (route) => false);
}
