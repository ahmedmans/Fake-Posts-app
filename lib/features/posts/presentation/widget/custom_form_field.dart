import 'package:flutter/material.dart';
import 'package:posts_app/core/theme_app.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.textContrller,
    required this.valText,
    this.isBody = false,
  }) : super(key: key);

  final TextEditingController textContrller;
  final String valText;

  final bool isBody;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: primaryColor,
        fontWeight: isBody ? FontWeight.normal : FontWeight.bold,
        fontSize: isBody ? 16 : 20,
      ),
      maxLines: isBody ? 6 : 2,
      minLines: isBody ? 2 : 1,
      controller: textContrller,
      validator: (value) => value!.isEmpty ? valText : null,
      decoration: InputDecoration(
        hintText: isBody ? "Post" : "Title",
        hintStyle: TextStyle(
          color: primaryColor.withOpacity(0.5),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: primaryColor,
                width: 2,
                strokeAlign: StrokeAlign.outside)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red, width: 2, strokeAlign: StrokeAlign.outside)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: secondaryColor,
                width: 2,
                strokeAlign: StrokeAlign.center)),
      ),
    );
  }
}
