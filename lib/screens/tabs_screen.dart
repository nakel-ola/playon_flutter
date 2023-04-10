import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';
import 'screens.dart' hide TabsScreen;

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(key: PageStorageKey('home_screen')),
    const ExploreScreen(key: PageStorageKey('explore_screen')),
    const CommunityScreen(key: PageStorageKey('community_screen')),
    const SettingScreen(key: PageStorageKey('setting_screen')),
  ];

  final List<Destination> _icons = [
    Destination(
      icon: Iconsax.home_2,
      label: "Home",
      selectedIcon: Iconsax.home_15,
    ),
    Destination(
      icon: Iconsax.discover_1,
      label: "Explore",
      selectedIcon: Iconsax.discover1,
    ),
    Destination(
      icon: Iconsax.people,
      label: "Community",
      selectedIcon: Iconsax.people5,
    ),
    Destination(
      icon: Icons.settings_outlined,
      label: "Setting",
      selectedIcon: Icons.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0.0, 0.0),
        child: AppBar(backgroundColor: Colors.transparent),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: DesktopNavigationRail(
        destinations: _icons,
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) {
          setState(() => _currentPageIndex = index);
        },
        child: _screens[_currentPageIndex],
      ),
      bottomNavigationBar: Responsive.isMobile(context)
          ? MobileNavigationBar(
              destinations: _icons,
              selectedIndex: _currentPageIndex,
              onDestinationSelected: (index) {
                setState(() => _currentPageIndex = index);
              },
            )
          : null,
    );
  }
}
