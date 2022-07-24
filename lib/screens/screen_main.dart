import 'package:flutter/material.dart';

class ScreenMain extends StatefulWidget {
  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  bool pressAttention = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Text('Main Page'),
      ),
    );
  }
}
