import 'package:flutter/material.dart';
import 'package:posts_app/core/theme_app.dart';

class DisplayMessageWidget extends StatelessWidget {
  const DisplayMessageWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: MediaQuery.of(context).size.width * 0.2,
            color: primaryColor.withOpacity(0.5),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 25.0,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
