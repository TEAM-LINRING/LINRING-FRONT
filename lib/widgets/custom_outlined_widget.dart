import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  CustomOutlinedButton({
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        backgroundColor: backgroundColor,
        side: BorderSide.none,
        elevation: 5,
        shadowColor: Color(0x196C5916),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fixedSize: Size(350, 75),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
    );
  }
}
