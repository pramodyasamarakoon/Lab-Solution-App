import 'package:flutter/material.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/app_title.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/navigation_link.dart';
import '../../utils/validators.dart';
import 'forgot_password_page.dart';

class MLTSignInPage extends StatefulWidget {
  const MLTSignInPage({super.key});

  @override
  _MLTSignInPageState createState() => _MLTSignInPageState();
}

class _MLTSignInPageState extends State<MLTSignInPage> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false; // State to track button loading

  void handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Enable loading spinner
      });

      // Simulate async operation or API call
      await Future.delayed(const Duration(seconds: 2));

      final mobile = mobileController.text.trim();
      final password = passwordController.text.trim();
      print('Logging in with Mobile: $mobile and Password: $password');

      setState(() {
        isLoading = false; // Disable loading spinner
      });

      // Navigate to next page or handle login success
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
        elevation: 0, // Removes shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Form(
              key: _formKey, // Assign the form key here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogo(),
                  const SizedBox(height: 24),
                  const AppTitle(title: 'MLT Sign In'),
                  const SizedBox(height: 16),

                  // Mobile number input
                  CustomInput(
                    hintText: 'Mobile Number',
                    controller: mobileController,
                    validator: Validators.validateMobile,
                  ),
                  const SizedBox(height: 8),

                  // Password input
                  CustomInput(
                    hintText: 'Password',
                    isPassword: true,
                    controller: passwordController,
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 16),

                  // Forget password link
                  NavigationLink(
                    normalText: "Forget Password?",
                    navigationText: "Reset Password",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Login Button
                  CustomButton(
                    text: 'Log In',
                    isLoading: isLoading, // Show loading spinner
                    onPressed: isLoading
                        ? null
                        : handleLogin, // Disable during loading
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Or',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  const SizedBox(height: 16),

                  // Continue with Google button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        print('Continue with Google');
                      },
                      icon: Image.asset(
                        'assets/images/Google.png',
                        height: 20,
                        width: 20,
                      ),
                      label: const Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
