import 'package:flutter/material.dart';
import 'package:rainbow/main.dart';
import 'package:rainbow/screens/screen_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);
  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // final _emailController = TextEditingController();

  // final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // child: Padding(
          // padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                width: 200,
              ),
              // Text(
              //   'Login',
              //   style: TextStyle(
              //     fontSize: 30,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 25),
              // TextFormField(
              //   controller: _emailController,
              //   decoration: InputDecoration(
              //     hintText: 'Email',
              //     border: OutlineInputBorder(),
              //     prefixIcon: Icon(Icons.email),
              //   ),
              // ),
              // SizedBox(height: 20),
              // TextFormField(
              //   obscureText: true,
              //   controller: _passwordController,
              //   decoration: InputDecoration(
              //     hintText: 'Password',
              //     border: OutlineInputBorder(),
              //     prefixIcon: Icon(Icons.password),
              //   ),
              // ),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     signIn(
              //         _emailController.text, _passwordController.text, context);
              //   },
              //   child: Text('Login'),
              // ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                child: const Text('Login with Google'),
              ),
              // TextButton(
              //   onPressed: () {
              //     goToRegisterPage(context);
              //   },
              //   child: Text('Not have an account? Register'),
              // )
            ],
          ),
        ),
      ),
      // ),
    );
  }

  // void goToRegisterPage(context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => ScreenRegister()),
  //   );
  // }

  // signIn(String email, String password, context) async {
  //   try {
  //     final credential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     final _sharedPreference = await SharedPreferences.getInstance();
  //     await _sharedPreference.setBool(SAVE_KEY_NAME, true);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => ScreenHome()),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           duration: Duration(seconds: 3),
  //           backgroundColor: Colors.red,
  //           behavior: SnackBarBehavior.floating,
  //           margin: EdgeInsets.all(10),
  //           content: Text('No User found for that Email.'),
  //         ),
  //       );
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           duration: Duration(seconds: 3),
  //           backgroundColor: Colors.red,
  //           behavior: SnackBarBehavior.floating,
  //           margin: EdgeInsets.all(10),
  //           content: Text('Incorrect Credentials.'),
  //         ),
  //       );
  //     }
  //   }
  // }

  Future<void> signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    // Once signed in, return the UserCredential
    final sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.setBool(saveKeyName, true);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ScreenHome()));
  }
}
