import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatefulWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final TextEditingController controller;
  const CustomAppBar({
    super.key,
    required this.onChanged,
    required this.onSubmitted,
    required this.controller,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
      leading: IconButton(
        icon: const Icon(Iconsax.arrow_left),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: TextField(
        controller: widget.controller,
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        onSubmitted: (value) {
          setState(() {
            widget.onSubmitted(value);
          });
        },
        onChanged: (text) {
          setState(() {
            widget.onChanged(text);
          });
        },
        decoration: const InputDecoration(
          hintText: "Search movies...",
          border: InputBorder.none,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              textController.clear();
            });
          },
        ),
        const SizedBox(width: 8.0)
      ],
    );
  }
}
