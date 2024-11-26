import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../widgets/app_title.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../widgets/navigation_link.dart';
import '../utils/validators.dart';
import 'sign_up_page.dart';
import 'mlt_sign_in_page.dart';
import 'forgot_password_page.dart';
import 'MLT_home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false; // State to track loading

  void handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Show the loading spinner on the button
      });

      // Simulate API call or async login process
      await Future.delayed(const Duration(seconds: 2));

      // Proceed with login logic after async process completes
      final mobile = mobileController.text.trim();
      final password = passwordController.text.trim();
      print('Logging in with Mobile: $mobile and Password: $password');

      setState(() {
        isLoading = false; // Hide the loading spinner after processing
      });

      // Navigate to the Home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MLTHomePage()),
      );
    } else {
      print('Validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(),
                const SizedBox(height: 24),
                const AppTitle(title: 'Sign In'),
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
                          builder: (context) => const ForgotPasswordPage()),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Login Button
                CustomButton(
                  text: 'Log In',
                  isLoading: isLoading,
                  onPressed: isLoading
                      ? null // Disable the button when loading
                      : handleLogin, // Pass the function directly
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

                // Sign Up Navigation Link
                NavigationLink(
                  normalText: "Don't have an account?",
                  navigationText: "Sign Up",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                ),

                const SizedBox(height: 8),
                // Search Me Navigation Link
                NavigationLink(
                  normalText: "Not Sure?",
                  navigationText: "Search Me",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                ),

                const SizedBox(height: 8),
                // MLT Login Navigation Link
                NavigationLink(
                  normalText: "MLT?",
                  navigationText: "Log Here",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MLTSignInPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
