import 'package:first_flutter_app/pages/MLT_home_page.dart';
import 'package:flutter/material.dart';
import 'pages/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In App',
      theme: ThemeData(
        primaryColor: const Color(0xFF25D366), // WhatsApp green color
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF25D366), // WhatsApp green color
          ),
        ),
      ),
      home: const MLTHomePage(),
    );
  }
}
