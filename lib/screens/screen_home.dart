import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rainbow/screens/screen_add.dart';
import 'package:rainbow/screens/screen_consult.dart';
import 'package:rainbow/screens/screen_login.dart';
import 'package:rainbow/screens/screen_main.dart';
import 'package:rainbow/screens/screen_profile.dart';
import 'package:rainbow/screens/screen_rooms.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatefulWidget {
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _selectedIndex = 0;
  final _pages = [
    ScreenMain(),
    ScreenAdd(),
    ScreenConsultation(),
    ScreenRooms(),
    ScreenProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          elevation: 0,
          title: Center(
            child: Image.asset(
              'assets/images/logo.jpg',
              width: 200,
            ),
          ),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety),
              label: 'Consultation',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hotel),
              label: 'Rooms',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
