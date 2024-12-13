import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final bool isTextLeftAligned; 
  final bool showNumber; 
  final int number; 
  final Color? backgroundColor; 
  final Color? textColor; 

  const CustomButton({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPressed,
    this.isTextLeftAligned = false, 
    this.showNumber = false, 
    this.number = 0, 
    this.backgroundColor, 
    this.textColor, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full screen width
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF25D366), // Default WhatsApp green
          foregroundColor: textColor ?? Colors.black, // Default text color black
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Row(
                mainAxisAlignment: isTextLeftAligned
                    ? MainAxisAlignment.start // Align text to the left
                    : MainAxisAlignment.center, // Default, centered text
                children: [
                  if (showNumber)
                    Container(
                      margin: const EdgeInsets.only(right: 8), // Add space between number and text
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red, // Red background for the number circle
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$number',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? Colors.black, // Default text color
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
