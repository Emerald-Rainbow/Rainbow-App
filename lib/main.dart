import 'package:flutter/material.dart';
import 'package:rainbow/screens/screen_splash.dart';
import 'package:firebase_core/firebase_core.dart';

const SAVE_KEY_NAME = "UserLoggedIn";
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rainbow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScreenSplash(),
    );
  }
}
