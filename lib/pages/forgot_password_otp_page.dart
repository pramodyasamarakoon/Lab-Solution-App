import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../widgets/custom_button.dart';
import '../widgets/otp_input.dart';
import 'sign_in_page.dart';

class ForgotPasswordOTPPage extends StatefulWidget {
  const ForgotPasswordOTPPage({super.key});

  @override
  _ForgotPasswordOTPPageState createState() => _ForgotPasswordOTPPageState();
}

class _ForgotPasswordOTPPageState extends State<ForgotPasswordOTPPage> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // Simulate OTP verification delay
      await Future.delayed(const Duration(seconds: 2));

      final otp = otpControllers.map((controller) => controller.text).join();
      print('OTP Submitted: $otp');

      setState(() {
        isLoading = false;
      });

      // Navigate to Sign In Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    } else {
      print('Validation failed');
    }
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
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
            Navigator.pop(context);
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
                const AppLogo(),
                const SizedBox(height: 24),
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter the 6-digit code sent to your mobile number.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return OTPInput(
                      controller: otpControllers[index],
                      focusNode: focusNodes[index],
                      nextFocusNode: index < 5 ? focusNodes[index + 1] : null,
                      previousFocusNode:
                          index > 0 ? focusNodes[index - 1] : null,
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // Submit Button
                CustomButton(
                  text: 'Submit',
                  isLoading: isLoading,
                  onPressed: isLoading ? null : handleSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
