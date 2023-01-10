import 'package:flutter/material.dart';
import 'package:posts_app/core/theme_app.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: secondaryColor,
        valueColor: AlwaysStoppedAnimation(primaryColor),
      ),
    );
  }
}
