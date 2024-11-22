import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../widgets/app_title.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../widgets/navigation_link.dart';
import '../utils/validators.dart';
import 'sign_in_page.dart';

class GoogleSignUpPage extends StatelessWidget {
  const GoogleSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    // Controllers for the input fields
    final TextEditingController mobileController = TextEditingController();
    final TextEditingController nicController = TextEditingController();

    // Handle sign up logic
    void handleSignUp() {
      if (_formKey.currentState!.validate()) {
        final mobile = mobileController.text.trim();
        final nic = nicController.text.trim();

        print('Google Sign Up with:');
        print('Mobile: $mobile');
        print('NIC: $nic');
      } else {
        print('Validation failed');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 60), // Add padding
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
                  validator: Validators
                      .validateMobile, // Use validator from Validators class
                ),
                const SizedBox(height: 8),

                // NIC Input
                CustomInput(
                  hintText: 'NIC',
                  controller: nicController,
                  validator: Validators
                      .validateNIC, // Use validator from Validators class
                ),
                const SizedBox(height: 16),

                // Sign Up Button
                CustomButton(
                  text: 'Sign Up',
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
