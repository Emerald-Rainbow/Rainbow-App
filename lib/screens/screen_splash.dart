import 'package:flutter/material.dart';
import 'package:rainbow/main.dart';
import 'package:rainbow/screens/screen_home.dart';
import 'package:rainbow/screens/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);
  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLoggedin();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  gotoLogin() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const ScreenLogin(),
    ));
  }

  checkUserLoggedin() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPreference.getBool(saveKeyName);
    if (userLoggedIn == null || userLoggedIn == false) {
      gotoLogin();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ScreenHome()));
    }
  }
}
