import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:delta_markdown/delta_markdown.dart';
import 'package:markdown/markdown.dart' hide Text;
import 'package:rainbow/screens/screen_home.dart';
import 'package:jiffy/jiffy.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

String quillDeltaToHtml(QuillController delta) {
  final convertedValue = jsonEncode(delta.document.toDelta().toJson());
  final markdown = deltaToMarkdown(convertedValue);
  final html = markdownToHtml(markdown);
  return html;
}

// ignore: must_be_immutable
class ScreenAdd extends StatelessWidget {
  final _titleController = TextEditingController();
  final QuillController _controller = QuillController.basic();

  ScreenAdd({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: QuillToolbar.basic(
                controller: _controller,
                showFontFamily: false,
                showFontSize: false,
                showListCheck: false,
                showClearFormat: false,
                showCodeBlock: false,
                showBackgroundColorButton: false,
                showDirection: false,
                showIndent: false,
                showAlignmentButtons: false,
                showLeftAlignment: false,
                showRightAlignment: false,
                showUnderLineButton: false,
                showStrikeThrough: false,
                showCenterAlignment: false,
                showColorButton: false,
                showInlineCode: false,
                showVideoButton: false,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
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
                if (_titleController.text.isNotEmpty) {
                  addPost(context, _titleController.text, data);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(10),
                      content: Text('Title must be entered..'),
                    ),
                  );
                }
              },
              child: const Text("Add Post"),
            )
          ],
        ),
      ),
    );
  }
}

DateTime currentTime = DateTime.now();
String formattedDate = DateFormat('kk:mm').format(currentTime);
String result1 = Jiffy(currentTime).format('d MMM yyyy');
String date = result1.substring(4);

User? user = FirebaseAuth.instance.currentUser;
CollectionReference blogs = FirebaseFirestore.instance.collection('blogs');
Future<void> addPost(context, title, content) {
  var title2 = title;
  var content2 = content;
  var author = user!.displayName!;
  var authorPic = user!.photoURL!;
  var userId = user!.uid;
  var likes = 0;
  var createdAt = FieldValue.serverTimestamp();

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
            // ignore: avoid_print
            print(createdAt),
            // ignore: avoid_print
            print("Blog Added"),
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ScreenHome()))
          })
      // ignore: avoid_print, invalid_return_type_for_catch_error
      .catchError((error) => print("Failed to add blog.. $error"));
}
