import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../assets.dart';
import '../../models/models.dart';
import '../../providers/home_provider.dart';
import '../../widgets/infinite_list_view.dart';
import '../home/widgets/content_card.dart';
import 'services.dart';
import 'widgets/widgets.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Services services = Services();
  String selectedType = "Movies";
  String selectedGenre = Assets.genres[0].name;
  ApiResponse? data;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (data == null) {
      Map<String, String>? pageArgs = context.read<HomeProvider>().pageArgs;
      String type = pageArgs != null ? pageArgs["type"]! : selectedType;
      String genre = pageArgs != null ? pageArgs["genre"]! : selectedGenre;

      setState(() {
        selectedType = type;
        selectedGenre = genre;
      });

      getData(type, genre);
    }
  }

  getData(String type, String genre) async {
    setState(() {
      isLoading = true;
    });
    ApiResponse item = await services.getData(type: type, genre: genre);

    setState(() {
      data = item;
      isLoading = false;
    });
  }

  fetchMore() async {
    if (data == null) return;

    ApiResponse item = await services.getData(
        type: selectedType, genre: selectedGenre, page: data!.page + 1);

    ApiResponse newData = ApiResponse(
      page: item.page,
      totalPages: item.totalPages,
      totalResults: item.totalResults,
      results: [...data!.results, ...item.results],
    );

    setState(() {
      data = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    onFilterPressed() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black26,
        useSafeArea: true,
        builder: (_) {
          return FilterCard(
            selectedGenre: selectedGenre,
            selectedType: selectedType,
            onApply: (type, genre) {
              PageStorage.of(context).writeState(context, null);
              getData(type, genre);
              setState(() {
                selectedType = type;
                selectedGenre = genre;
              });
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, 50),
        child: CustomAppBar(
          onFilterPressed: onFilterPressed,
          selectedGenre: selectedGenre,
        ),
      ),
      body: SingleChildScrollView(
        child: !isLoading && data != null
            ? Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.only(top: 16, bottom: 100),
                child: InfiniteListView(
                  fetchMore: fetchMore,
                  hasMore: data!.page < data!.totalPages,
                  children: data!.results
                      .map(
                        (e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ContentCard(
                              content: e,
                              width: size.width * 0.9,
                            ),
                            const SizedBox(height: 24.0)
                          ],
                        ),
                      )
                      .toList(),
                ),
              )
            : SizedBox(
                height: size.height - 200,
                child: const Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}
