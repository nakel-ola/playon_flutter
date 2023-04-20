import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart';
import '../../widgets/infinite_list_view.dart';
import '../home/widgets/content_card.dart';
import 'widgets/widgets.dart';
import '../../services/videos_service.dart';
import '../../assets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final textController = TextEditingController();
  VideosService service = VideosService();
  String value = "";
  bool isLoading = false;
  ApiResponse? data;
  List<String> history = [];

  @override
  void initState() {
    super.initState();

    getHistory();
  }

  updateHistory(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> newHistory = [...history, query];

    setState(() {
      history = newHistory;
    });

    prefs.setString("history", jsonEncode(newHistory));
  }

  getHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storeHistory = prefs.getString("history");

    final List<dynamic> items =
        storeHistory != null ? jsonDecode(storeHistory) : [];

    setState(() {
      history = items.map((e) => '$e').toList();
    });
  }

  onHistoryDelete(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    history.removeWhere((e) => e == query);
    setState(() {
      history = history;
    });
    prefs.setString("history", jsonEncode(history));
  }

  onSubmitted({required String query, bool update = true}) async {
    setState(() {
      isLoading = true;
    });

    if (update) updateHistory(query);

    final item = await getData(query: query);

    setState(() {
      isLoading = false;
      data = item;
    });
  }

  fetchMore() async {
    if (data == null) return;

    ApiResponse item = await getData(query: value, page: data!.page + 1);

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

  Future<ApiResponse> getData({required String query, int page = 1}) async {
    final String url =
        "https://api.themoviedb.org/3/search/multi?api_key=${Assets.apiKey}&language=en-US&page=$page&include_adult=false&query=$query";

    return await service.fetchByCategory(url, null);
  }

  onHistoryTap(String query) {
    setState(() {
      textController.text = query;
    });
    onSubmitted(query: query, update: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, 60),
        child: CustomAppBar(
          controller: textController,
          onChanged: (val) {
            setState(() {
              value = val;
            });
          },
          onSubmitted: (_) {
            PageStorage.of(context).writeState(context, null);
            onSubmitted(query: value);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: () {
          if (isLoading) {
            return SizedBox(
              height: size.height - 200,
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          if (!isLoading && data != null) {
            return ContentBody(
              items: data!.results,
              fetchMore: fetchMore,
              hasMore: data!.page < data!.totalPages,
            );
          }

          return history.isNotEmpty
              ? HistoryCard(
                  history: history,
                  onDelete: onHistoryDelete,
                  onTap: onHistoryTap,
                )
              : const SizedBox.shrink();
        }(),
      ),
    );
  }
}

class ContentBody extends StatelessWidget {
  final Function() fetchMore;
  final bool hasMore;
  final List<Video> items;
  const ContentBody({
    super.key,
    required this.fetchMore,
    required this.hasMore,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      padding: const EdgeInsets.only(top: 16, bottom: 100),
      child: InfiniteListView(
        fetchMore: fetchMore,
        hasMore: hasMore,
        children: items
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
    );
  }
}
