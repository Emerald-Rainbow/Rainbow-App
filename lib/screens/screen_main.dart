import 'package:flutter/material.dart';
import 'package:rainbow/widgets/card_posts.dart';

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
        padding: EdgeInsets.only(top: 5, left: 15, right: 15),
        child: Expanded(
          child: CardsPost(),
        ),
      ),
    );
  }
}
