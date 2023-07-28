// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:url_launcher/url_launcher.dart';

class ScreenPost extends StatelessWidget {
  const ScreenPost({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoMainPage(context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.home),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      title1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    author1,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Html(
                    data: content1,
                    // onLinkTap: (url, _, __, ___) async {
                    //   // ignore: deprecated_member_use
                    //   if (await canLaunch(url!)) {
                    //     // ignore: deprecated_member_use
                    //     await launch(
                    //       url,
                    //     );
                    //   }
                    // },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

var title1, content1, author1;
void getdata(title, author, content) {
  title1 = title;
  author1 = author;
  content1 = content;
}

void gotoMainPage(context) {
  Navigator.pop(context);
}
