import 'package:flutter/material.dart';
import 'package:first_flutter_app/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex; // The currently selected tab index
  final ValueChanged<int> onTap; // Callback for tab change

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed, // Keep all items visible
      selectedItemColor: AppColors.primaryColor, // Active tab color
      unselectedItemColor: Colors.black, // Inactive tab color
      backgroundColor: Colors.white, // Background color of the navigation bar
      iconSize: 30.0, // Adjust icon size for vertical padding effect
      selectedLabelStyle: TextStyle(
        fontSize: 12, // Adjust text size for label
        height: 1.5, // Adjust vertical padding for label text
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12, // Adjust text size for label
        height: 1.5, // Adjust vertical padding for label text
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard 01',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Dashboard 02',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
      ],
    );
  }
}
