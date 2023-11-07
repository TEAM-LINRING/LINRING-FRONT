import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onPressed;
  final String? errorText;
  final String? helperText;
  final EdgeInsets? padding;
  final int? textLimit;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    required this.obscureText,
    decoration,
    this.suffixIcon,
    this.onChanged,
    this.errorText,
    this.onPressed,
    this.helperText,
    this.padding,
    this.textLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding ?? const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
                maxLength: textLimit,
                controller: controller,
                obscureText: obscureText,
                onChanged: onChanged,
                decoration: InputDecoration(
                  errorText: errorText,
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFFC8AAAA)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFFC8AAAA)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFFC8AAAA)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorStyle: const TextStyle(
                    height: 0.7,
                  ),
                  helperStyle: const TextStyle(
                      height: 0.7,
                      color: Color.fromARGB(255, 0, 64, 255),
                      fontWeight: FontWeight.w400),
                  contentPadding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFFC8AAAA)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: hintText,
                  suffixIcon: suffixIcon,
                  helperText: helperText ?? ' ',
                )),
            if (errorText != null)
              Positioned(
                bottom: -30,
                left: 20,
                child: Text(
                  errorText!,
                  style: const TextStyle(color: Colors.red, height: 0),
                ),
              ),
          ],
        ));
  }
}
