import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../widgets/app_title.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../widgets/navigation_link.dart';
import '../utils/validators.dart';
import 'sign_in_page.dart';

class GoogleSignUpPage extends StatefulWidget {
  const GoogleSignUpPage({super.key});

  @override
  _GoogleSignUpPageState createState() => _GoogleSignUpPageState();
}

class _GoogleSignUpPageState extends State<GoogleSignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for the input fields
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nicController = TextEditingController();

  bool isLoading = false; // State for the button loader

  // Handle sign up logic
  Future<void> handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      final mobile = mobileController.text.trim();
      final nic = nicController.text.trim();

      setState(() {
        isLoading = true; // Show loading spinner on the button
      });

      // Simulate API call or async operation
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isLoading = false; // Hide loading spinner after the operation
      });

      print('Google Sign Up with:');
      print('Mobile: $mobile');
      print('NIC: $nic');
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
                const AppTitle(title: 'Google Sign Up'),
                const SizedBox(height: 16),

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
                const SizedBox(height: 16),

                // Sign Up Button with loading state
                CustomButton(
                  text: 'Sign Up',
                  isLoading: isLoading, // Pass loading state to the button
                  onPressed: handleSignUp,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
