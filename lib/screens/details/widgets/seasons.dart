import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../assets.dart';
import '../../../models/video.dart';
import '../../../services/videos_service.dart';
import '../../../widgets/scroll_card.dart';
import '../../home/widgets/content_card.dart';

class Seasons extends StatefulWidget {
  final dynamic id;

  const Seasons({super.key, this.id});

  @override
  State<Seasons> createState() => _SeasonsState();
}

class _SeasonsState extends State<Seasons> {
  VideosService services = VideosService();

  int numberOfSeasons = 0;
  int dropdownValue = 1;
  Map<int, List<Video>> seasons = {};

  @override
  void initState() {
    super.initState();

    getSeasonNumbers(widget.id);

    final List<List<Video>> items =
        List.generate(numberOfSeasons, (index) => []);

    setState(() {
      Map.from(seasons).addAll(items.asMap());
    });

    getSeasonData(widget.id, 1);
  }

  getSeasonNumbers(dynamic id) async {
    try {
      final String url =
          "${Assets.baseUrl}tv/$id?api_key=${Assets.apiKey}&language=en-US";

      final res = await Dio().get(url);

      setState(() {
        numberOfSeasons = res.data["number_of_seasons"];
      });
    } catch (e) {
      // print(e);
    }
  }

  getSeasonData(dynamic id, int season) async {
    try {
      final String url =
          "${Assets.baseUrl}tv/$id/season/$season?api_key=${Assets.apiKey}&language=en-US";

      final res = await Dio().get(url);
      final episodes = res.data["episodes"] as List;

      final List<Video> data = episodes
          .map(
            (e) => Video(
              id: e["id"],
              type: "tv",
              title: e["name"],
              description: e["overview"],
              voteAverage: e["vote_average"],
              backdropPath: e["still_path"],
            ),
          )
          .toList();

      setState(() {
        seasons[season] = data;
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (numberOfSeasons == 0) return const SizedBox.shrink();

    final List<Video> items = seasons[dropdownValue] ?? [];

    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 8.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        children: [
          SeasonHeader(
            length: numberOfSeasons,
            value: dropdownValue,
            onChanged: (int? value) {
              setState(() {
                dropdownValue = value!;
              });
              getSeasonData(widget.id, value!);
            },
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 300.0,
            child: items.isNotEmpty
                ? ScrollCard(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(width: 16.0),
                        ...items
                            .map(
                              (e) => Row(
                                children: [
                                  ContentCard(
                                    key: ValueKey(e.id),
                                    content: e,
                                  ),
                                  const SizedBox(width: 16.0)
                                ],
                              ),
                            )
                            .toList(),
                        const SizedBox(width: 16.0),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}

class SeasonHeader extends StatelessWidget {
  final int value, length;
  final Function(int?)? onChanged;

  const SeasonHeader({
    super.key,
    required this.value,
    required this.length,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Seasons",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButton<int>(
            value: value,
            underline: const SizedBox.shrink(),
            items: [
              ...List.generate(
                length,
                (index) => DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text("Season ${index + 1}"),
                ),
              ).toList(),
            ],
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
