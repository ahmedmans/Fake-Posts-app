import 'package:flutter/material.dart';

class SnackBarMSG {
  void successMSG({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }

  void errorMSG({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
