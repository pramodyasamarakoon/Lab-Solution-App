import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isActive; // To determine if the button is active

  const FilterButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isActive = false, // Default to false if not specified
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0), // Spacing between buttons
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive
              ? const Color.fromARGB(255, 2, 94, 35) // Dark green for active button (WhatsApp green)
              : Colors.black45, // Default grey for inactive button
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 4), // Adjust padding for button height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12, // Slightly increase the font size if needed
            color: !isActive
                ? Colors.white
                : const Color(
                    0xFF25D366), // Green text for active button, grey for inactive
          ),
        ),
      ),
    );
  }
}
