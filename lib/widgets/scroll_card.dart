import 'dart:ui';

import 'package:flutter/material.dart';

class ScrollCard extends StatelessWidget {
  final Widget child;
  const ScrollCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: child,
    );
  }
}
