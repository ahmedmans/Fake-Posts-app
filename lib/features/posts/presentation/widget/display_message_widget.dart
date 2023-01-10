import 'package:flutter/material.dart';

class DisplayMessageWidget extends StatelessWidget {
  const DisplayMessageWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: SingleChildScrollView(
        child: Text(
          message,
          style: TextStyle(fontSize: 25.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
