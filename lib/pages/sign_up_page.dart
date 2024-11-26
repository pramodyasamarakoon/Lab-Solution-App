import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../widgets/app_title.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../widgets/navigation_link.dart';
import '../utils/validators.dart';
import 'sign_in_page.dart';
import 'google_sign_up_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for the input fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false; // To handle loading state

  // Handle sign up logic
  Future<void> handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      // Proceed with sign-up logic if validation is successful
      final fullName = fullNameController.text.trim();
      final email = emailController.text.trim();
      final mobile = mobileController.text.trim();
      final nic = nicController.text.trim();
      final password = passwordController.text.trim();

      setState(() {
        isLoading = true; // Show the loading spinner on the button
      });

      // Simulate an API call or async operation
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isLoading = false; // Hide the loading spinner
      });

      print('Sign Up with:');
      print('Full Name: $fullName');
      print('Email: $email');
      print('Mobile: $mobile');
      print('NIC: $nic');
      print('Password: $password');
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
                const AppTitle(title: 'Sign Up'),
                const SizedBox(height: 16),

                // Full Name Input
                CustomInput(
                  hintText: 'Full Name',
                  controller: fullNameController,
                  validator: Validators.validateFullName,
                ),
                const SizedBox(height: 8),

                // Email Input
                CustomInput(
                  hintText: 'Email Address',
                  controller: emailController,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 8),

                // Mobile Number Input
                CustomInput(
                  hintText: 'Mobile Number',
                  controller: mobileController,
                  validator: Validators.validateMobile,
                ),
                const SizedBox(height: 8),

                // NIC Input
                CustomInput(
                  hintText: 'NIC',
                  controller: nicController,
                  validator: Validators.validateNIC,
                ),
                const SizedBox(height: 8),

                // Password Input
                CustomInput(
                  hintText: 'Password',
                  isPassword: true,
                  controller: passwordController,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 8),

                // Confirm Password Input
                CustomInput(
                  hintText: 'Confirm Password',
                  isPassword: true,
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password is required.';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match.';
                    }
                    return null; // Valid input
                  },
                ),
                const SizedBox(height: 16),

                // Sign Up Button with loading state
                CustomButton(
                  text: 'Sign Up',
                  isLoading: isLoading, // Pass loading state to button
                  onPressed: handleSignUp,
                ),
                const SizedBox(height: 16),

                const Text(
                  'Or',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                const SizedBox(height: 16),

                // Continue with Google Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GoogleSignUpPage()),
                      );
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

                // Already Have an Account? Sign In Link
                NavigationLink(
                  normalText: "Already have an account?",
                  navigationText: "Log In",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Not Sure? Search Me Link
                NavigationLink(
                  normalText: "Not Sure?",
                  navigationText: "Search Me",
                  onTap: () {
                    // Navigate to a different page or action
                    print('Search Me tapped');
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
