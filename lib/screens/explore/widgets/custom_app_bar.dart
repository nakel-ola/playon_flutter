import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget {
  final Function() onFilterPressed;
  final String selectedGenre;

  const CustomAppBar({
    super.key,
    required this.onFilterPressed,
    required this.selectedGenre,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        selectedGenre,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onFilterPressed,
          icon: const Icon(Iconsax.filter, color: Colors.white),
          style: IconButton.styleFrom(backgroundColor: Colors.white10),
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }
}
