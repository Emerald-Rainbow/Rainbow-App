import 'package:flutter/material.dart';
import 'package:rainbow/screens/screen_login.dart';
import 'package:rainbow/screens/screen_register.dart';
import 'package:rainbow/screens/screen_splash.dart';

void main() {
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
      home: ScreenLogin(),
    );
  }
}
