import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool isActive;

  const CustomOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isActive ? onPressed : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: isActive ? backgroundColor : const Color(0xffc8c8c8),
        side: BorderSide(
          width: 1,
          color: isActive ? const Color(0xFFC8AAAA) : const Color(0xffc8c8c8),
        ),
        elevation: 5,
        shadowColor: const Color(0x196C5916),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
