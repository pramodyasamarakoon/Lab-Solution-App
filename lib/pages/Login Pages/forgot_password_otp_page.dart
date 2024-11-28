import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async'; // Import for Timer
import '../../widgets/app_logo.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/otp_input.dart';
import '../../widgets/navigation_link.dart';
import 'reset_password_page.dart';

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
  int remainingTime = 180; // 3 minutes (in seconds)
  String timerText = 'OTP expires in 3:00'; // Initialize directly

  // Timer variable to manage the countdown
  Timer? _timer;

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

      // Navigate to Reset Password Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
      );
    } else {
      print('Validation failed');
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer as soon as the page is loaded
  }

  // Method to start the timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
          timerText = formatTime(remainingTime); // Update the timer text
        });
      } else {
        _timer?.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return 'OTP expires in $minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    // Dispose of controllers and focus nodes
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel(); // Cancel the timer when the page is disposed
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
                const SizedBox(height: 24),

                // Navigation Link for Resend Code
                NavigationLink(
                  normalText: "Didn't get the code? ",
                  navigationText: "Resend Code",
                  onTap: () {
                    // Simulate Resend Code
                    print("Resend Code clicked.");
                  },
                ),
                const SizedBox(height: 24),

                // Timer Text
                Text(
                  timerText,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
