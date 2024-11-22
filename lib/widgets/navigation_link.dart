import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class NavigationLink extends StatelessWidget {
  final String normalText; // Non-clickable text
  final String navigationText; // Clickable text
  final VoidCallback onTap; // Action when clickable text is tapped
  final Alignment? alignment; // Optional alignment

  const NavigationLink({
    super.key,
    required this.normalText,
    required this.navigationText,
    required this.onTap,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center, // Default alignment
      child: RichText(
        text: TextSpan(
          text: normalText,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black, // Normal text color
            fontWeight: FontWeight.normal,
          ),
          children: [
            TextSpan(
              text: " $navigationText", // Clickable text
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blue, // Clickable text color
                fontWeight: FontWeight.bold,
                // decoration: TextDecoration.underline, // Optional underline
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = onTap, // Add tap handler
            ),
          ],
        ),
      ),
    );
  }
}
