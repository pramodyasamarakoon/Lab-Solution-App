import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final bool showCallButton;
  final bool showMoreOptionsButton;
  final VoidCallback? onBackPress;
  final VoidCallback? onCallPress;
  final VoidCallback? onMoreOptionsPress;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.showCallButton = true,
    this.showMoreOptionsButton = true,
    this.onBackPress,
    this.onCallPress,
    this.onMoreOptionsPress,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBackPress ?? () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 20,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      actions: [
        if (showCallButton)
          IconButton(
            icon: const Icon(Icons.call, color: Colors.black),
            onPressed: onCallPress ??
                () {
                  print('Call button tapped');
                },
          ),
        if (showMoreOptionsButton)
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: onMoreOptionsPress ??
                () {
                  print('More options button tapped');
                },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight); // The preferred size for the AppBar
}
