import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rainbow/screens/screen_home.dart';
import 'package:rainbow/widgets/card_posts.dart';

class ScreenPost extends StatelessWidget {
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
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      title1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    author1,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Html(
                    data: content1,
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
  print(title1);
  print(author1);
  print(content1);
}

void gotoMainPage(context) {
  Navigator.pop(context);
}
