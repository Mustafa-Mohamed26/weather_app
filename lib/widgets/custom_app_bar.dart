import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.blue.withOpacity(0.9), // Prevents unwanted transparency
      elevation: 0, // Removes shadow
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Custom height
}
