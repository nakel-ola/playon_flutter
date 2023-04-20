import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final bool checked;
  final Function()? onTap;
  final Function()? onDeleted;

  const CustomChip({
    super.key,
    required this.label,
    this.checked = false,
    this.onTap,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = Theme.of(context).navigationBarTheme.backgroundColor!;
    Color color =
        checked ? Theme.of(context).colorScheme.primary : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Chip(
          label: Text(label, style: const TextStyle(fontSize: 18.0)),
          backgroundColor: bgColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          labelStyle: TextStyle(color: color),
          deleteIcon: const Icon(Icons.clear),
          onDeleted: onDeleted,
          avatar: checked
              ? Icon(Iconsax.tick_circle, size: 25.0, color: color)
              : null,
          side: BorderSide(color: color, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    );
  }
}
