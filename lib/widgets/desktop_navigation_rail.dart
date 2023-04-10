import 'package:flutter/material.dart';

import '../models/models.dart';
import 'responsive.dart';

class DesktopNavigationRail extends StatelessWidget {
  final List<Destination> destinations;
  final int selectedIndex;
  final void Function(int)? onDestinationSelected;
  final Widget child;

  const DesktopNavigationRail({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    this.onDestinationSelected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (Responsive.isTablet(context) || Responsive.isDesktop(context))
          NavigationRail(
            destinations: destinations
                .map(
                  (e) => NavigationRailDestination(
                    padding: const EdgeInsets.all(12.0),
                    icon: Icon(e.icon, size: 25.0),
                    label: Text(e.label),
                    selectedIcon: Icon(
                      e.selectedIcon,
                      size: 25.0,
                    ),
                  ),
                )
                .toList(),
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            groupAlignment: 0.0,
            leading: Image.asset("assets/logo.png", width: 40),
            trailing: const SizedBox(width: 40.0, height: 40.0),
            minWidth: 40,
            useIndicator: true,
          ),
        Expanded(child: child)
      ],
    );
  }
}
