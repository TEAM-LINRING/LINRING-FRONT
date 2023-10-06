import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final String? hintText;
  final bool obscureText;
  final Text? suffixText;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    required this.obscureText,
    decoration,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
      child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Color(0xFFC8AAAA)),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Color(0xFFC8AAAA)),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Align(
                alignment: Alignment.center,
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: suffixText,
              ),
            ),
          )),
    );
  }
}
