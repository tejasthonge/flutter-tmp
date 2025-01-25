import 'package:flutter/material.dart';

class AppSnackBar {
  static SnackBar create({
    required String message,
    Color? color,
  }) {
    return SnackBar(
      backgroundColor: color ?? Colors.black, // Default color is black
      content: Text(
        message,
        style: TextStyle(color: Colors.white), // Make text white by default
      ),
    );
  }
}

// Usage example
void getAppSankBar({required BuildContext context,required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    AppSnackBar.create(message: message), // Use the factory method to create SnackBar
  );
}
