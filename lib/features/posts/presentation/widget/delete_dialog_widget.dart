import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/theme_app.dart';

import '../bloc/post_options_bloc/post_options_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  const DeleteDialogWidget({super.key, required this.postId});
  final int postId;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.warning_amber_rounded,
        size: 60,
      ),
      iconPadding: const EdgeInsets.all(10),
      iconColor: Colors.red,
      content: const Text("Are You Sure, Delete This Post !!"),
      contentTextStyle: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        MaterialButton(
          color: primaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "No",
            style: TextStyle(
              color: secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MaterialButton(
          color: primaryColor,
          onPressed: () {
            BlocProvider.of<PostOptionsBloc>(context)
                .add(DeletePostEvent(postId: postId));
          },
          child: Text(
            "Yas",
            style: TextStyle(
              color: secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
