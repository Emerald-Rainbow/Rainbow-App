import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:rainbow/main.dart';

class ScreenAdd extends StatelessWidget {
  QuillController _controller = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
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
                  addPost(_controller);
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

void addPost(QuillController _controller) {
  var json = jsonEncode(_controller.document.toDelta().toJson());
  print(json);
}
