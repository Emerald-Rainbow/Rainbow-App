import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:delta_markdown/delta_markdown.dart';
import 'package:markdown/markdown.dart' hide Text;
import 'package:rainbow/screens/screen_home.dart';

String quillDeltaToHtml(QuillController delta) {
  final convertedValue = jsonEncode(delta.document.toDelta().toJson());
  final markdown = deltaToMarkdown(convertedValue);
  final html = markdownToHtml(markdown);
  return html;
}

class ScreenAdd extends StatelessWidget {
  final _titleController = TextEditingController();
  QuillController _controller = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              QuillToolbar.basic(controller: _controller),
              Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: QuillEditor.basic(
                      controller: _controller,
                      readOnly: false,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  var data = quillDeltaToHtml(_controller);
                  addPost(context, _titleController.text, data);
                },
                child: Text("Add Post"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

User? user = FirebaseAuth.instance.currentUser;
CollectionReference blogs = FirebaseFirestore.instance.collection('blogs');
Future<void> addPost(context, title, content) {
  var title2 = title;
  var content2 = content;
  var author = user!.displayName!;
  var authorPic = user!.photoURL!;
  var userId = user!.uid;
  var likes = 0;
  var createdAt = DateTime.now().toString();
  print(title2);
  print(content2);
  print(author);
  print(authorPic);
  print(userId);
  print(likes);
  print(createdAt);
  return blogs
      .add({
        'title': title2,
        'content': content2,
        'author': author,
        'authorPic': authorPic,
        'userId': userId,
        'likes': likes,
        'createdAt': createdAt,
      })
      .then((value) => {
            print("Blog Added"),
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ScreenHome()))
          })
      .catchError((error) => print("Failed to add user: $error"));
}
