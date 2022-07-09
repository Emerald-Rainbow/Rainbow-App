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
    // TODO: implement dispose
    super.dispose();
  }

  gotoLogin() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ScreenLogin(),
    ));
  }

  checkUserLoggedin() async {
    final _sharedPreference = await SharedPreferences.getInstance();
    final _userLoggedIn = _sharedPreference.getBool(SAVE_KEY_NAME);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ScreenHome()));
    }
  }
}
