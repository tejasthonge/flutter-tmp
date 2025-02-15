import 'package:flutter/material.dart';

class AppSnackBar {
  static SnackBar create({
    required String message,
    Color? color,
  }) {
    return SnackBar(
      backgroundColor: color ?? Colors.black,
      content: Text(
        message,
        style: TextStyle(color: Colors.white),

      ),
    );
  } 

}

void getAppSankBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    AppSnackBar.create(message: message),
  );
}

