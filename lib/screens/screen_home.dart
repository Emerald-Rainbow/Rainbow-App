import 'package:flutter/material.dart';
import 'package:rainbow/screens/screen_add.dart';
import 'package:rainbow/screens/screen_consult.dart';
import 'package:rainbow/screens/screen_main.dart';
import 'package:rainbow/screens/screen_profile.dart';
import 'package:rainbow/screens/screen_rooms.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _selectedIndex = 0;
  final _pages = [
    const ScreenMain(),
    ScreenAdd(),
    const ScreenConsultation(),
    const ScreenRooms(),
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
          centerTitle: true,
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          elevation: 0,
          title: Image.asset(
            'assets/images/logo.jpg',
            width: 200,
          ),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Post',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety),
              label: 'Consultation',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.hotel),
              label: 'Rooms',
            ),
            const BottomNavigationBarItem(
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
