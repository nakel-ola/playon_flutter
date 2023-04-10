import 'package:flutter/material.dart';

import '../models/models.dart';



class MobileNavigationBar extends StatelessWidget {
  final List<Destination> destinations;
  final int selectedIndex;
  final void Function(int)? onDestinationSelected;

  const MobileNavigationBar({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: destinations
          .map(
            (e) => NavigationDestination(
              icon: Icon(e.icon, size: 25.0),
              label: e.label,
              selectedIcon: Icon(
                e.selectedIcon,
                size: 25.0,
              ),
            ),
          )
          .toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
