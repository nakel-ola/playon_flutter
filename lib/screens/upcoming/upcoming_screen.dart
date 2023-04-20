import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../widgets/infinite_list_view.dart';
import '../home/widgets/content_card.dart';
import 'widgets/widgets.dart';
import '../../assets.dart';
import '../../services/videos_service.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  VideosService services = VideosService();
  ApiResponse? data;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (data == null) fetchData();
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    ApiResponse item = await getData();

    setState(() {
      data = item;
      isLoading = false;
    });
  }

  fetchMore() async {
    if (data == null) return;

    ApiResponse item = await getData(page: data!.page + 1);

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

  getData({String type = "movie", int page = 1}) {
    final String url =
        "https://api.themoviedb.org/3/$type/upcoming?api_key=${Assets.apiKey}&language=en-US&page=$page";

    return services.fetchByCategory(url, type);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, 50),
        child: const CustomAppBar(),
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
