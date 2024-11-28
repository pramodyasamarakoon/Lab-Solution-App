import 'package:flutter/material.dart';

class Dashboard01Page extends StatelessWidget {
  const Dashboard01Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard 01'),
      ),
      body: const Center(
        child: Text('Dashboard 01 Content'),
      ),
    );
  }
}
