import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isObscureText;
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.keyboardType = TextInputType.name,
      this.isObscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is missing.';
        } else {
          return null;
        }
      },
      obscureText: isObscureText,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
