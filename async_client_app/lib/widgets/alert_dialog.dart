import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  MyDialog({Key? key, required this.title, required this.content})
      : super(key: key);

  late String title;
  late String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close."),
        ),
      ],
    );
  }
}
