import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

import '../providers/home_provider.dart';
import '../widgets/widgets.dart';
import 'screens.dart' hide TabsScreen;

final List<Widget> _screens = [
  const HomeScreen(key: PageStorageKey('home_screen')),
  const SearchScreen(key: PageStorageKey('search_screen')),
  const ExploreScreen(key: PageStorageKey('explore_screen')),
  const UpcomingScreen(key: PageStorageKey('upcoming_screen')),
];

final List<Destination> _icons = [
  Destination(
    icon: Iconsax.home_2,
    label: "Home",
    selectedIcon: Iconsax.home_15,
  ),
  Destination(
    icon: Iconsax.search_normal_1,
    label: "Search",
    selectedIcon: Iconsax.search_normal_1,
  ),
  Destination(
    icon: Iconsax.discover_1,
    label: "Explore",
    selectedIcon: Iconsax.discover1,
  ),
  Destination(
    icon: Iconsax.timer,
    label: "Upcoming",
    selectedIcon: Iconsax.timer,
  ),
];

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider state = context.watch<HomeProvider>();
    onSelected(int index) {
      if (index == 1) {
        Navigator.of(context).pushNamed("/search");
      } else {
        context.read<HomeProvider>().updateCurrentPage(index: index);
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0.0, 0.0),
        child: AppBar(backgroundColor: Colors.transparent),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: DesktopNavigationRail(
        destinations: _icons,
        selectedIndex: state.currentPageIndex,
        onDestinationSelected: onSelected,
        child: _screens[state.currentPageIndex],
      ),
      bottomNavigationBar: Responsive.isMobile(context)
          ? MobileNavigationBar(
              destinations: _icons,
              selectedIndex: state.currentPageIndex,
              onDestinationSelected: onSelected,
            )
          : null,
    );
  }
}
