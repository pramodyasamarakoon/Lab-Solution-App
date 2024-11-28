import 'package:flutter/material.dart';
import 'mlt_home_page.dart'; // Chat Page
import 'dashboard01_page.dart'; // Dashboard 01 Page
import 'dashboard02_page.dart'; // Dashboard 02 Page
import 'account_page.dart'; // Account Page
import '../widgets/custom_bottom_nav_bar.dart'; // Import the CustomBottomNavBar

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Track the selected index for navigation

  final List<Widget> _pages = [
    const MLTHomePage(), // Chat Page
    const Dashboard01Page(), // Dashboard 01
    const Dashboard02Page(), // Dashboard 02
    const AccountPage(), // Account Page
  ];

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current tab index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTapped,
      ),
    );
  }
}
