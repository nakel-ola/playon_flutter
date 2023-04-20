import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../assets.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import 'widgets/widgets.dart';

final item = {
  "Home": Assets.recommendations.length,
  "Movies": Assets.movies.length,
  "Series": Assets.series.length,
};

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final state = context.read<HomeProvider>();
      state.updateOffset(controller.offset);

      final bool hasMore = state.videos.length != item[state.activeMenu];

      if (controller.position.maxScrollExtent == controller.offset && hasMore) {
        state.getData(type: state.activeMenu);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 60.0),
        child: const HomeAppBar(),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) {
          final List<ResponseItem> items = value.videos;
          final double height = screenSize.height - 60;
          return SingleChildScrollView(
            controller: controller,
            child: items.isNotEmpty
                ? Column(
                    children: [
                      Stack(
                        children: [
                          const SizedBox(height: 900),
                          BannerCard(content: items[0].results[0]),
                          Positioned(
                            bottom: -20.0,
                            child: ContentList(
                              key: ValueKey(items[0].name),
                              items: items[0].results,
                              title: items[0].name,
                            ),
                          ),
                        ],
                      ),
                      ...items
                          .skip(1)
                          .map(
                            (e) => ContentList(
                              key: ValueKey(e.name),
                              items: e.results,
                              title: e.name,
                              showMore: e.totalPages > e.page,
                              onSeeMoreTap: () {
                                String type = value.activeMenu == "Home"
                                    ? "Movies"
                                    : value.activeMenu;
                                value.updateCurrentPage(
                                  index: 2,
                                  args: {
                                    "type": type,
                                    "genre": e.name,
                                  },
                                );
                              },
                            ),
                          )
                          .toList(),
                      if (items.length != item[value.activeMenu])
                        const SizedBox(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      const SizedBox(height: 100),
                    ],
                  )
                : SizedBox(
                    height: height,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
          );
        },
      ),
    );
  }
}
