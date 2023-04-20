import 'package:flutter/material.dart';

import '../../../assets.dart';
import '../../../models/models.dart';
import '../../../widgets/custom_chip.dart';
import '../../../widgets/custom_draggable_scrollable_sheet.dart';

class FilterCard extends StatefulWidget {
  final String selectedType;
  final String selectedGenre;
  final Function(String, String) onApply;

  const FilterCard({
    super.key,
    required this.selectedType,
    required this.selectedGenre,
    required this.onApply,
  });

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  String activeType = "";
  String activeGenre = "";

  @override
  void initState() {
    super.initState();

    setState(() {
      activeType = widget.selectedType;
      activeGenre = widget.selectedGenre;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> types = ["Movies", "Series"];
    List<Genre> items =
        activeType == "Movies" ? Assets.genres : Assets.seriesGenres;

    return SafeArea(
      child: CustomDraggableSheetSheet(
        builder: (_, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).navigationBarTheme.backgroundColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      height: 5.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[700]!,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Center(
                    child: Text(
                      "Filter",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      "Choose Video Type",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: types
                          .map(
                            (e) => CustomChip(
                              label: e,
                              checked: e == activeType,
                              onTap: () {
                                setState(() {
                                  activeType = e;
                                  activeGenre = "";
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      "Choose Genre",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: items
                          .map(
                            (e) => CustomChip(
                              label: e.name,
                              checked: e.name == activeGenre,
                              onTap: () {
                                setState(() {
                                  activeGenre = e.name;
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12.0),
                            ),
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              widget.onApply(activeType, activeGenre);
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(12.0),
                            ),
                            child: const Text("Apply"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
