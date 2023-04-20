import 'package:flutter/material.dart';

class CustomDraggableSheetSheet extends StatelessWidget {
  final Widget Function(BuildContext, ScrollController) builder;
  const CustomDraggableSheetSheet({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: DraggableScrollableSheet(
        builder: (BuildContext context, scrollController) {
          return GestureDetector(
            onTap: () {},
            child: builder(context, scrollController),
          );
        },
      ),
    );
  }
}
