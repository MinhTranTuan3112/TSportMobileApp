import 'package:flutter/material.dart';

class PopupUtils {
  static void showPopup(BuildContext widgetContext, String message,
      {String title = "Thông báo"}) {
    showDialog(
        context: widgetContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
