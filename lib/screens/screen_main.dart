import 'package:flutter/material.dart';
import 'package:rainbow/widgets/card_posts.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({Key? key}) : super(key: key);
  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  bool pressAttention = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Expanded(
              child: CardsPost(),
            ),
          ],
        ),
      ),
    );
  }
}
