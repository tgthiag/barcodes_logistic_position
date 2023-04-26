import 'package:flutter/material.dart';

class MyDialog {
  static void dialogAlert(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Atenção'),
          content: Text(text),
          actions: <Widget>[
        TextButton(
        child: Text('OK'),
        onPressed: () {
        Navigator.of(context).pop();
        },
        ),
          ],
        );
      },
    );
  }
}