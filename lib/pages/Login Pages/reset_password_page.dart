import 'package:flutter/material.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';
import '../../utils/validators.dart';
import '../Login Pages/sign_in_page.dart';
import '../../widgets/custom_success_popup.dart'; // Import the custom popup
import 'success_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  void handleResetPassword() async {
    if (_formKey.currentState!.validate()) {
      // Check if the passwords match
      if (newPasswordController.text.trim() ==
          confirmPasswordController.text.trim()) {
        setState(() {
          isLoading = true; // Show the loading spinner on the button
        });

        // Simulate an API call or async operation
        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          isLoading = false; // Hide the loading spinner
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessPage(
              message: 'Password has been changed successfully.',
              onPressed: () {
                // After success, navigate to the Login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
            ),
          ),
        );
      } else {
        // If passwords don't match, show a validation message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      }
    } else {
      print('Validation failed');
    }
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const AppLogo(),
                const SizedBox(height: 24),

                // Reset Password Topic
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Instructional Text
                const Text(
                  'Enter your new password and confirm it below.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // New Password Input
                CustomInput(
                  hintText: 'New Password',
                  controller: newPasswordController,
                  isPassword: true, // Use password visibility toggle
                  validator:
                      Validators.validatePassword, // Use password validation
                ),
                const SizedBox(height: 16),

                // Confirm Password Input
                CustomInput(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController,
                  isPassword: true, // Use password visibility toggle
                  validator: (value) {
                    if (value != newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Reset Password Button
                CustomButton(
                  text: 'Reset Password',
                  isLoading: isLoading,
                  onPressed: isLoading ? null : handleResetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
