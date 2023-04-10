import 'package:flutter/material.dart' show IconData;

class Destination {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  Destination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}
