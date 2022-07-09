import 'package:flutter/material.dart';
import 'package:rainbow/screens/screen_edit.dart';
import 'package:rainbow/screens/screen_home.dart';
import 'package:rainbow/screens/screen_login.dart';
import 'package:rainbow/screens/screen_register.dart';
import 'package:rainbow/screens/screen_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScreenSplash(),
    );
  }
}
