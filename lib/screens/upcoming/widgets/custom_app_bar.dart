import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Upcoming",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
