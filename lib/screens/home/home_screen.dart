import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';
import 'home_container.dart';
import 'services.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController? _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.read<HomeProvider>().updateOffset(_scrollController!.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Services services = Services();
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 60.0),
        child: const HomeAppBar(),
      ),
      body: SingleChildScrollView(
        // controller: _scrollController,
        child: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return FutureBuilder<List<ResponseItem>>(
              future: services.getData(type: value.activeMenu),
              builder: (_, snapshot) {
                if(snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  return HomeContainer(items: snapshot.data!);
                }

                return SizedBox(
                  height: screenSize.height,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
