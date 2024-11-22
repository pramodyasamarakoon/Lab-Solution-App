import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height;
  final double width;

  const AppLogo({super.key, this.height = 100, this.width = 100});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/Logo.png',
      height: height,
      width: width,
    );
  }
}
