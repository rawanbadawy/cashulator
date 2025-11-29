import 'package:flutter/material.dart';

class KeypadButtonWidget extends StatelessWidget {
  const KeypadButtonWidget({
    super.key,
    required this.bgcolor,
    required this.frcolor,
    required this.content,
    this.onTap,
    this.width,
    this.height,
  });

  final Color bgcolor;
  final Color frcolor;
  final String content;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 74,
      height: height ?? 74,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor,
          foregroundColor: frcolor,
          padding: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
