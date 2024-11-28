import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart'; // Import the custom button
import '../Login Pages/sign_in_page.dart'; // Import the Sign In page

class SuccessPage extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  const SuccessPage({
    super.key,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Icon(
                Icons.check_circle_outline,
                size: 80,
                color: Colors.green, // Green icon
              ),
              const SizedBox(height: 24),
              
              // Success Message
              Text(
                message,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              
              // Custom Success Button
              CustomButton(
                text: 'Go to Login',
                isLoading: false, // No loading spinner for this button
                onPressed: onPressed,
                backgroundColor: Colors.green, // Button background color
                textColor: Colors.black, // Button text color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
