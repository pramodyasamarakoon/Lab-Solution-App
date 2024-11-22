import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../utils/validators.dart';
import 'sign_in_page.dart';
import 'forgot_password_otp_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();

  bool isLoading = false; // State for button loader

  void handleVerify() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Show the loading spinner on the button
      });

      // Simulate an API call or async operation
      await Future.delayed(const Duration(seconds: 2));

      // Proceed after async operation completes
      final mobile = mobileController.text.trim();
      print('Mobile Verified: $mobile');

      setState(() {
        isLoading = false; // Hide the loading spinner
      });

      // Navigate to the OTP page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ForgotPasswordOTPPage()),
      );
    } else {
      print('Validation failed');
    }
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

                // Forgot Password Topic
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Instructional Text
                const Text(
                  'Enter the mobile phone number below to reset password',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Mobile Number Input
                CustomInput(
                  hintText: 'Mobile Number',
                  controller: mobileController,
                  validator: Validators.validateMobile, // Use mobile validation
                ),
                const SizedBox(height: 8),

                // Verify Button
                CustomButton(
                  text: 'Verify',
                  isLoading:
                      isLoading, // Reflect the loading state on the button
                  onPressed: isLoading ? null : handleVerify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
