import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color? backgroundColor; // Optional parameter for background color
  final Color? textColor; // Optional parameter for text color

  const CustomButton({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPressed,
    this.backgroundColor, // Default null, will use default color
    this.textColor, // Default null, will use default color
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full screen width
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ??
              const Color(0xFF25D366), // WhatsApp green color
          foregroundColor:
              textColor ?? Colors.black, // Default text color black
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(text),
      ),
    );
  }
}
